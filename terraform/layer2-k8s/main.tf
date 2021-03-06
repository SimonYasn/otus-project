terraform {
  required_version = "1.1.9"

  required_providers {
    aws = {
      source  = "aws"
      version = "4.10.0"
    }
    kubernetes = {
      source  = "kubernetes"
      version = "2.10.0"
    }
    helm = {
      source  = "helm"
      version = "2.5.1"
    }
    http = {
      source  = "hashicorp/http"
      version = "2.1.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}

data "terraform_remote_state" "layer1-aws" {
  backend = "s3"
  config = {
    bucket  = var.remote_state_bucket
    key     = "${var.remote_state_key}/terraform.tfstate"
    region  = var.region
    encrypt = "true"
  }
  workspace = terraform.workspace
}

data "aws_caller_identity" "current" {}
