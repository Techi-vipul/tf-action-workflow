terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.53.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

// Create a Local Module

module "tfmodule" {
  count = 2
  source  = "app.terraform.io/Terraform-June-Learning/tfmodule/aws"
  version = "1.0.0"
  ec2_size = "t2.micro"
  ec2_name = { Name = "server${count.index}", env = "dev" }
}
// for printing output
output "public_ip" {
  value = module.myec2mdule[0].ec2_public_ip
}
output "private_ip" {
  value = module.myec2mdule[0].ec2_private_ip
}
output "dns_name" {
  value = module.myec2mdule[0].ec2_public_dns
}
