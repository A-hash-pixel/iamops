resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw"
  }
}

resource "aws_nat_gateway" "nat-1" {
  #   allocation_id = aws_eip.example.id
  subnet_id = aws_subnet.public-subnet-1.id

  tags = {
    Name = "NAT-1"
  }
  depends_on = [aws_internet_gateway.igw]
}


resource "aws_nat_gateway" "nat-2" {
  #   allocation_id = aws_eip.example.id
  subnet_id = aws_subnet.public-subnet-2.id

  tags = {
    Name = "NAT-1"
  }
  depends_on = [aws_internet_gateway.igw]
}