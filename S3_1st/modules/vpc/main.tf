resource aws_vpc "myvpc" {
    cidr_block = var.vpc_cidr_block
    tags = var.tags
}

resource aws_subnet "vpc_subnets" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = var.vpc_cidr_block
    availability_zone = [ "${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c" ]
    tags = var.tags
}

resource aws_vpc_endpoint "s3_endpoint" {
    vpc_id = aws_vpc.myvpc.id
    service_name = "com.amazonaws.${var.aws_region}.s3"
    route_table_ids = [ aws_vpc.myvpc.main_route_table_id ]
}

resource aws_vpc_route "s3_route" {
    route_table_id = aws_vpc.myvpc.main_route_table_id
    destination_cidr_block = "0.0.0.0/0"
    vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
}