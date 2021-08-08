#!/bin/bash
cd /cdk-prowler
ACCOUNT_ID=$(aws sts get-caller-identity | jq '.Account' -r)
AWS_REGION=$(aws configure get region)
echo "ACCOUNT_ID=$ACCOUNT_ID"
node_modules/.bin/cdk bootstrap --force --cloudformation-execution-policies arn:aws:iam::aws:policy/AdministratorAccess aws://$ACCOUNT_ID/$AWS_REGION
yarn deploy --require-approval never -c reRunProwler=true

rm -rf /cdk-prowler
rm -rf /etc/init.d/commands.sh

# while true
# do
#   sleep 1
# done