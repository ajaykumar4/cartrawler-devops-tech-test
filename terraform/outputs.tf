output "cluster_name" {
  description = "The name of the EKS cluster."
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "The endpoint for your EKS cluster."
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "The security group ID for the EKS cluster."
  value       = module.eks.cluster_security_group_id
}

output "configure_kubectl" {
  description = "A command to configure kubectl to connect to the new cluster."
  value       = "aws eks update-kubeconfig --region ${var.aws_region} --name ${var.cluster_name}"
}