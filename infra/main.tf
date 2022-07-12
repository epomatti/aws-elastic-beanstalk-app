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

resource "aws_elastic_beanstalk_application" "main" {
  name        = "tasks-app"
  description = "An application to create simple tasks"
}

resource "aws_elastic_beanstalk_environment" "main" {
  name                = "tasks-environment"
  application         = aws_elastic_beanstalk_application.main.name
  solution_stack_name = "64bit Amazon Linux 2 v3.4.17 running Docker"

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = "vpc-xxxxxxxx"
  }

  
}
