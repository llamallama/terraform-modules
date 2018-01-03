resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket}"
  versioning = {
    enabled = "${var.versioning}"
  }


  tags {
    Name        = "${var.name}"
    Environment = "${var.environment}"
  }
}
