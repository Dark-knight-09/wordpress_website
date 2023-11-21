resource "aws_db_subnet_group" "terraform_db_subnet_group" {
  subnet_ids = [aws_subnet.terraform_private_03.id, aws_subnet.terraform_private_02.id]
  tags = {
    Name = "terraform_db_subnet_group"
  }
}

resource "aws_db_instance" "terraform_db_instance" {
  identifier             = "terraform-db"
  allocated_storage      = 5
  storage_type           = "standard"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t2.micro"
  name                   = "terraform_db"
  username               = "admin"
  password               = "12345678"
  parameter_group_name   = "default.mysql8.0"
  db_subnet_group_name   = aws_db_subnet_group.terraform_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.database_subnet_sc.id]
  skip_final_snapshot    = true
  tags = {
    Name = "terraform_db"
  }
}

resource "aws_efs_file_system" "Terraform_efs" {
  creation_token   = "Terraform_efs"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = false
  tags = {
    Name = "Terraform_efs"
  }

}