# Deploy to AWS via docker compose CLI

### Login to docker CLI
```
$ docker login
```
### Build and push images to docker hub
```
$ docker compose build
$ docker compose push
```
### Configure AWS CLI
```
$ aws configure
```
### Create docker context and select newly created context
```
$ docker context create ecs my-context
$ docker context use my-context
```
### Deploy everything to AWS (also for deploying an update)
```
$ docker compose up
```
### Custom domain
To attach custom domain use own load balancer and add CNAME record with DNS name of load balancer to domain. Use **x-aws-loadbalancer: "myloadbalancer"** in docker-composer file to specify own load balancer.
 ```
 $ aws ec2 describe-vpcs --filters Name=isDefault,Values=true --query 'Vpcs[0].VpcId'
    
 "vpc-123456"
 $ aws ec2 describe-subnets --filters Name=vpc-id,Values=vpc-123456 --query 'Subnets[*].SubnetId'
    
 [
     "subnet-1234abcd",
     "subnet-6789ef00",
 ]
$ aws elbv2 create-load-balancer --name myloadbalancer --type application --subnets "subnet-1234abcd" "subnet-6789ef00"

 $ aws elbv2 create-load-balancer --name myloadbalancer --type application --subnets "subnet-1234abcd" "subnet-6789ef00"
    
 {
     "LoadBalancers": [
         {
             "IpAddressType": "ipv4",
             "VpcId": "vpc-123456",
             "LoadBalancerArn": "arn:aws:elasticloadbalancing:us-east-1:1234567890:loadbalancer/app/myloadbalancer/123abcd456",
             "DNSName": "myloadbalancer-123456.us-east-1.elb.amazonaws.com",
 <...>
 ```
### IAM permissions
Permissions that must be included in policy attached to user

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "iam:PutRolePolicy",
                "elasticfilesystem:*",
                "iam:CreateInstanceProfile",
                "application-autoscaling:*",
                "ec2:AuthorizeSecurityGroupIngress",
                "route53:GetHostedZone",
                "route53:GetHealthCheck",
                "iam:RemoveRoleFromInstanceProfile",
                "iam:CreateRole",
                "iam:AttachRolePolicy",
                "autoscaling:*",
                "route53:ListHostedZonesByName",
                "iam:AddRoleToInstanceProfile",
                "ecs:DeregisterTaskDefinition",
                "ec2:DescribeInternetGateways",
                "ecs:UpdateService",
                "servicediscovery:*",
                "iam:PassRole",
                "ecs:CreateService",
                "iam:DetachRolePolicy",
                "ecs:ListTasks",
                "ec2:CreateSecurityGroup",
                "ecs:RegisterTaskDefinition",
                "ec2:DescribeAccountAttributes",
                "route53:DeleteHostedZone",
                "ecs:DescribeServices",
                "logs:FilterLogEvents",
                "ecs:DescribeTasks",
                "ec2:DescribeRouteTables",
                "iam:DeleteInstanceProfile",
                "route53:CreateHostedZone",
                "logs:DescribeLogGroups",
                "logs:DeleteLogGroup",
                "ecs:CreateCluster",
                "ec2:CreateTags",
                "ecs:DeleteService",
                "ecs:DeleteCluster",
                "cloudformation:*",
                "iam:DeleteRole",
                "iam:DeleteRolePolicy",
                "elasticloadbalancing:*",
                "logs:CreateLogGroup",
                "ec2:DescribeSecurityGroups",
                "ecs:DescribeClusters",
                "ec2:RevokeSecurityGroupIngress",
                "ecs:ListAccountSettings",
                "iam:CreateServiceLinkedRole",
                "ec2:DescribeVpcs",
                "ec2:DeleteSecurityGroup",
                "ec2:DescribeSubnets"
            ],
            "Resource": "*"
        }
    ]
}
```