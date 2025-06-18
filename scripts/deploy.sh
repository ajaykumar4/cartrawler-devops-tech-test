#!/bin/bash

# Simple script for manual deployment using Helm.
# Usage: ./deploy.sh <namespace> <release-name> <chart-path> <image-repo> <image-tag>

NAMESPACE=${1:-"default"}
RELEASE_NAME=${2:-"manual-release"}
CHART_PATH=${3:-"../helm-chart"}
IMAGE_REPO=${4:-"ajaykumar4/cartrawler-devops-test-app"}
IMAGE_TAG=${5:-"latest"}

# Check for prerequisites
if ! command -v helm &> /dev/null
then
    echo "Helm could not be found. Please install it."
    exit
fi

echo "Deploying release '$RELEASE_NAME' with image tag '$IMAGE_TAG' to namespace '$NAMESPACE'..."

helm upgrade --install ${RELEASE_NAME} ${CHART_PATH} \
    --namespace ${NAMESPACE} \
    --create-namespace \
    --set image.repository=${IMAGE_REPO} \
    --set image.tag=${IMAGE_TAG} \
    --atomic \
    --timeout 10m

echo "Deployment finished."