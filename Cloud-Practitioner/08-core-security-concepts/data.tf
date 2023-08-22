#ec2 ReadOnly
data "aws_iam_policy" "ec2_readonly_access" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

#rds ReadOnly
data "aws_iam_policy" "rds_readonly_access" {
  arn = "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess"
}
