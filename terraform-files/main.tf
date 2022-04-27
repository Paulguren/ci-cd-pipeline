provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA5OBWETYT366S3JM5"
  secret_key = "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"
}


##### Secret Store
# versioning bucket
resource "aws_s3_bucket" "terraform_state"{
  bucket = "terraform-bucket-vice-city-1111"
  versioning {
    enabled = true
  }

  # server side encryption
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default{
        sse_algorithm = "AES256"
      }
    }
  }
}


# DynamoDB table locking - for version control
resource "aws_dynamodb_table" "terraform_locks" {
  name = "terraform-locks"
  billing_mode =  "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}


terraform {
  backend "s3" {
    bucket = "terraform-bucket-vice-city-1111"
    key = "global/s3/terraform.tfstate"
    region = "us-east-1"

    # dynamodb info
    dynamodb_table = "terraform-locks"
    encrypt = true
  }
}

#######


