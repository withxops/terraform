terraform {
  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = "6.37.0"
    }
  }
  backend "s3" {
    bucket = "xdevopsman-remote-backend-bucket"
    key = "terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "xdevopsman-dynamodb"
  }
}