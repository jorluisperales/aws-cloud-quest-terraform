locals {
  name           = "my-database"
  region         = "us-east-1"
  engine         = "mariadb"
  storage_type   = "gp2"
  engine_version = "10.6.14"
  db_name        = "my_database"
  username       = "admin"
  password       = "ILoveLearning!123"
  instance_class = "db.t2.micro" # Setting it to the always free option


  azs = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Name    = local.name
    Example = local.name
  }
}
