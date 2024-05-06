resource "aws_db_instance" "example_db" {
  engine                 = "mysql"
  db_name                = "dbtest"
  identifier             = "dbtest"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  publicly_accessible    = false #Private DB
  username               = var.db-username
  password               = var.db-password
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  #Disable taking a final backup when you destroy the database 
  skip_final_snapshot    = true 

  db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group.name

  tags = {
    Name = "example-db"
  }
}

resource "aws_db_subnet_group" "my_db_subnet_group" {
  name = "my-db-subnet-group"
  subnet_ids = [aws_subnet.sub_private_a.id, aws_subnet.sub_private_b.id]

  tags = {
    Name = "My DB Subnet Group"
  }
}

resource "aws_security_group" "db_sg" {
  name_prefix = "db_sg_"

  vpc_id = aws_vpc.my_vpc.id
  
  tags = {
    Name = "db_sg"
  }
}

#Restrict traffic to only originate from the bastion host
resource "aws_security_group_rule" "sec_group_allow_access_db" {
  security_group_id = aws_security_group.db_sg.id
  type = "ingress"
  from_port   = 3306
  to_port     = 3306
  protocol    = "tcp"
  source_security_group_id  = aws_security_group.sg_EC2_bastion_host_22.id 
}

