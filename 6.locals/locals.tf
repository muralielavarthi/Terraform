locals {
  ami_id = data.aws_ami.joindevops.id #readability
  instance_type = "t3.micro" # no one can override 
  name = "${var.project}-${var.environment}-${var.component}-changed" #readability, resource name (expense-dev-backend)
}

/* 

locals are used to run the expression or functions and save the results to variable 
  1.locals are used for readability 
  2.locals can't be overriden, for example if we keep instance_type as variable this can be overriden through 
  multiple options we have, so some one can overide it as "t3.large" then this is problem and cost also will increase
  to avoid this we keep few things has locals 
*/

/* locals are used to store expressions, it can even store simple key value pairs just like variables 
variables can't store expressions, variables can't refer other variables. locals can refer other locals or variables
variables can be overriden, locals cant be overriden 

*/

/*
variable "name"{

    default="${var.project}-${var.component}-${var.environment}"

}
this not allowed, we can't use one variable inside other
*/