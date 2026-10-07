#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# ==========================================
# CONFIGURATION VARIABLES
# ==========================================
# Replace these with your actual AWS values
AMI_ID="ami-0c7217cdde317cfec"       # Example: Ubuntu 22.04 LTS (Region specific)
INSTANCE_TYPE="t2.micro"             # Free-tier eligible type
KEY_NAME="my-aws-key"                # Name of your existing EC2 Key Pair
SECURITY_GROUP_ID="sg-0123456789abcdef0" # Your Security Group ID
SUBNET_ID="subnet-0123456789abcdef0" # Your Subnet ID
INSTANCE_NAME="My-Shell-EC2-Instance"
REGION="us-east-1"                   # Target AWS Region

echo "🚀 Starting EC2 Instance creation in region $REGION..."

# ==========================================
# LAUNCH THE EC2 INSTANCE
# ==========================================
# Run the instance and capture the output JSON
INSTANCE_INFO=$(aws ec2 run-instances \
    --image-id "$AMI_ID" \
    --instance-type "$INSTANCE_TYPE" \
    --key-name "$KEY_NAME" \
    --security-group-ids "$SECURITY_GROUP_ID" \
    --subnet-id "$SUBNET_ID" \
    --count 1 \
    --region "$REGION" \
    --output json)

# Extract Instance ID using text manipulation or query (requires jq if parsed cleanly, or direct text processing)
INSTANCE_ID=$(echo "$INSTANCE_INFO" | grep -m 1 '"InstanceId"' | awk -F'"' '{print $4}')

if [ -z "$INSTANCE_ID" ]; then
    echo "❌ Error: Failed to retrieve Instance ID."
    exit 1
fi

echo "✅ Instance launched successfully! Instance ID: $INSTANCE_ID"

# ==========================================
# TAG THE INSTANCE
# ==========================================
echo "🏷️ Tagging instance with name: $INSTANCE_NAME..."
aws ec2 create-tags \
    --resources "$INSTANCE_ID" \
    --tags Key=Name,Value="$INSTANCE_NAME" \
    --region "$REGION"

echo "🎉 Process complete. Check your AWS EC2 Console to see it initializing."
