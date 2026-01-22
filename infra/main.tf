resource "aws_s3_bucket" "bucketforrekognition" {
    bucket = "bucket-for-rekognition-project-2880"
    region = var.region
    tags = {
      Name = "My Bucket Project"
      Environment = "Dev"
    }
}