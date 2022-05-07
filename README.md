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
Estimated cost ~ 216usd per month
Alert placed in terraform/layer1-aws/budget.tf
