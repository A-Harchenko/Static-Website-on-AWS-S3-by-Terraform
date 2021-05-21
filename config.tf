#My Task

provider "aws" {
  access_key = var.i_access_key
  secret_key = var.i_secret_key
  region     = "us-west-2"
}

resource "aws_s3_bucket" "s3-my-static-site" {
  bucket = "s3-my-static-site"
  acl    = "public-read"

  website {
    index_document = "index.html"
  }

  tags = {
    name  = "WebServer for Task"
    owner = "Harchenko Anastasia"
  }
}

resource "aws_s3_bucket_object" "index" {
  bucket       = aws_s3_bucket.s3-my-static-site.bucket
  key          = "index.html"
  source       = "index.html"
  content_type = "text/html"
  etag         = md5(file("index.html"))
  acl          = "public-read"
}

output "website_endpoint" {
  description = "The public url of this website."
  value       = aws_s3_bucket.s3-my-static-site.website_endpoint
}
