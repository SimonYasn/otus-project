# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    bucket  = "my-new-state-bucket"
    encrypt = true
    key     = "layer2-k8s/terraform.tfstate"
    region  = "eu-central-1"
  }
}