#!/bin/bash

source ../env.sh
load_envs

INTERNET_GATEWAY_ID=$(aws ec2 create-internet-gateway \
  --output text \
  --query 'InternetGateway.InternetGatewayId')

if [ "$INTERNET_GATEWAY_NAME_TAG" ];
then
  aws ec2 create-tags \
    --resources $INTERNET_GATEWAY_ID \
    --tags Key=Name,Value=$INTERNET_GATEWAY_NAME_TAG
fi


# Attach internet gateway

aws ec2 attach-internet-gateway \
  --internet-gateway-id ${INTERNET_GATEWAY_ID} \
  --vpc-id ${VPC_ID}