# Deploy Docker app with CI/CD to Elastic Beanstalk
### Create GitHub repo 
    1. Fork from this GitHub repo 
### Create ECR repos (skip if using docker hub)
    1. Click 'Create Repository' and create new for each image
### Create new EB new environment
    1. Click on 'Create a new environment', and select 'Web server environment'
    2. Create a name for your application and environment
    3. For the platform make sure you select 'Docker', and for Platform branch select 'Docker running on 64bit Amazon Linux 2'
    4. Create 'Sample application'
    5. After creating the app go to 'Configuration', than edit 'Software' and add all environment properties
### Create new CodeBuild
    1. Click on 'Create build project'.
    2. Select GitHub for source provider, click on connect github than 'Repository in my GitHub account' and write you repo URL and branch
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
        - In 'Additional configuration' of 'Environment' block add all environment properties including DOCKER_USERNAME and DOCKER_ACCESS in case of docker hub or AWS_ACCOUNT_ID and AWS_DEFAULT_REGION in case of ECR
### Add IAM policies for ECR   
    1. Attach 'AmazonEC2ContainerRegistryReadOnly' policty to 'aws-elasticbeanstalk-ec2-role' role
    1. Attach 'AmazonEC2ContainerRegistryPowerUser' policty to newly created 'codebuild-CodeBuildProjectName-service-role' CodeBuild role
### Create new CodePipeline
    1. Click on 'Create new pipeline', select 'New service role'
    2. Select 'GitHub (Version 1)' for source step and 'Connect to GitHub'. After that select repo and branch. Keep 'GitHub Webhooks'
    3. In build step select 'AWS CodeBuild' and select your application
    4. For deploy step select 'AWS Elastic Beanstalk' and select you application and environment
### Attach custom domain (if needed)
    1. To attach custom domain add CNAME record with DNS name of EB application or load balancer (if exist).
    2. Create new public certificate at ACM and validate by adding CNAME to domain.
    3. Open 443 port in load balancer of EB application configurations and attach cetificate.