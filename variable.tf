variable "instance_type" {
  type        = string
  description = "type of instance"
  default     = "t2.micro"
}

variable "ami_id" {
  type        = string
  description = "id of ami"
  default     = "ami-02e94b011299ef128"
}

variable "project_name" {
  type        = string
  description = "name of the project"
  default     = "uber"
}

variable "project_env" {
  type        = string
  description = "product environment"
  default     = "prod"
}

variable "project_owner" {
  type        = string
  description = "project owner"
  default     = "faith"
}

variable "hosted_zone_name" {
  type        = string
  description = "domain name"
  default     = "mrfaith.shop"
}

variable "hostname" {
  type        = string
  description = "hostname name"
  default     = "shopping"
}

