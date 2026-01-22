output "bucket-for-rekognition-project-2880" {
    description = "Name of the S3 Bucket for Rekognition Project"
    value       = aws_s3_bucket.bucketforrekognition.bucket
}