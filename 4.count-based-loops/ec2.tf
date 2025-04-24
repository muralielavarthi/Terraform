resource "aws_instance" "expense" {
  count = length(var.instances) # length function
  # count = 3  - this will create three instances with same name
  ami                    = "ami-09c813fb71547fc4f"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  instance_type          = "t3.micro"
  /* tags = {
    Name    = var.instances[count.index] # indexing starts from zero
  } 
  
  count.index will give 0,1,2 values
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

/* 3 types of Loops in terraform:
    1.count based loops - iterate over list type of variables and create resources then this is usefull.
    2.for each loops
    3.dynamic blocks

Count based loops:
- I want to create 3 ec2 instances - mysql, backend, frontend
- 2 r53 private IP address
- 1 r53 public IP address
*/

/* we can't create custom functions in terraform

  terraform console - we can pratice terraform code here.

 interview: what are the functions you have used in your project.
*/

/* join function - list to string

> join(" ", ["murali","kunmar"]) 
"murali kunmar"
- exit

split - string to list

> split(" ","murali elavarthi")
tolist([
  "murali",
  "elavarthi",
])

*/

/*

course1= {

  Name="Devops"
  Duration="120hrs"
}

course2= {

  Name="terraform"
  Duration="120hrs"
}

merge(course1,course2)

output: second map will replace first one here. all key pairs will be there but same will be merge.
Name=terraform
Duration="120hrs"

*/
/*.gitignore should be present in root level in project, without this you can't push code to github, you will see errors.
*/

/* here each sub folder is like seperate project, terraform commands will not work in root level,

because there no .tf files */



