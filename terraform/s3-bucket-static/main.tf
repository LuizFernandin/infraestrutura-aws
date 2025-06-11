provider "aws" {
    region = var.region
}

resource "aws_s3_bucket" "static_site_bucket" {
    bucket = "static-site-${var.bucket_name}

    website {
        index_document = "index.html"
        error_document = "404.html"
    }

    @REM tags = {
    @REM     Name = "Static Site Bucket"
    @REM     Environment = "Production"
    @REM }
}