#!/bin/bash

source ../env.sh
load_envs

# Create VPC
echo "Creating VPC..."

VPC_ID=$(aws ec2 create-vpc \
  --cidr-block $CIDR_BLOCK \
  --output text \
  --query 'Vpc.VpcId')


# Create VPC Name Tag
echo "Tagging VPC name..."

if [ "$VPC_NAME_TAG" ];
then
  aws ec2 create-tags \
  --resource $VPC_ID \
  --tags Key=Name,Value=$VPC_NAME_TAG
fi


# Enable DNS hostname
echo "Setting enable DNS hostname..."

aws ec2 modify-vpc-attribute \
  --vpc-id $VPC_ID \
  --enable-dns-hostnames '{"Value": true}'


# Create Subnet
echo "Creating subnet..."

SUBNET_ID=$(aws ec2 create-subnet \
  --vpc-id $VPC_ID \
  --cidr-block $CIDR_BLOCK \
  --availability-zone $AVAILABLILTY_ZONE \
  --output text \
  --query 'Subnet.SubnetId')

echo "Tagging subnet name..."
aws ec2 create-tags \
  --resources $SUBNET_ID \
  --tags Key=Name,Value=$SUBNET_NAME_TAG