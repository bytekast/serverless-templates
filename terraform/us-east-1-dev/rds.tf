variable "demo_db_password" {}

resource "aws_db_instance" "demo-db" {
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
}