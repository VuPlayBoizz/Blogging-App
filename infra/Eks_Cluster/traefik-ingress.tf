##################################################
# NGINX INGRESS CONTROLLER - HELM INSTALLATION
##################################################

# Lấy token xác thực cho Kubernetes cluster
data "aws_eks_cluster_auth" "eks" {
  name = module.eks-cluster.cluster_name
}

# Provider Kubernetes kết nối tới EKS cluster
provider "kubernetes" {
  host                   = module.eks-cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks-cluster.cluster_ca)
  token                  = data.aws_eks_cluster_auth.eks.token
}

# Provider Helm kết nối tới EKS cluster
provider "helm" {
  kubernetes {
    host                   = module.eks-cluster.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks-cluster.cluster_ca)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}

# Triển khai traefik ingress controller thông qua Helm chart
resource "helm_release" "traefik_ingress" {
  name       = "traefik-ingress"
  repository = "https://helm.traefik.io/traefik"
  chart      = "traefik"
  namespace  = "traefik"

  create_namespace = true

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }
  depends_on = [
    module.eks-cluster,
    module.eks-worker-node
  ]
}

