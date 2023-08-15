################################################################################
# RDS Module
################################################################################

resource "aws_db_instance" "my_database" {
  identifier            = local.name
  instance_class        = local.instance_class
  storage_type          = local.storage_type
  max_allocated_storage = 1000 # This enabled Storage autoscaling
  allocated_storage     = 20
  engine                = local.engine
  engine_version        = local.engine_version

  db_name  = local.db_name
  username = local.username
  password = local.password


  multi_az               = true
  vpc_security_group_ids = [aws_default_security_group.default.id]
  publicly_accessible    = false

  parameter_group_name = "default.mariadb10.6"

  # Enhanced monitoring
  monitoring_interval = 30
  monitoring_role_arn = aws_iam_role.rds_enhanced_monitoring.arn

  performance_insights_enabled = false
  #performance_insights_retention_period = 7

  # Enable automated backups
  backup_retention_period = 7

  storage_encrypted          = false # This I disable in order to use db.t2.micro
  auto_minor_version_upgrade = false

  skip_final_snapshot = true
}


resource "aws_db_instance" "my_database_read" {
  identifier             = "my-database-read"
  replicate_source_db    = aws_db_instance.my_database.identifier ## refer to the master instance
  instance_class         = local.instance_class
  max_allocated_storage  = 1000 # This enabled Storage autoscaling
  engine                 = local.engine
  engine_version         = local.engine_version
  skip_final_snapshot    = true
  publicly_accessible    = false
  vpc_security_group_ids = [aws_default_security_group.default.id]
  # disable backups to create DB faster
  backup_retention_period = 0
}
