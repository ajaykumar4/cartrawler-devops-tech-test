# Terraform EKS for Project cartrawler-devops-test

This repository contains Terraform code to create a production-ready EKS cluster on AWS for the `cartrawler-devops-test` project.

### Prerequisites

1.  **Install AWS CLI**: Follow the official guide to install the AWS CLI.
2.  **Install Terraform**: Follow the official HashiCorp guide to install Terraform.
3.  **Configure AWS Credentials**: Run `aws configure` and provide your AWS Access Key ID and Secret Access Key.
4.  **Create S3 Backend Resources**: You must manually create an S3 bucket and a DynamoDB table in your AWS account for Terraform to store its state.
    * **S3 Bucket Name**: `cartrawler-devops-test-tfstate`
    * **DynamoDB Table Name**: `terraform-lock` (with a primary key named `LockID` of type String)

### Step 1: Initialize Terraform

Clone this repository and run `terraform init`. This command will initialize your Terraform environment and download the necessary AWS modules. It will also prompt you to configure the S3 backend.

```sh
terraform init