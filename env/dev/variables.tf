variable "env" {
  type    = string
  default = "dev"
}

variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type = map(any)
  default = {
    subnets = {
      public-1a = {
        name = "public-1a",
        cidr = "10.0.10.0/24",
        az   = "ap-northeast-1a"
      },
      public-1c = {
        name = "public-1c",
        cidr = "10.0.30.0/24",
        az   = "ap-northeast-1c"
      }
    }
  }
}

variable "ami" {
  default = "ami-05207c56c1b903d1a"
}

variable "ec2_count" {
  description = "Number of EC2 instance"
  default     = "1"
}

variable "key_name" {
  type = string
  default = "terraform-test.pem"

}

variable "instance_type" {
  description = "Instance type of EC2"
  type        = string
  default     = "t3.micro"
}


variable "volume_type" {
  description = "Root block device of EC2"
  type        = string
  default     = "gp2"
}

variable "volume_size" {
  description = "Root block device size of EC2"
  default     = 100
}

variable "operation_sg_1_cidr" {
  type    = string
  default = "0.0.0.0/0"
}
