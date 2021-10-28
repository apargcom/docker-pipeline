# Deploy to AWS via docker compose CLI
### Build and push images to docker hub
```
$ docker login
$ docker compose build
$ docker compose push
```
### Create new environment and deploys an application to Elastic Beanstalk
```
$ eb init
$ eb create
```
To attach custom domain add CNAME record with DNS name of load balancer to domain.
## IAM permissions
Permissions that must be included in policy attached to AWS user.

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "elasticfilesystem:*",
                "application-autoscaling:*",
                "s3:*",
                "logs:*",
                "cloudformation:*",
                "elasticloadbalancing:*",
                "autoscaling:*",
                "iam:*",
                "servicediscovery:*",
                "elasticbeanstalk:*",
                "cloudwatch:*",
                "ecs:*",
                "route53:*",
                "ecr:*",
                "ec2:*"
            ],
            "Resource": "*"
        }
    ]
}
```