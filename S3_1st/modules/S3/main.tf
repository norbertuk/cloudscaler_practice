resource "random_id" "bucket_id" {
    byte_length = 8
}

resource "aws_s3_bucket" "mys3bucket" {
    bucket =  "${var.s3_bucket_name}-${random_id.bucket_id.hex}"
    tags = var.tags
}

resource "aws_s3_bucket_public_access_block" "mys3bucket_public_access_block" {
    bucket = aws_s3_bucket.mys3bucket.id
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "mys3bucket_encryption" {
    bucket = aws_s3_bucket.mys3bucket.id
    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
}

resource "aws_s3_bucket_versioning" "mys3bucket_versioning" {
    bucket = aws_s3_bucket.mys3bucket.id
    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_s3_bucket_lifecycle_configuration" "mys3bucket_lifecycle" {
   bucket = aws_s3_bucket.mys3bucket.id
   rule {
        id = "transition-to-intelligent-tiering"
        status = "Enabled"
        transition {
          days = 30
          storage_class = "Intelligent-Tiering"
        }
   }
}