# main.tf
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "my-terraform-lab-website-32aa0834"  # your bucket
    key    = "terraform.tfstate"
    region = "ap-southeast-1"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

# Optionally, you can include variables here if not in variables.tf
# variable "vpc_id" { type = string }
# variable "subnet_ids" { type = list(string) }
# variable "key_name" { type = string }
# variable "bucket_name" { type = string }

