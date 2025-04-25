resource "aws_instance" "this" {
  ami                    = "ami-09c813fb71547fc4f"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  instance_type          = "t3.micro"
  tags = {
    Name    = "terraform-demo"
    Purpose = "terraform-practice"
  }
}
/* 
this - this name is for terraform reference
terraform-demo - this name we will appear for ec2-instance
tags are usefull for filteration purpose.
*/

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls_1"
  description = "Allow TLS inbound traffic and all outbound traffic"

  #inbound traffic
  ingress { 
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 #outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1: all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls" # in Name - N is uppercase in tags
  }
}

/* 

resource "resource-type" "resource-name" {
    key= value pairs
}
*/

/* AWS will create dependencies first and after that it will create actual resources irrespective of code sequence

Creation: security group and then ec2-instance
Destroy: ec2-instance and security group

*/

/* commands

terraform plan
terraform validate
terraform apply -auto-approve 
terraform fmt - read tf files and do formatting and will keep spacing correctly.
*/