terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.22.0"
    }
  }
  backend "local" {
    path = "./.workspace/terraform.tfstate"
  }
}

provider "aws" {
  region = "sa-east-1"
}

resource "aws_dynamodb_table" "tasks" {
  name           = "Tasks"
  billing_mode   = "PAY_PER_REQUEST"
  stream_enabled = false
  hash_key       = "Id"
  range_key      = "Title"

  attribute {
    name = "Id"
    type = "S"
  }

  attribute {
    name = "Title"
    type = "S"
  }
}
