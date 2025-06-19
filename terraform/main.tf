terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Best Practice: Use a remote backend to store state securely.
  # You must create this S3 bucket and DynamoDB table manually first.
  backend "s3" {
    bucket         = "cartrawler-devops-test-tfstate"
    key            = "eks-cluster/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}