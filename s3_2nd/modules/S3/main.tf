resource "aws_s3_bucket" "corp_bucket" {
    bucket = "corp-bucket-${random.random_suffix.result}"
    tags = var.tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "corp_bucket_encryption" {
    bucket = aws_s3_bucket.corp_bucket.id

    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
}

resource "aws_s3_bucket_versioning" "corp_bucket_versioning" {
  bucket = aws_s3_bucket.corp_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "example"
}

resource "aws_s3_bucket_public_access_block" "corp_bucket_public_access_block" {
  bucket = aws_s3_bucket.corp_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "corp_bucket_lifecycle" {
  bucket = aws_s3_bucket.corp_bucket.id

  rule {
    id     = "expire-objects"
    status = "Enabled"

    transition {
      days = 30
      storage_class = "Standard-AI"
    }
  }
}   

resource "aws_s3_bucket_versioning" "corp_bucket_versioning" {
  bucket = aws_s3_bucket.corp_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

data "aws_iam_policy_document" "allow_s3_access" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::123456789012:user/ExampleUser"]
    }
    actions   = ["s3:getObject", 
                 "s3:putObject",
                 "s3:ListBucket"]

    resources = ["arn:aws:s3:::${aws_s3_bucket.corp_bucket.id}/*"]
  }
}

resource "aws_iam_policy" "allow_s3_access_policy" {
  name        = "AllowS3AccessPolicy"
  description = "Policy to allow access to S3 bucket"
  policy      = data.aws_iam_policy_document.allow_s3_access.json
}

resource "aws_iam_user_policy_attachment" "attach_allow_s3_access_policy" {
  user       = "ExampleUser"
  policy_arn = aws_iam_policy.allow_s3_access_policy.arn
}