resource "random" "random_suffix" {
    length = 8
    override_special = "_$/£@"
    special = false
}

module "s3" {
    source = "./modules/S3"
    tags = var.tags
}