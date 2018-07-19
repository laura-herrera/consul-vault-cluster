terraform {
  backend "s3" {
    bucket = "my-terraform-state"
    key = "terraform/vault-cluster-dev.tfstate"
    region = "eu-west-1"
  }
}
