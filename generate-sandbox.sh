#!/bin/sh

set -e -x

SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )
echo "Current dir: `pwd`"
SECRETS=$SCRIPTPATH/common-sandbox/cf-secrets.sandbox.main.yml
SECRETS="${SECRETS} $SCRIPTPATH/common-sandbox/cf-secrets.sandbox.main.yml"
MANIFEST=$SCRIPTPATH/manifest-staging.yml

spiff merge \
  $SCRIPTPATH/cf-deployment.yml \
  $SCRIPTPATH/cf-resource-pools.yml \
  $SCRIPTPATH/cf-jobs.yml \
  $SCRIPTPATH/cf-properties.yml \
  $SCRIPTPATH/cf-infrastructure-aws-sandbox.yml \
  $SECRETS \
  > $MANIFEST

