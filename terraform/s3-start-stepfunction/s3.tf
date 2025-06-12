resource "aws_s3_bucket" "bucket" {
  bucket = "s3-${var.bucket_name}"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.bucket.id
}