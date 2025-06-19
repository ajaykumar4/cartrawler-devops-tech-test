variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "eu-west-1"
}

variable "cluster_name" {
  description = "The name for the EKS cluster."
  type        = string
  default     = "cartrawler-devops-test-cluster"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "instance_types" {
  description = "A list of instance types for the EKS node group."
  type        = list(string)
  default     = ["t3.medium"]
}