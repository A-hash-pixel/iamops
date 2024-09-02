resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route"
  }
}

resource "aws_route_table_association" "public-route-association-1" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public-route.id
}

resource "aws_route_table_association" "public-route-association-2" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.public-route.id
}

resource "aws_route_table" "private-route-1" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-1.id
  }

  route {
    cidr_block = "10.0.0.0/24"
    gateway_id = "local"
  }

  tags = {
    Name = "private-route-1"
  }
}


resource "aws_route_table" "private-route-2" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-2.id
  }

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = "local"
  }

  tags = {
    Name = "private-route-2"
  }
}

resource "aws_route_table_association" "pprivate-route-association-1" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private-route-1.id
}

resource "aws_route_table_association" "private-route-association-2" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private-route-2.id
}