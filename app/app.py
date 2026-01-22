import boto3
import os


def main ():
    bucket_name = "bucket-for-rekognition-project-2880"
    image_name = "test.jpg"
    script_dir = os.path.dirname(os.path.abspath(__file__))
    image_path = os.path.join(script_dir,"images", image_name)

    if not bucket_name:
        print("BUCKET_NAME environment variable not set.")
        return
    
    print(f"Uploading {image_name} to bucket {bucket_name}...")

    s3 = boto3.client('s3')
    rekognition = boto3.client('rekognition')

    try:
        print("Uploading image to S3...")
        s3.upload_file(image_path, bucket_name, image_name)
        print("Image uploaded successfully.")
    except Exception as e:
        print(f"Error uploading image: {e}")
        return
    try:
        print("Calling Rekognition to detect labels...")
        response = rekognition.detect_labels(
            Image={
                'S3Object': {
                    'Bucket': bucket_name,
                    'Name': image_name
                }
            },
            MaxLabels=10,
            MinConfidence=75
        )

        print("Labels detected:")
        for label in response['Labels']:
            print(f"{label['Name']}: {label['Confidence']:.2f}%")

        print("Rekognition call completed successfully.")
        for label in response['Labels']:
            print(f"Label: {label['Name']}, Confidence: {label['Confidence']:.2f}%")
    
    except Exception as e:
        print(f"Error calling Rekognition: {e}")

if __name__ == "__main__":
    main()

    
