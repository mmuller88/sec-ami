Prowler Security Stack.

You can delete the Ec2 instance when the CDK stack creation finished!

Based on the security Tool Prowler https://github.com/toniblyx/prowler for best practices assessments, hardening and forensics readiness. I developed an AWS CDK Custom Construct for deploying a Prowler security stack https://github.com/mmuller88/cdk-prowler .

But as to learn and deploy AWS CDK takes times I decided to create an AMI which does that for you. Deploying the cdk-prowler stack into your account is as easy as starting an ec2 instance. The following steps are necessary:

1) Create an Ec2 role named Ec2Prowler. The role needs AdministratorAccess for allowing to deploy CDK stacks into your account.

2) Start an Ec2 instance with the AMI and the Ec2Prowler role attached.

When you started the Ec2 instance a new Cloudformation stack called ProwlerAudit-stack gets created. You can terminate the ec2 instance after the stack got created.

When the stack creation finishes a Codebuild project runs the Prowler security check. After the run you can access the html results from the prowler S3 bucket named prowleraudit-stack-prowlerauditreportbucket... . Or you can see the results in the CodeBuild report group.

Notice! For running prowler again you need to deploy the Ec2 instance again!

As for transparency I decided to make the code for creating the AMI public available. Go to https://github.com/mmuller88/sec-ami . There you see the Dockerfile which I used for baking the AMI.

SKU: Prowler-Security-Hardening-Scan-v1.0.0
Software by: martinmueller.dev
Title: Prowler Security Hardening Scan v1.0.0
Product Logo URL: https://user-images.githubusercontent.com/3985464/113734260-7ba06900-96fb-11eb-82bc-d4f68a1e2710.png
Search Keywords: Prowler,Security,Hardening,Scan
Resource Name 1: cdk-prowler Github
Resource URL 1: https://github.com/mmuller88/cdk-prowler
Resource Name 2: prowler Github
Resource URL 2: https://github.com/toniblyx/prowler
Refund Policy: no refunds

Version
Version: v1.0.0

AMI
Enter your AMI: ?
Architecture: x86_64