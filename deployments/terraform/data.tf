data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = ["devops-vpc"]
  }
}

data "aws_subnet" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }
  tags = {
    Name = "devops-vpc-public-subnet-1a"
  }
}