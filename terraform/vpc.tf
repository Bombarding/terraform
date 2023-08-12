
resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
}

resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_vpc_ipv4_cidr_block_association" "pub-cidr-association" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "99.18.0.0/28"
}

resource "aws_vpc_ipv4_cidr_block_association" "priv-cidr-association" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "99.18.1.0/28"
}

resource "aws_subnet" "public-subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc_ipv4_cidr_block_association.pub-cidr-association.cidr_block, 0, 0)
  availability_zone = "us-east-1a"
  depends_on = [
    aws_vpc.vpc
  ]
}

resource "aws_subnet" "private-subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc_ipv4_cidr_block_association.priv-cidr-association.cidr_block, 0, 0)
  availability_zone = "us-east-1a"
  depends_on = [
    aws_vpc.vpc
  ]
}

resource "aws_route_table" "pub-route-table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }
}

resource "aws_route_table" "priv-route-table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gateway.id
  }
}

resource "aws_route_table_association" "pub-route-table-association" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.pub-route-table.id
}

resource "aws_route_table_association" "priv-route-table-association" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.priv-route-table.id
}

resource "aws_eip" "lb" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.public-subnet.id
}
