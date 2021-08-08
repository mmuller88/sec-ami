#!/bin/bash
cd /cdk-prowler
ACCOUNT_ID=$(aws sts get-caller-identity | jq '.Account' -r)
EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
EC2_REGION="`echo \"$EC2_AVAIL_ZONE\" | sed 's/[a-z]$//'`"
AWS_REGION=${EC2_REGION:-$AWS_REGION}
echo "ACCOUNT_ID=$ACCOUNT_ID"
echo "AWS_REGION_GET=$AWS_REGION"
node_modules/.bin/cdk bootstrap --force --cloudformation-execution-policies arn:aws:iam::aws:policy/AdministratorAccess aws://$ACCOUNT_ID/$AWS_REGION
yarn deploy --require-approval never -c reRunProwler=true

# rm -rf /cdk-prowler
# rm -rf /etc/init.d/commands.sh

# while true
# do
#   sleep 1
# done