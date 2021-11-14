#!/bin/sh
#
# commands
#
# chkconfig: 3 11 01
# Description: Script for starting cdk stacks
#
### BEGIN INIT INFO
# Provides:          commands
# Required-Start:    network
# Required-Stop:     network
# Default-Start:     3
# Default-Stop:
# Description:       Script for starting cdk stacks
### END INIT INFO

LOGFILE=/var/log/cdk.log

. /lib/lsb/init-functions

start() {
  echo "was running" > $LOGFILE

  cd /root/cdk-prowler
  # if [ -z "$ACCOUNT_ID" ]
  # then
    ACCOUNT_ID=$(aws sts get-caller-identity | jq '.Account' -r)
  # fi
  if [ -z "$AWS_REGION" ]
  then
    EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
    EC2_REGION="`echo \"$EC2_AVAIL_ZONE\" | sed 's/[a-z]$//'`"
    AWS_REGION=${EC2_REGION:-$AWS_REGION}
  fi
  echo "ACCOUNT_ID=$ACCOUNT_ID"
  echo "AWS_REGION=$AWS_REGION"

  ls -la

  node_modules/.bin/cdk bootstrap --cloudformation-execution-policies arn:aws:iam::aws:policy/AdministratorAccess aws://$ACCOUNT_ID/$AWS_REGION
  yarn deploy --require-approval never -c reRunProwler=true
}

case "$1" in
  start)
    start
    ;;
  stop)
    ;;
  uninstall)
    ;;
  restart)
    start
    ;;
  *)
    echo "Usage: $0 {start|stop|restart|uninstall}"
esac

# rm -rf /cdk-prowler
# rm -rf /etc/init.d/commands.sh

# while true
# do
#   sleep 1
# done