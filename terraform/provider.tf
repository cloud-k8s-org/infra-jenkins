# Configure the AWS Provider
provider "aws" {
  region  = var.REGION
  profile = var.PROFILE
  default_tags {
    tags = {
      Name = "k8s"
    }
  }
}