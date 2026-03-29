variable "region" {
    type = string
    default = "us-east-1"
}

variable "tags" {
    type = map(strings)
    default = {
        "Environment" = "dev"
        "OwnerContact" = "soltesz.norbert@gmail.com"
    }
}

variable "cidr_block" {
    type = string
    default = "10.0.0.0/16"
}