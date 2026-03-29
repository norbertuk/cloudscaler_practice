resource "aws_vpc" "corp_vpc" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  region = var.region

  tags = var.tags
}

resource "aws_subnet" "corp_subnet" {
  vpc_id            = aws_vpc.corp_vpc.id
  cidr_block        = var.cidr_block
  availability_zone = "${var.region}a"
}

resource "aws_route_table" "corp_route_table" {
    vpc_id = aws_vpc.corp_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.corp_igw.id
  }
  tags = var.tags
}

resource "aws_internet_gateway" "corp_igw" {
   vpc_id = aws_vpc.corp_vpc.id
   tags = var.tags
}

resource "aws_route_table_association" "corp_route_table_association" {
  subnet_id      = aws_subnet.corp_subnet.id
  route_table_id = aws_route_table.corp_route_table.id
}

resource aws_vpc_endpoint "s3_endpoint" {
  vpc_id            = aws_vpc.corp_vpc.id
  service_name      = "com.amazonaws.${var.region}.s3"
  route_table_ids   = [aws_route_table.corp_route_table.id]
}