terraform {
  backend "s3" {
    bucket = "zomato-terraform-tfbucket"
    key    = "terraform.tfstate"
    region = "ap-south-1"

  }
}

