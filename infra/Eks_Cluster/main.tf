module "aws-vpc" {
    source = "./Modules/01_aws_vpc"
    cidr_block              = var.cidr_block
    enable_dns_hostnames    = var.enable_dns_hostnames
    enable_dns_support      = var.enable_dns_support
    tags                    = var.tags
}

module "aws-subnet-1a" {
    source                      = "./Modules/02_aws_subnet"
    vpc_id                      = module.aws-vpc.vpc_id
    public_subnet_cidr_block    = var.public_subnet_cidr_block[0]
    private_subnet_cidr_block   = var.private_subnet_cidr_block[0]
    availability_zone           = var.availability_zone[0]
    tags                        = var.tags
}

module "aws-subnet-1b" {
    source                      = "./Modules/02_aws_subnet"
    vpc_id                      = module.aws-vpc.vpc_id
    public_subnet_cidr_block    = var.public_subnet_cidr_block[1]
    private_subnet_cidr_block   = var.private_subnet_cidr_block[1]
    availability_zone           = var.availability_zone[1]
    tags                        = var.tags
}

module "aws-igw" {
    source      = "./Modules/03_aws_igw"
    vpc_id      = module.aws-vpc.vpc_id
    tags        = var.tags
}

module "aws-nat" {
    source              = "./Modules/04_aws_nat"
    vpc_id              = module.aws-vpc.vpc_id
    public_subnet_1b_id = module.aws-subnet-1b.public_subnet_id
    tags                = var.tags
}

module "vpc-route-table" {
    source              = "./Modules/05_aws_route"
    vpc_id              = module.aws-vpc.vpc_id
    internet_gateway_id = module.aws-igw.internet_gateway_id
    nat_gateway_id      = module.aws-nat.nat_gateway_id
    public_subnet_ids   = [module.aws-subnet-1a.public_subnet_id, module.aws-subnet-1b.public_subnet_id]  
    private_subnet_ids  = [module.aws-subnet-1a.private_subnet_id, module.aws-subnet-1b.private_subnet_id]
    tags                = var.tags
}

module "prefix_list" {
    source              = "./Modules/06_aws_prefix-list"
    jenkins_vpc_cidr    = var.jenkins_vpc_cidr
    eks_vpc_cidr        = var.eks_vpc_cidr
    ec2_vpc_cidr        = var.ec2_vpc_cidr
    My_computer_ip      = var.My_computer_ip
}

module "aws-security-group" {
    source                      = "./Modules/07_aws_security_groups"
    cluster_name                = var.cluster_name
    eks_cluster_cidr_blocks     = var.cidr_block
    My_computer_ip              = var.My_computer_ip   
    vpc_id                      = module.aws-vpc.vpc_id
    prefix_list_ids             = module.prefix_list.eks_prefix_list_id
    tags                        = var.tags 
}

module "iam-roles" {
    source = "./Modules/08_aws_iam_roles"
    cluster_role_name            = var.cluster_role_name
    cluster_role_policy_arns     = [
        "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
        "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
    ]
    worker_node_role_name        = var.worker_node_role_name
    worker_node_role_policy_arns = [
        "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
        "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
        "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
        "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
    ]
}

module "key-pair" {
    source      = "./Modules/09_aws_key_pair"
    key_name = var.key_name 
}

module "Jump-Server" {
    source = "./Modules/10_aws_ec2"
    instance_type               = var.instance_types[0]
    key_name                    = module.key-pair.key_name
    subnet_id                   = module.aws-subnet-1a.public_subnet_id
    security_groups_id          = [module.aws-security-group.public_sg_id]
    associate_public_ip_address = true
    name                        = "Jump-Server"
}

module "eks-cluster" {
    source = "./Modules/11_aws_eks"
    cluster_name            = var.cluster_name
    eks_cluster_role_arn    = module.iam-roles.eks_cluster_role_arn
    kubernetes_version      = var.kubernetes_version
    private_subnet_ids      = [module.aws-subnet-1a.private_subnet_id, module.aws-subnet-1b.private_subnet_id]
    control_plane_sg_id     = module.aws-security-group.control_plane_sg_id
    tags                    = var.tags
}

module "eks-worker-node" {
    source = "./Modules/12_aws_worker_nodes"
    cluster_name                = var.cluster_name
    node_group_name             = var.node_group_name
    eks_worker_node_role_arn    = module.iam-roles.eks_worker_node_role_arn
    private_subnet_ids          = [module.aws-subnet-1a.private_subnet_id, module.aws-subnet-1b.private_subnet_id]
    instance_types              = var.instance_types[1]
    ami_type                    = var.ami_type
    disk_size                   = var.disk_size
    desired_size                = var.desired_size
    min_size                    = var.min_size
    max_size                    = var.max_size
    max_unavailable             = var.max_unavailable
    ec2_ssh_key                 = module.key-pair.key_name
    worker_node_sg_id           = module.aws-security-group.worker_node_sg_id
    depends_on                  = [module.eks-cluster]
}

module "ebs-csi-driver" {
    source                  = "./Modules/13_aws_addons"
    cluster_name            = var.cluster_name
    depends_on              = [ module.eks-worker-node ]
}

