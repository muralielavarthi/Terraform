resource "aws_security_group" "allow-all2" {
    name = "allow-all2"
    description = "allow all 2 security group"
    #Inbound traffic
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] 
   }
   egress {
        from_port = 0
        to_port = 0
        protocol = "-1" # -1: all protocols
        cidr_blocks = ["0.0.0.0/0"]
   }
}
resource "aws_instance" "webserver" { # this name is for terrafrom reference
     ami = "ami-09c813fb71547fc4f"
     vpc_security_group_ids = [aws_security_group.allow-all2.id]
     #resource-type.security-group.id
     #referring created security group 
     instance_type = "t3.micro"
     tags = {
          Name = "webserver" # N-uppercase, name of instance
          Purpose = "terraform pratice"
     }
  
}