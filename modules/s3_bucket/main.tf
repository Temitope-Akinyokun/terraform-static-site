resource "aws_s3_bucket" "bucket" {
  bucket = "temisbucket123"

  tags = {
    Name = "My bucket"
  }
}

resource "aws_s3_object" "uploads" {
  for_each = fileset("${path.root}/dir_upload", "**/*")

  bucket       = aws_s3_bucket.bucket.bucket
  key          = each.value
  source       = "${"${path.root}/dir_upload"}/${each.value}"
  content_type = "text/html"
}

resource "aws_s3_bucket_public_access_block" "website" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.bucket.arn,
      "${aws_s3_bucket.bucket.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_website_configuration" "bucket_config" {
  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}
