resource "aws_instance" "this" {
  ami                    = "ami-09c813fb71547fc4f" # This is our devops-practice AMI ID
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  instance_type          = "t3.micro"
  tags = {
    Name    = "terraform-demo"
    Purpose = "terraform-practice"
  }

  provisioner "local-exec" {
    command = "echo ${self.private_ip} > inventory" 
    # locally in mylaptop it will echo by creating a file
    # self object is reffering to ec2 instance we created
    # self is nothing but aws_instance.this
  }

  connection { # this block is for only remote-exec, since it has to connect to server and take action
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = self.public_ip
  }
  # keeping passwords here, is not secure, we have use SSM paramters to store this.

  provisioner "remote-exec" { #creation time provisioner
    inline = [ # in this list we can write multiple commands.
      "sudo dnf install nginx -y",
      "sudo systemctl start nginx",
    ]
  }

  # gracefull shut down (best practice) - instead of directly shutting down, 
  # we have to stop everything inside in the server and then do the shut down

  provisioner "remote-exec" { #destroy time provisioner
    when = destroy
    inline = [
      "sudo systemctl stop nginx",
    ]
  }

}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80 # this is required to connect to server on http
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}