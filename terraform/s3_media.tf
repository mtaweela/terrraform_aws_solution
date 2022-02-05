resource "aws_s3_bucket" "media_bucket" {
  bucket = var.media_bucket_name
  acl    = var.media_bucket_acl

  # Add a CORS configuration, so that we don't have issues with webfont loading
  # http://www.holovaty.com/writing/cors-ie-cloudfront/
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }

  # uncomment the next line if you want to destroy the bucket
  # force_destroy = true 
  lifecycle {
  }
}

resource "aws_s3_bucket_policy" "media_bucket_policy" {
  depends_on = [aws_s3_bucket.media_bucket]
  bucket     = var.media_bucket_name

  # https://docs.aws.amazon.com/AmazonS3/latest/dev/example-bucket-policies.html#example-bucket-policies-use-case-2
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${var.media_bucket_name}/*"
    }
  ]
}
POLICY
}
