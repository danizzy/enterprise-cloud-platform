terraform {
  backend "s3" {

    bucket         = "daniel-onabiyi-terraform-state-2026"

    key            = "prod/terraform.tfstate"

    region         = "us-east-1"

    dynamodb_table = "terraform-locks"

    encrypt        = true

  }
}