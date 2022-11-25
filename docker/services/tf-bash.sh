#!/bin/bash

echo "======================================================================="
if [ -z "${AWS_SESSION_TOKEN}" ]; then
  echo "[WRN] There is no active AWS session."
else
  echo "AWS ACCOUNT ALIAS: $(aws iam list-account-aliases | jq -r .AccountAliases[])"
  echo "LOGGED IN AS: $(aws sts get-caller-identity | jq -r .Arn | awk -F'/' '{ print $2}')"
  if [ "${AWS_MFA_EXPIRY}" != "null" ]; then
    echo "MFA EXPIRES AT: ${AWS_MFA_EXPIRY}"
  fi
fi
echo "======================================================================="
echo "CWD: $(pwd)"
ls -al

/bin/bash
