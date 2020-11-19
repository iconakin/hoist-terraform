terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

#Create an S3 bucket with static hosting enabled
resource "aws_s3_bucket" "tf-web-bucket" {
  bucket = "hoist-media-blog-site"
  acl    = "public-read"
  policy = file("policy.json")

  website {
    index_document = "index.html"
    error_document = "error.html"

    routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]
EOF
  }

  tags = {
    Name        = "Blog bucket"
    Environment = "Dev"
  }
}

# Create two EC2 instances
resource "aws_instance" "dev-server" {
  count         = 2
  ami           = "ami-00ddb0e5626798373"
  instance_type = "t2.micro"
  key_name      = "Camfield-KP"
  tags = {
    Name = "hoist-internal-development"
  }
}
