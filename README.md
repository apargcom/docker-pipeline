# Deploy Docker app with CI/CD to Elastic Beanstalk
### Create GitHub repo 
    1. Fork from this GitHub repo 
### Create ECR repos (skip if using docker hub)
    1. Click 'Create Repository' and create new for each image
### Create new EB new environment
    1. Click on 'Create a new environment', and select 'Web server environment'
    2. Create a name for your application and environment
    3. For the platform make sure you select 'Docker', and for Platform branch select 'Docker running on 64bit Amazon Linux 2'
    4. Leave 'Sample application' for application code
    5. Click on 'Configure more options', than edit 'Software' and add all environment properties including DOCKER_ACCESS in case of docker hub or AWS_ACCOUNT_ID and AWS_DEFAULT_REGION in case of ECR
### Create new CodeBuild
    1. Click on 'Create build project'.
    2. Select GitHub for source provider, click on connect github than 'Repository in my GitHub account' and write you repo URL
    3. Other configurations:
        - Environment Image — Managed Image
        - Operating System — Ubuntu
        - Runtime — Standard
        - Image — aws/codebuild/standard:5.0
        - Image Version — Always use the latest image
        - Environment Type — Linux
        - Privileged (Enable this flag if you want to build Docker images or want your builds to get elevated privileges) — Yes (Checked box)
        - Service role — New service role
        - Build specifications — Use a buildspec file
        - In 'Additional configuration' of 'Environment' block add all environment properties including DOCKER_ACCESS in case of docker hub or AWS_ACCOUNT_ID and AWS_DEFAULT_REGION in case of ECR
### Add IAM permissions for ECR   
    1. Open newly create role 'codebuild-SampleCodeBuildProject-service-role'
    2. Click on 'Attach policies' than 'Create policy'
    3. Attach permissions listed below and give a name 'SampleCodeBuildToECR'
    4. Attach 'SampleCodeBuildToECR' policy to 'codebuild-SampleCodeBuildProject-service-role' role
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ecr:CompleteLayerUpload",
                "ecr:GetAuthorizationToken",
                "ecr:UploadLayerPart",
                "ecr:InitiateLayerUpload",
                "ecr:BatchCheckLayerAvailability",
                "ecr:PutImage"
            ],
            "Resource": "*"
        }
    ]
}
```
### Create new CodePipeline
    1. Click on 'Create new pipeline', select 'New service role'
    2. Select 'GitHub (Version 1)' for source step and 'Connect to GitHub'. After that select repo and branch. Keep 'GitHub Webhooks'
    3. In build step select 'AWS CodeBuild' and select your application
    4. For deploy step select 'AWS Elastic Beanstalk' and select you application and environment
### Attach custom domain (if needed)
    1. To attach custom domain add CNAME record with DNS name of EB application or load balancer (if exist).