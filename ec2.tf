resource "aws_instance" "mern-curd" {
  ami           = "ami-0522ab6e1ddcc7055"
  instance_type = "t3.micro"
  root_block_device {
    delete_on_termination = true
    volume_size           = "50"
  }
  subnet_id              = aws_subnet.private-subnet-1.id
  vpc_security_group_ids = [aws_security_group.mern-sg-id.id]
  user_data              = file("${path.module}/user-data/data.sh")
  key_name = aws_key_pair.ssh-dev.id
  tags = {
    Name = "Mern-crud"
  }
}