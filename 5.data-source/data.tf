data "aws_ami" "joindevops" {
    most_recent      = true  #latest ami details, this should be true always
    owners           = ["973714476881"]
    
    filter { # multiple filters are used to find ami details
        name   = "name"
        values = ["RHEL-9-DevOps-Practice"]
    }

    filter {
        name   = "root-device-type"
        values = ["ebs"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
}

data "aws_vpc" "default" {
  default = true
}

output  "ami_id" {
  value       = data.aws_ami.joindevops.id
}

output "default_vpc_id" {
    value = data.aws_vpc.default.id
}

/* 

what is data sources ? 
- data sources are used to query existing information from the provider
Example: devops-practice ==> ami-24242445ixuyd ==> ami id changes when new updates are posted to ami.
So, we can't hard code ami id in the code, during runtime we have to fetch this dynamically from AWS using data sources.

- we are reading existing resource information using "data"

data "resource-type" "resource-name" {
 key=value parameters
}

- we will create data.tf file for this.
*/