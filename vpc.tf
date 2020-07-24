provider "aws" {
  region     = "${var.region}"
}

resource "aws_vpc" "main" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"

  tags = {
    Name = "main"
    Location = "Bangalore"
  }
}

resource "aws_subnet" "subnet1"{
  count = "${length(data.aws_availability_zones.azs.names)}"
  availability_zone ="${element(data.aws_availability_zones.azs.names,count.index)}"
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${element(var.subnet_cidr,count.index)}"

  tags = {
    Name = "Subnet-${count.index+1}"
  }
}
