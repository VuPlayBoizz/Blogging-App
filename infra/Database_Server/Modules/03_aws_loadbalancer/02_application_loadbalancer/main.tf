resource "aws_lb" "jenkins_loadbalancer" {
    name               = var.lb_name
    internal           = var.is_external
    load_balancer_type = var.lb_type
    security_groups    = [var.sg_enable_ssh_https]
    subnets            = var.subnet_ids

    enable_deletion_protection = false

    tags                    = merge(var.tags, { Name = "${var.tags["Name"]}-alb"})
}

resource "aws_lb_listener" "jenkins_loadbalancer_listner" {
    load_balancer_arn = aws_lb.jenkins_loadbalancer.arn
    port              = var.lb_listner_port
    protocol          = var.lb_listner_protocol

    default_action {
        type             = var.lb_listner_default_action
        target_group_arn = var.lb_target_group_arn
    }
}

# https listner on port 443
resource "aws_lb_listener" "jenkins_loadbalancer_https_listner" {
    load_balancer_arn = aws_lb.jenkins_loadbalancer.arn
    port              = var.lb_https_listner_port
    protocol          = var.lb_https_listner_protocol
    ssl_policy        = "ELBSecurityPolicy-FS-1-2-Res-2019-08"
    certificate_arn   = var.devops_project_acm_arn

    default_action {
        type             = var.lb_listner_default_action
        target_group_arn = var.lb_target_group_arn
    }
}
