output "bucket-for-rekognition-project-2880" {
    description = "Name of the S3 Bucket for Rekognition Project"
    value       = aws_s3_bucket.bucketforrekognition.bucket
}

output "app_access_key" {
  description = "Access Key del usuario de la App"
  value       = aws_iam_access_key.app_user_access_key.id
}

output "app_secret_key" {
  description = "Secret Key del usuario de la App"
  value       = aws_iam_access_key.app_user_access_key.secret
  sensitive   = true  
}