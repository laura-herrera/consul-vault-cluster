# Configure the AWS Provider
provider "aws" {
  region = "eu-west-1"
}

data "terraform_remote_state" "remote_state" {
    backend = "s3"
    config {
        bucket = "my-terraform-state"
        key = "terraform/vault-cluster-dev.tfstate"
        region = "eu-west-1"
    }
}
