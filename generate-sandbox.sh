#!/bin/sh

set -e -x

SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )

SECRETS1=../common-sandbox/cf-secrets.sandbox.main.yml
SECRETS2=../common-sandbox/cf-secrets.sandbox.external.yml
MANIFEST=$SCRIPTPATH/manifest-staging.yml

if [ "${#@}" -gt 0 ]
then
  SECRETS=''
  eval MANIFEST=\${$#}
  for file in "$@"
  do
    if test $file != "${MANIFEST}"
    then
      SECRETS="${SECRETS} ${file}"
    fi
  done
fi

spiff merge \
  $SCRIPTPATH/cf-deployment.yml \
  $SCRIPTPATH/cf-resource-pools.yml \
  $SCRIPTPATH/cf-jobs.yml \
  $SCRIPTPATH/cf-properties.yml \
  $SCRIPTPATH/cf-infrastructure-aws-sandbox.yml \
  $SECRETS1 \
  $SECRETS2 \
  > $MANIFEST

