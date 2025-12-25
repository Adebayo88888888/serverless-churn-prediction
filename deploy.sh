#!/bin/bash
set -e  # Exit on error

IMAGE_NAME="churn-prediction-lambda"
AWS_REGION="eu-west-1"
# Hardcode ID if jq is missing: AWS_ACCOUNT_ID="505789306274"
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)

COMMIT_SHA=$(git rev-parse --short HEAD 2>/dev/null || echo "no-git")
DATETIME=$(date +"%Y%m%d-%H%M")
IMAGE_TAG="${COMMIT_SHA}-${DATETIME}"

ECR_URI="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
IMAGE_URI="${ECR_URI}/${IMAGE_NAME}:${IMAGE_TAG}"

echo "Logging in to ECR..."
aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_URI}

echo "Building image: ${IMAGE_URI}..."
# Added --platform for cross-compatibility
docker build --platform linux/amd64 -t ${IMAGE_NAME}:${IMAGE_TAG} .

echo "Tagging and Pushing..."
docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_URI}
docker push ${IMAGE_URI}

echo "Updating Lambda Function..."
aws lambda update-function-code \
  --function-name churn-prediction-docker \
  --image-uri ${IMAGE_URI} \
  --region ${AWS_REGION}