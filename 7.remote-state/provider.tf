terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
  }

  backend "s3" {
    bucket = "murali-terraform-state"
    key    = "expense-backend-infra" 
    # you should have unique keys with in the bucket, same key should not be used in other repos or tf projects
    # A file will created with "expense-backend-infra" name and state will be stored in this file.
    region = "us-east-1"
    dynamodb_table = "murali-terraform-state-locking"
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

/*
S3 buket: Simple storage service in cloud, where you store objects (files, data, etc.)
  1.S3 buket name should be unique, all bukets in AWS should be unique
  2. Dynamo DB partion key id: LockID (same cases)
  - when we run terraform apply , it will keep lock files in dynamo DB so that no one can edit.
  - lock file present in dynamo db means, no one can run terraform apply command since state file is locked.
  - for locking we use only dynamodb not mysql, this is how terraform is designed
 
 S3 bucket permissions should be restricted, others projects should have access to this bucket.
will restrict access to S3 bucket, everyone can't access this.

 "">aws configure" should be done before doing this, to authenticate.
  -- first terraform will acquire state file lock then it will proceed further.
 */

 /*
 this configuration is doen inside provider.tf
 */

/* we keep state file S3 bucket for safety, security and collaboration

S3 bucket: state file (we can download and see it)
Dynamo DB: lockfiles 
*/

/* .tf file names should be unique */
/* mostly one s3 bucket will be there for one project. if project is very big also they can seperate it by creating 
different keys for backend, frontend, database in the same bucket 

- terraform will sort out dependecies

 2 instances with tagged with same security group

 1 instance destroyed and now if you try to delete security group, it wil throw error, since there is one more
 instance tagged with same security group.
*/




