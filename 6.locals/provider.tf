terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

/* state managemnet 

declared/desired infra ==> .tf files, whatever user writes in tf files, that is what user wants
actual infra ==> what terraform is creating in provider

desired infra === actual infra (both should match always)

terraform.tfstate ==> it is a file terraform creates to know, what it is created (to keep track of infra created). 
this is actual infra created by terraform

some changed the name of ec2 instance manaully inside console

now, when we run terraform plan or terraform apply , it will reads the state file and then compare that will actual infra

example:
name of ec2-instance: backend-server
some one manual changed in console : backend-server-change
This change will be detected by terraform when you run terraform plan or terraform apply and it will reveret back 
to "backend-server" as per the .tf files, it will not considered what ever changes happens outside of terraform 

name of ec2-instance: backend-server

if you update .tf files....

terraform.tfstate ==> backend-server
.tf files ==> backend-server1

ouput:
it will make the changes in AWS and it will update its terraform.tfstate file
terraform.tfstate ==> backend-server1
.tf files ==> backend-server1

always terraform.tfstate file infra details and .tf files infra details should be same.

*/