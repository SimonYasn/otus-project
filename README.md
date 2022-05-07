# Before 
#### AWS Auth
 ```bash
  $ aws configure --profile your_project
  AWS Access Key ID [None]: *****************
  AWS Secret Access Key [None]: *********************
  Default region name [None]: eu-central-1
  Default output format [None]: json
  ```

  ```bash
  $ export AWS_PROFILE=your_project
  ```

#### Setup terragrunt and terraform versions
You should pass your versions in next spaces:
1) terraform/.terraform-version
2) terraform/.terragrunt-version
3) terraform/terragrunt.hcl
4) terraform/layer1-aws/main.tf
5) terraform/layer2-k8s/main.tf

#### S3 state backend

S3 is used as a backend for storing terraform state and for exchanging data between layers. You can manually create s3 bucket and then put backend setting into `backend.tf` file in each layer. Alternatively you can run from `terraform/` directory:

  ```bash
  $ export TF_REMOTE_STATE_BUCKET=my-new-state-bucket
  $ terragrunt run-all init
  ```
  
#### Setup your variables in infra layer (layer1-aws)
Update variables in layer1-aws/terraform.tfvars. \
All possible var explains in layer1-aws/README.md

#### Setup your services in k8s layer (layer2-k8s)
Update variables in layer2-k8s/helm-releases.yaml

# Usage
#### Infra up
```bash
  $ cd terraform/layer1-aws
  $ terraform apply
```
After successfull apply copy kubectl config comand from output.
Example:
aws eks update-kubeconfig --name simonots-demo-euc1 --region eu-central-1

#### k8s up
```bash
  $ cd terraform/layer2-k8s
  $ terraform apply
```
#### deploy app
```bash
  $ cd application/
  $ kubectl apply -f echoserver-deployment.yaml
```
# Budget
Estimated infa cost ~ 216usd per month.
Alert placed in terraform/layer1-aws/budget.tf

| Resource      | Type/size               | Price per hour $ | Price per GB $ | Number | Monthly cost |
| ------------- | ----------------------- | ---------------: | -------------: | -----: | -----------: |
| EKS           |                         |              0.1 |                |      1 |           73 |
| EC2 ondemand  | t3.medium               |           0.0456 |                |      1 |       33,288 |
| EC2 Spot      | t3.medium/t3a.medium    |    0.0137/0.0125 |                |      1 |           10 |
| EC2 Spot Ci   | t3.medium/t3a.medium    |    0.0137/0.0125 |                |      0 |           10 |
| EBS           | 100 Gb                  |                  |           0.11 |      2 |           22 |
| NAT gateway   |                         |            0.048 |          0.048 |      1 |           35 |
| Load Balancer | Classic                 |            0.028 |          0.008 |      1 |        20.44 |
| S3            | Standart                |                  |                |      1 |            1 |
| ECR           | 10 Gb                   |                  |                |      2 |         1.00 |
| Route53       | 1 Hosted Zone           |                  |                |      1 |         0.50 |
| Cloudwatch    | First 10 Metrics - free |                  |                |        |            0 |
|               |                         |                  |                |  Total |        216.8 |

