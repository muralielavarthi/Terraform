resource "aws_instance" "expense" {
  count = length(var.instances)
  # count = 3  - this will create three instances with same name
  ami                    = "ami-09c813fb71547fc4f"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  instance_type          = "t3.micro"
  /* tags = {
    Name    = var.instances[count.index]
  } 
  
  var.instances[0] = mysql
  var.instances[1] = backend
  var.instances[1] = frontend
  
  */
  tags = merge(
    var.common_tags,
    {
        Name = var.instances[count.index]
    }
  )
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
