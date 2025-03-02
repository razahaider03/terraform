variable "aws_instance_type" {
  description = "Enter the instance type ?"
  validation {
    condition = var.aws_instance_type=="t3.micro" || var.aws_instance_type=="t2micro" 
    error_message = "t2 and t3 micro allowed"
  }
#   default = "t3.micro"
}

variable "additional_tags" {
  type = map(string)  #expecting key value format
  default = {
    
  }
}

variable "EC2-config" {
  type = object({
    v_size  = number
    v_type = string
  })
  default = {
    v_size = 30
    v_type = "gp2"
  }
}

