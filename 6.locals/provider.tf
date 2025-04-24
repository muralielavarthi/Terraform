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

/* 

state managemnet: 
================

declared/desired infra ==> .tf files, whatever user writes in tf files, that is what user wants
actual infra ==> what terraform is creating in provider.

desired infra === actual infra (both should match always)

terraform.tfstate ==> it is a file terraform creates to know, what it is created (to keep track of infra created). 
this is actual infra created by terraform.

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

Here, to change the name of instance, terraform no need re-create the instance, it can change in same instance.

if you update few parameters manually(outside of terraform), resources will not be created again it will just update
Ex: instance name

But, few paramters if you update (inside .tf files), we are forced to recreate resource.
Ex: Security group name, if you changed security name in .tf file, it will destroy existing security group and 
re-create new security group with latest name.

terraform.tfstate is very important file, we need to secure it and we should not touch it and not do any changes
this file is only for terrafrom reference.

Developer 1: created infra using terraform and pushed the code to Github. 
Here terraform.tfstate is not pushed to Github, since it very important and secure file

Developer 2: he clones the repo do some changes, runs terraform apply, since there is no terraform.tfstate 
file in the repo, duplicate resources will create or errors will come, bcz terraform don't have .tfstate file to refer. 

Solution: In collaboration environments, we must maintain state file remotely that is centrally managed.

one more issue: both the developers may run terraform apply at the same time, this will also leads to errors.
locking is also important, so that we can prevent parrallel executions.
even in your laptop, while running terrafrom apply command, we can see terraform will create .tfstate lock file 
and it will not allow us to open .tfstate file. this locking is to avoid conflicts.

Even excels will lock files to avoid conflicts like this.

we can cannot keep state file in Github or locally in our laptop since it is very important file, 
the solution is to place state file in AWS S3 bucket.

*/