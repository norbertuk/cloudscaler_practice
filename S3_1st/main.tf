module "s3_bucket" {
    source = "./modules/S3"
    s3_bucket_name = "mybucket"
    tags = {
        "environment" = "dev"
        "purpose" = "demo"
    }
}

module "vpc" {
    source = "./modules/vpc"
    aws_region = var.aws_region
    vpc_cidr_block = var.vpc_subnet_cidr_block
    tags = map(var.tags)
}