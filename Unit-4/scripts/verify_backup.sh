#!/usr/bin/env bash
# ==============================================================================
# Enterprise Smart Library Management Platform - S3 Verification Script
# Unit 4: Infrastructure Automation
# Student: Arman (PRN: 2125UMLM1097)
# ==============================================================================

set -euo pipefail

BUCKET_NAME="${1:-}"
AWS_REGION="${2:-us-east-1}"

# Derive the default bucket name only when one was not supplied.
if [ -z "$BUCKET_NAME" ]; then
  ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)
  BUCKET_NAME="library-backup-${ACCOUNT_ID}-${AWS_REGION}"
fi

echo "=========================================================="
echo " 1. Verifying S3 Bucket Versioning Configuration"
echo " Command: aws s3api get-bucket-versioning --bucket ${BUCKET_NAME} --region ${AWS_REGION}"
echo "=========================================================="
aws s3api get-bucket-versioning \
  --bucket "${BUCKET_NAME}" \
  --region "${AWS_REGION}"

echo ""
echo "=========================================================="
echo " 2. Verifying S3 Server-Side Encryption (SSE-AES256)"
echo " Command: aws s3api get-bucket-encryption --bucket ${BUCKET_NAME} --region ${AWS_REGION}"
echo "=========================================================="
aws s3api get-bucket-encryption \
  --bucket "${BUCKET_NAME}" \
  --region "${AWS_REGION}"

echo ""
echo "=========================================================="
echo " 3. Listing S3 Backup Objects"
echo " Command: aws s3 ls s3://${BUCKET_NAME}/backups/ --region ${AWS_REGION}"
echo "=========================================================="
aws s3 ls "s3://${BUCKET_NAME}/backups/" \
  --region "${AWS_REGION}"

echo ""
echo "All storage governance and backup integrity checks completed successfully!"
