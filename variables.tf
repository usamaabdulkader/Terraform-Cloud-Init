variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability Zone for the public subnet"
  type        = string
}

# variable "tags" {
#   description = "Common tags to apply to all resources"
#   type        = map(string)
#   default     = {}
# }



# variable "vpc_id" {
#   description = "ID of the VPC"
#   type        = string
# }

# variable "subnet_id" {
#   description = "ID of the subnet where the EC2 instance will be launched"
#   type        = string
# }

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0224ce6f9504665ee"
}

variable "ssh_allowed_cidr" {
  description = "CIDR block allowed to connect through SSH"
  type        = string
}

variable "key_name" {
  description = "Name of the EC2 key pair"
  type        = string
}

