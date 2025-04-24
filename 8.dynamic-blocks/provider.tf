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

/* notes:

resource "aws_security_group" "allow_tls" {
  
    # this is a block

  ingress {
     # this is a block
  }
  egress {
    # this is a block
  }

-Countbased and foreach loops are used to create multiple resources 
-Dynamic blocks: dynamic blocks are used to create multiple blocks inside a resource 
 Ex: if you want to allow mulitple ports in a security group

*/