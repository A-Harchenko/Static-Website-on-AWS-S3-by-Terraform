Static-Website-on-AWS-S3-by-Terraform
========================================

 ## **Terraform Version** 
  
`Terraform v0.15.3`

## **Task**

The goal of this project is to serve a static HTML file on AWS S3 bucket. 

# **Task solution**

First, we register the connection to the AWS account using access_key, secret_key and region. For security reasons, we will pass credentials as variables. 

```terraform
provider "aws" {
    access_key = var.i_access_key
    secret_key = var.i_secret_key
    region     = "us-west-2"
}
```

Now let's create a resource S3 bucket and S3 bucket object. By default - S3 buckets and objects in them are private and unavailable for reading. 
All access rights to the buckets and objects in them are recorded in the ACL (Access Control List). The access rights to the bucket and the objects in it are completely independent: the object in the bucket does not inherit the access rights of this bucket. Amazon S3 supports a set of predefined grants, known as canned ACLs. Each canned ACL has a predefined set of grantees and permissions. In our case, you can use " public_read". Owner gets FULL CONTROL and all users in the group get READ access.

```terraform
resource "aws_s3_bucket" "s3-my-static-site" {
  bucket = "s3-my-static-site"
  acl    = "public-read"

  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket_object" "index" {
  bucket       = "${aws_s3_bucket.s3-my-static-site.bucket}"
  key          = "index.html"
  source       = "index.html"
  content_type = "text/html"
  etag         = "${md5(file("index.html"))}"
  acl          = "public-read"
}
```
When you configure your bucket as a static website, the website is available at the AWS Region-specific website endpoint of the bucket. Depending on the region, the endpoint of the Amazon S3 website matches the format with dash.

```terraform
output "website_endpoint" {
  description = "The public url of this website."
  value = "${aws_s3_bucket.s3-my-static-site.website_endpoint}"
}
```
After executing this code, we get the url to our html file.

<https://s3-my-static-site.s3-us-west-2.amazonaws.com/index.html>

