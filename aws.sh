#!/bin/sh

function aws_lb(){

  VPS=$(aws ec2 describe-vpcs --filters Name=isDefault,Values=true --query 'Vpcs[0].VpcId')  
  VPS=$VPS | tr -d '"'
  VPS=${VPS//[\"]/}
  SUBNET=$(aws ec2 describe-subnets --filters Name=vpc-id,Values=$VPS --query 'Subnets[*].SubnetId')
  SUBNET=${SUBNET//[,\[\]\"$'\n']/}  
  SUBNET=${SUBNET//\"/}
  DNS=$(aws elbv2 create-load-balancer --name $LB_NAME --type network --subnets $SUBNET)
  DNS=${DNS#*\"DNSName\": \"}
  DNS=${DNS%%\",*}
  echo "DNSName: $DNS"
}

while true; do
  case "$1" in
    -a | --action ) ACTION="$2"; shift 2 ;;
    -l | --lbname ) LB_NAME="$2"; shift 2 ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

if [ "$ACTION" == "lb" ]
then
	aws_lb
fi