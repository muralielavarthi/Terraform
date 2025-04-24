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

Provisioners are used to take some action either locally or remote when terrafrom creates servers.
2 typs of provisioners
1. local exec
2. remote exec

local - where terraform command is running that is local 
  - Mylaptop is local 
  - if run terraform command in a linux server,than that server is local

remote - inside the server created by terraform 

we use provisioners to copy files to server or server configuration after creating the server.

Provisioners will run only while servers creation time
But once servers are created, after that if we try to run provisioners it will not work.

similary while servers destroying time, we can run provisioners

USing provisioners we can configure servers, this is called bootstrapping servers.

remote exec- during terraform and Ansible integration

*/