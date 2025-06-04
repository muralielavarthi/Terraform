resource "aws_instance" "this" {
  ami                    = "ami-09c813fb71547fc4f"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  instance_type          = "t3.micro"
  tags = {
    Name    = "terraform-demo"
    Purpose = "terraform-practice"
  }
}

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
