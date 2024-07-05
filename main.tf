terraform {
  required_version = "~> 1.8.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.57.0"
    }
  }
  cloud {
    organization = "Terraform-June-Learning"

    workspaces {
      name = "Cli-driven"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

// Call a Terraform Cloud Module
module "module1" {
  count    = 2
  source   = "app.terraform.io/Terraform-June-Learning/tfmodule/aws"
  version  = "1.0.0"
  ec2_size = "t2.micro"
  ec2_name = { Name = "server${count.index}", env = "dev" }
}
// for printing output
output "public_ip" {
  value = module.module1[0].ec2_public_ip
}
output "private_ip" {
  value = module.module1[0].ec2_private_ip
}
output "dns_name" {
  value = module.module1[0].ec2_public_dns
}
