variable "aws_region" {
    type = string
    default = "us-east-1"
}

variable "vpc_subnet_cidr_block" {
    type = string
    default = "10.0.1.0/24"
}

variable bucket_name{
    type = string
    default = "mybucket"
}