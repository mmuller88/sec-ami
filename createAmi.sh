#!/bin/bash

AWS_ACCESS_KEY_ID=$(aws secretsmanager get-secret-value --secret-id build/credentials --region eu-central-1 --query SecretString | jq -r 'fromjson | ."aws_access_key_id"')
AWS_SECRET_ACCESS_KEY=$(aws secretsmanager get-secret-value --secret-id build/credentials --region eu-central-1 --query SecretString | jq -r 'fromjson | ."aws_secret_access_key"')

AMI_VERSION=v1.0.9

sed -e 's;##aws_access_key_id##;'$AWS_ACCESS_KEY_ID';g' -e 's;##aws_secret_access_key##;'$AWS_SECRET_ACCESS_KEY';g' -e 's;##ami_version##;'$AMI_VERSION';g' .docker-build-ami_REPLACE.conf > .docker-build-ami.conf

docker-build-ami -c .docker-build-ami.conf | tee docker-build-ami.log
sleep 3
# RESULT=$(cat docker-build-ami.log)
cat docker-build-ami.log
AMI=$(cat docker-build-ami.log| grep "Created image: " | awk '{print $3}')
echo "AMI: $AMI"
# aws ec2 modify-image-attribute --image-id $AMI --launch-permission "Add=[{UserId=890129220607}, {UserId=681044435084}]" --region us-east-1

# ami marketplace for publishing
# aws marketplace-catalog start-change-set --cli-input-json file://changeset.json --region us-east-1