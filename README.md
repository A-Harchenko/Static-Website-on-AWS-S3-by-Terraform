Static-Website-on-AWS-S3-by-Terraform
========================================

 ## **Terraform Version** 
  
`Terraform v0.15.3`

## **Task**

The goal of this project is to serve a static HTML file on AWS S3 bucket. 

## **Task solution**

First, we register the connection to the AWS account using access_key, secret_key and region. For security reasons, we will pass credentials as variables. 

```terraform
provider "aws" {
    access_key = var.i_access_key
    secret_key = var.i_secret_key
    region     = "us-west-2"
}
```

Now let's create a resource S3 bucket

```terraform
resource "aws_s3_bucket" "s3-my-static-site" {
  bucket = "s3-my-static-site"
  acl    = "private"
  policy = file("policy.json")

  website {
    index_document = "index.html"
  }

  tags = {
      name  = "Webserver for Task"
      owner = "Harchenko Anastasia"
  }
}
```
