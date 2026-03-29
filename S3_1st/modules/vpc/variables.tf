variable "aws_region" {
    type = string
}

variable "vpc_cidr_block" {
    type = string
}

variable "tags" {
    type = map(string)
}