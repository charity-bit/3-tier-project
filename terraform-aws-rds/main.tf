resource "aws_db_subnet_group" "rds_subnet_group" {
      name = "${var.region}-${var.project}-rds-subnet group"
      subnet_ids = var.subnet_ids
}


#Primary RDS Instance

resource "aws_db_instance" "primary" {
    allocated_storage = var.allocated_storage
    storage_type = var.storage_type
    engine = var.db_engine
    engine_version = var.db_engine_version
    instance_class = var.db_instance_class
    db_name = "${var.region}-${var.project}-primary-rds-instance"
    username = var.username
    password = var.db_password
    parameter_group_name = var.parameter_group_name
    skip_final_snapshot = var.skip_final_snapshot
    vpc_security_group_ids = [var.vpc_security_group_id]
    db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name

  
}


#Read Replica Instance
resource "aws_db_instance" "read_replica" {
    allocated_storage = var.allocated_storage
    storage_type = var.storage_type
    engine = var.db_engine
    engine_version = var.db_engine_version
    instance_class = var.db_instance_class
    db_name = "${var.region}-${var.project}-replica-rds-instance"
    username = var.username
    password = var.db_password
    parameter_group_name = var.parameter_group_name
    skip_final_snapshot = var.skip_final_snapshot
    vpc_security_group_ids = [var.vpc_security_group_id]
    db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
    replicate_source_db = aws_db_instance.primary.identifier

  
}