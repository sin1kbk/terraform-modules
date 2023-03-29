terraform {
  #backend "local" { path = ".tfstate" }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.0"
    }
    newrelic = {
      source  = "newrelic/newrelic"
      version = "3.15.0"
    }
  }
}

provider "newrelic" {
  account_id = var.NEWRELIC_ACCOUNT_ID
  api_key    = var.NEWRELIC_API_KEY
  region     = "US"
}

provider "aws" {
  region = "ap-northeast-1"
}