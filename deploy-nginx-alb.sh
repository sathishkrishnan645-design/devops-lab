#!/bin/bash
set -e

# Fetch the current ASG instance IDs from Terraform output
ASG_INSTANCE_IDS=$(terraform output -raw asg_instance_ids)

echo "Fetching ASG instances..."
echo "ASG Instance IDs: $ASG_INSTANCE_IDS"

# Wait until all instances are InService (optional, but safer)
echo "Waiting for instances to reach InService..."
for instance in $ASG_INSTANCE_IDS; do
    while true; do
        STATUS=$(aws autoscaling describe-auto-scaling-instances \
                    --instance-ids $instance \
                    --query "AutoScalingInstances[0].LifecycleState" \
                    --output text)
        if [[ "$STATUS" == "InService" ]]; then
            echo "$instance is InService"
            break
        else
            echo "$instance is $STATUS. Waiting..."
            sleep 5
        fi
    done
done
echo "All instances are InService."

# Install NGINX and sync website via SSM
echo "Installing NGINX and syncing website via SSM..."
for instance in $ASG_INSTANCE_IDS; do
    echo "Configuring instance $instance via SSM..."

    aws ssm send-command \
        --targets "Key=instanceIds,Values=$instance" \
        --document-name "AWS-RunShellScript" \
        --comment "Install NGINX and sync website" \
        --parameters 'commands=[
            "sudo yum install -y nginx",
            "sudo systemctl enable nginx",
            "sudo systemctl start nginx",
            "aws s3 sync s3://my-terraform-lab-website-32aa0834/ /usr/share/nginx/html/"
        ]' \
        --region ap-southeast-1
done

echo "NGINX installation and website sync triggered on all ASG instances."

