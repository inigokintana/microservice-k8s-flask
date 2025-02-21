provider "aws" {
  region = "eu-south-2"
}

# resource "aws_vpc" "myvpc" {
#   cidr_block = "10.0.0.0/16"
#   tags = {
#     Name = "myvpc"
#   }
# }
# resource "aws_subnet" "mysubnet" {
#   vpc_id     = aws_vpc.myvpc.id
#   cidr_block = "10.0.1.0/24"
#   tags = {
#     Name = "mysubnet"
#   }
# }

# Fetch the default VPC
data "aws_vpc" "default" {
  default = true
}

# Fetch the first available subnet in the default VPC
data "aws_subnet" "default_subnet" {
  vpc_id = data.aws_vpc.default.id
  availability_zone = "eu-south-2a"  # Choose the AZ where you want to create the instance
}

resource "aws_instance" "ubuntu2204" {
  ami           = "ami-080e1f13689e07408"
  instance_type = "t4g.small"
  #subnet_id     = aws_subnet.mysubnet.id
  subnet_id     = aws_subnet.default_subnet.id
  tags = {
    Name = "ubuntu2204-microk8s"
  }
}
