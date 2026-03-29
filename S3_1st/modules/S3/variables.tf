variable "s3_bucket_name" {
  type = string
}

variable "tags" {
  default = {
    "environment" = "dev"
    "purpose" = "demo"
  }
  type = map(string)
}

variable "environment" {
  default = "dev"
  type = string
}