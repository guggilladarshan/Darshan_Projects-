variable "region" {
    type = string
    default = "us-east-1"
}

variable "instance_type" {
    type = string
    default = "t3.micro"
}

variable "ami" {
    type = string 
    default = "ami-0ecb62995f68bb549"
}

variable "vpc_id" {
    type = string
    default = "10.0.0.0/16"
}

variable "subnet_cidir" {
    type = string
    default = "10.0.1.0/24"
}

