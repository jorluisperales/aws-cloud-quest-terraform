resource "aws_s3_bucket" "s3_bucket" {
  bucket = "very-unique-s3-bucket-name-123123123"

}

resource "aws_s3_bucket_ownership_controls" "s3_controls" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_public_access_block" "s3_public_access_block" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "s3_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.s3_controls,
    aws_s3_bucket_public_access_block.s3_public_access_block,
  ]

  bucket = aws_s3_bucket.s3_bucket.id
  acl    = "public-read"
}


resource "aws_s3_bucket_server_side_encryption_configuration" "s3_sse_config" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_website_configuration" "s3_static_website" {
  bucket = aws_s3_bucket.s3_bucket.id

  index_document {
    suffix = "index.html"
  }


}

resource "aws_s3_bucket_policy" "s3_public_read_access" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = <<EOF
{
  "Id": "StaticWebPolicy",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "S3GetObjectAllow",
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.s3_bucket.arn}/*",
      "Principal": "*"
    }
  ]
}
EOF
}
