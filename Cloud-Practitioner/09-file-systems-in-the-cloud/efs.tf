resource "aws_efs_file_system" "petmodels_efs_1" {
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = true
  tags = {
    Name = "PetModels-EFS-1"
  }
}


resource "aws_efs_mount_target" "petmodels_efs_1_mount" {
  file_system_id  = aws_efs_file_system.petmodels_efs_1.id
  subnet_id       = aws_subnet.petmodels_pubsub_1.id
  security_groups = [aws_security_group.petmodels_efs_1_sg.id]
}

resource "aws_efs_mount_target" "petmodels_efs_2_mount" {
  file_system_id  = aws_efs_file_system.petmodels_efs_1.id
  subnet_id       = aws_subnet.petmodels_pubsub_2.id
  security_groups = [aws_security_group.petmodels_efs_1_sg.id]
}

resource "aws_efs_mount_target" "petmodels_efs_3_mount" {
  file_system_id  = aws_efs_file_system.petmodels_efs_1.id
  subnet_id       = aws_subnet.petmodels_pubsub_3.id
  security_groups = [aws_security_group.petmodels_efs_1_sg.id]
}
