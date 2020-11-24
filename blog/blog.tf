# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


#Create an S3 bucket with static hosting enabled
resource "aws_s3_bucket" "tf-web-bucket" {
  bucket = "hoist-media-blog-site"
  acl    = "public-read"
  policy = file("./blog/policy.json")

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

