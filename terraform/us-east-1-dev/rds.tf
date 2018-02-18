variable "demo_db_password" {}

resource "aws_db_instance" "demo_db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "9.6.5"
  instance_class       = "db.t2.micro"
  identifier           = "${var.env}-demo-db-instance"
  name                 = "${var.env}_demo_db"
  username             = "${var.env}_demo_user"
  password             = "${var.demo_db_password}"
  final_snapshot_identifier = "${var.env}-demo-db-instance-final"
  publicly_accessible = true
  vpc_security_group_ids = ["${aws_security_group.default_public_sg.id}"] // TODO - make private
  db_subnet_group_name   = "${aws_db_subnet_group.rds_subnet_group.id}"
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds_subnet_group"
  subnet_ids = ["${aws_subnet.public_subnet_us_east_1a.id}", "${aws_subnet.public_subnet_us_east_1b.id}"] // TODO - make private

  tags {
    Name = "rds-subnet-group"
  }
}

output "demo_db_instance_username" {
  value = "${aws_db_instance.demo_db.username}"
}

output "demo_db_instance_password" {
  value = "${aws_db_instance.demo_db.password}"
}

output "demo_db_instance_name" {
  value = "${aws_db_instance.demo_db.name}"
}

output "demo_db_instance_address" {
  value = "${aws_db_instance.demo_db.address}"
}