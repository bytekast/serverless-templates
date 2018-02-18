variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "10.0.0.0/16"
}

variable "public_subnet1_cidr" {
  description = "CIDR for the public subnet"
  default = "10.0.1.0/24"
}

variable "public_subnet2_cidr" {
  description = "CIDR for the public subnet"
  default = "10.0.2.0/24"
}

variable "private_subnet1_cidr" {
  description = "CIDR for the private subnet"
  default = "10.0.3.0/24"
}

variable "private_subnet2_cidr" {
  description = "CIDR for the private subnet"
  default = "10.0.4.0/24"
}

variable "allowed_external_postgres_cidr" {
  description = "CIDR for Allowed Postgres Connections"
  default = "0.0.0.0/0"
}

resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_subnet" "public_subnet_us_east_1a" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "${var.public_subnet1_cidr}"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  tags = {
    Name =  "Public Subnet (us-east-1a)"
  }
}

resource "aws_subnet" "public_subnet_us_east_1b" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "${var.public_subnet2_cidr}"
  availability_zone = "us-east-1b"
  tags = {
    Name =  "Private Subnet (us-east-1b)"
  }
}

resource "aws_subnet" "private_subnet_us_east_1a" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "${var.private_subnet1_cidr}"
  availability_zone = "us-east-1a"
  tags = {
    Name =  "Private Subnet (us-east-1a)"
  }
}

resource "aws_subnet" "private_subnet_us_east_1b" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "${var.private_subnet2_cidr}"
  availability_zone = "us-east-1b"
  tags = {
    Name =  "Private Subnet (us-east-1b)"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "Default Internet Gateway"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "Public Subnet Route Table"
  }
}

resource "aws_route_table_association" "public-rt" {
  subnet_id = "${aws_subnet.public_subnet_us_east_1a.id}"
  route_table_id = "${aws_route_table.public-rt.id}"
}


resource "aws_security_group" "default_public_sg" {
  name = "default_public_sg"
  description = "Allow incoming HTTP connections, SSH access & Postgres connections"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["${var.public_subnet1_cidr}", "${var.public_subnet2_cidr}", "${var.allowed_external_postgres_cidr}"]
  }

  vpc_id="${aws_vpc.default.id}"

  tags {
    Name = "Default Public Security Group"
  }
}

resource "aws_security_group" "default_private_sg" {
  name = "default_private_sg"
  description = "Allow traffic from public subnet"
  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["${var.public_subnet1_cidr}", "${var.public_subnet2_cidr}"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["${var.public_subnet1_cidr}", "${var.public_subnet2_cidr}"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.public_subnet1_cidr}", "${var.public_subnet2_cidr}"]
  }

  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "Default Private Security Group"
  }
}