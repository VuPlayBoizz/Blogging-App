variable "lb_name" {
  description = "Tên của Load Balancer"
  type        = string
}

variable "lb_type" {
  description = "Loại của Load Balancer (application hoặc network)"
  type        = string
}

variable "is_external" {
  description = "Chỉ định nếu Load Balancer là external hoặc internal"
  type        = bool
  default     = false
}

variable "sg_enable_ssh_https" {
  description = "Security group ID cho Load Balancer"
  type        = string
}

variable "subnet_ids" {
  description = "Danh sách các subnet ID cho Load Balancer"
  type        = list(string)
}

variable "tags" {
    description = "Tên tag cho Load Balancer"
    type        = map(string)
}

variable "lb_target_group_arn" {
  description = "ARN của Target Group"
  type        = string
}

variable "ec2_instance_id" {
  description = "ID của EC2 instance"
  type        = string
}

variable "lb_listner_port" {
  description = "Cổng của listener"
  type        = number
}

variable "lb_listner_protocol" {
  description = "Giao thức của listener"
  type        = string
}

variable "lb_listner_default_action" {
  description = "Hành động mặc định của listener"
  type        = string
}

variable "lb_https_listner_port" {
  description = "Cổng của listener HTTPS"
  type        = number
}

variable "lb_https_listner_protocol" {
  description = "Giao thức của listener HTTPS"
  type        = string
}

variable "devops_project_acm_arn" {
  description = "ARN của SSL certificate (ACM)"
  type        = string
}

variable "lb_target_group_attachment_port" {
  description = "Cổng cho target group attachment"
  type        = number
}
