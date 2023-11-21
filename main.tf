resource "aws_instance" "bastion" {
  ami                         = "ami-0fa1ca9559f1892ec"
  instance_type               = "t2.micro"
  key_name                    = "wordpress-ec2-sshkey-1"
  security_groups             = [aws_security_group.ssh_subnet_sc.id]
  subnet_id                   = aws_subnet.terraform_public_01.id
  associate_public_ip_address = true
  tags = {
    Name = "bastion"
  }
  lifecycle {
    ignore_changes = [
      associate_public_ip_address,
      security_groups
    ]
  }
}

resource "aws_instance" "wordpress" {
  ami                         = "ami-0fa1ca9559f1892ec"
  instance_type               = "t2.micro"
  key_name                    = "wordpress-ec2-sshkey-1"
  security_groups             = [aws_security_group.private_subnet_sc.id]
  subnet_id                   = aws_subnet.terraform_private_02.id
  associate_public_ip_address = false
  tags = {
    Name = "wordpress"
  }
  lifecycle {
    ignore_changes = [
      associate_public_ip_address,
      security_groups
    ]
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.terraform_public_01.id
  tags = {
    Name = "gw NAT"
  }
}

resource "aws_eip" "eip" {
  vpc = true
}
