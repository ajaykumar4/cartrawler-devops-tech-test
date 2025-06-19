# Using the official AWS EKS module for best practices
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.12.1"

  cluster_name    = var.cluster_name
  cluster_version = "1.29"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    one = {
      name           = "${var.cluster_name}-node-group"
      instance_types = var.instance_types
      min_size       = 1
      max_size       = 3
      desired_size   = 2
    }
  }

  tags = {
    Project     = "cartrawler-devops-test"
    ManagedBy   = "Terraform"
  }
}