resource "aws_s3_bucket" "bucketforrekognition" {
    bucket = "bucket-for-rekognition-project-2880"
    tags = {
      Name = "My Bucket Project"
      Environment = "Dev"
    }
}

resource "aws_iam_user" "app_user" {
    name = "RecognitionAppUser"
}

resource "aws_iam_policy" "app_policy" {
    name = "RecognitionAppPolicy"
    description = "Policy for Rekognition App User"
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = [
                    "s3:GetObject",
                    "s3:PutObject"
                ]
                Effect   = "Allow"
                Resource = "${aws_s3_bucket.bucketforrekognition.arn}/*"
            },
            {
                Action = [
                    "rekognition:DetectLabels",
                    "rekognition:IndexFaces",
                    "rekognition:SearchFacesByImage"
                ]
                Effect   = "Allow"
                Resource = "*"
            }
        ]
    })
}

resource "aws_iam_user_policy_attachment" "app_user_policy_attach" {
    user       = aws_iam_user.app_user.name
    policy_arn = aws_iam_policy.app_policy.arn
}

resource "aws_iam_access_key" "app_user_access_key" {
    user = aws_iam_user.app_user.name
}