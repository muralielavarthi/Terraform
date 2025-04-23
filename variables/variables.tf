variable "ami_id" {
  type        = string
  default     = "ami-09c813fb71547fc4f"
  description = "This is RHEL9 AMI ID"
}

variable "instance_type" {
    #default = "t3.micro"
}

variable "ec2_tags" {
    type = map
    default = {
        Project = "expense"
        Component = "backend"
        Environment = "dev"
        Name = "expense-backend-dev"
    }
}

variable "from_port" {
    type = number
    default = 22
}

variable "to_port" {
    type = number
    default = 22
}

variable "cidr_blocks" {
    type = list(string)
    default = ["0.0.0.0/0"]
}

variable "sg_tags" {
    type = map
    default = {
        Name = "expense-backend-dev"
    }
}
/* 
 > terraform fmt - it will read tf files and do formatting and will keep spacing correctly.

We can give any file names in terraform, but for readability we will give meaningful names

Variable data types - string, number, list, map, bool
variable "variable-name" {
         type = 
            default = ""
    }

How to override default values in terraform ??

Variable preferences, terraform will search for value as per the below order:

1.command line ==> terraform plan -var "<var-name>=<var-value>"
2.tfvars file (terraform.tfvars) - variable(<var-name>=<var-value>) placed in terraform.tfvars file
here, we are keeping, all variables in separate file.
3.environment variables ==> export TF_VAR_<var-name>=<var-value>
unset TF_VAR_<var-name>=<var-value>
4.default values
5.user prompt (variable value is not provided any where, it is will ask value from prompt)  
 */

 /*
 For names, we follow the below best practices because it is easy to understand
  when we look at terraform files. Here, we can easily understand the name.

  variable "ec2_tags" {
    type = map
    default = {
        Project = "expense"
        Component = "backend"
        Environment = "dev"
        Name = "expense-backend-dev"
    }
}
  */