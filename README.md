# AWS Rekognition Image Label Generator

![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge\&logo=amazon-aws\&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge\&logo=terraform\&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge\&logo=docker\&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge\&logo=python\&logoColor=white)

---




<img width="1449" height="1380" alt="Blank diagram" src="https://github.com/user-attachments/assets/b5939eef-923a-499a-8cb0-b1457a13278e" />



---

## Project Description

This project demonstrates a Cloud Engineering approach to building an image analysis solution using **Amazon Rekognition**. Instead of a standalone script, the solution applies **Infrastructure as Code (IaC)** with Terraform to provision secure AWS resources and uses **Docker** to containerize the application, ensuring portability and consistency across environments.

The application uploads a local image to an Amazon S3 bucket and invokes the Amazon Rekognition API to detect image labels along with their confidence scores. Results are returned via console output.

---

## Architecture Overview

The solution follows a **DevSecOps** mindset and applies the **Principle of Least Privilege**:

1. **Infrastructure (Terraform)**
   Provisions an S3 bucket for image storage and an IAM user with a restrictive policy allowing access only to the specific bucket and the Rekognition service.

2. **Containerization (Docker)**
   Encapsulates the Python runtime and dependencies (Boto3), ensuring reproducible executions across environments.

3. **Application Logic (Python)**
   Uploads the image to S3 and queries the Amazon Rekognition API to analyze the image.

4. **Security**
   AWS credentials are injected into the container via environment variables, avoiding the use of root or overly permissive credentials.

---

## Prerequisites

Before running this project, ensure you have the following installed:

* Docker Desktop (running)
* Terraform
* AWS CLI (optional, for verification and debugging)

---

## Project Structure

```text
aws-rekognition-terraform-docker/
├── app/
│   ├── images/              # Local directory for test images
│   ├── app.py               # Main Python script (Boto3 logic)
│   ├── Dockerfile           # Container configuration
│   └── requirements.txt     # Python dependencies
├── infra/
│   ├── main.tf              # Terraform resource definitions
│   ├── variables.tf         # Input variables
│   ├── outputs.tf           # Output values (bucket name, keys)
│   └── provider.tf          # AWS provider configuration
└── README.md
```

---

## Deployment Guide

### 1. Provision Infrastructure

Navigate to the infrastructure directory and deploy the AWS resources:

```bash
cd infra
terraform init
terraform apply
```

After a successful deployment, Terraform will output values such as the S3 bucket name and the IAM access key.

To retrieve the secret access key, run:

```bash
terraform output -raw app_secret_key
```

---

### 2. Build the Docker Image

Navigate to the application directory and build the container image:

```bash
cd ../app
docker build -t rekognition-app .
```

---

### 3. Run the Application

Run the Docker container and pass the required environment variables. Replace the placeholder values with your actual Terraform outputs.

#### Windows (PowerShell)

```powershell
docker run -e BUCKET_NAME="<YOUR_BUCKET_NAME>" `
           -e AWS_ACCESS_KEY_ID="<YOUR_ACCESS_KEY>" `
           -e AWS_SECRET_ACCESS_KEY="<YOUR_SECRET_KEY>" `
           -e AWS_DEFAULT_REGION="us-east-2" `
           rekognition-app
```

#### Linux / macOS (Bash)

```bash
docker run -e BUCKET_NAME="<YOUR_BUCKET_NAME>" \
           -e AWS_ACCESS_KEY_ID="<YOUR_ACCESS_KEY>" \
           -e AWS_SECRET_ACCESS_KEY="<YOUR_SECRET_KEY>" \
           -e AWS_DEFAULT_REGION="us-east-2" \
           rekognition-app
```

---

## Cleanup

To avoid unnecessary AWS costs, destroy the infrastructure when you are finished:

```bash
cd infra
terraform destroy
```

**Note:** Ensure the S3 bucket is empty before destroying the infrastructure, otherwise Terraform may fail to delete the bucket.
