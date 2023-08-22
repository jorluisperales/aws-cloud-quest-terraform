resource "aws_iam_group" "supportengineers" {
  name = "SupportEngineers"
}

resource "aws_iam_group_policy_attachment" "supportengineers_ec2_readonly_access" {
  policy_arn = data.aws_iam_policy.ec2_readonly_access.arn
  group      = aws_iam_group.supportengineers.name
}

resource "aws_iam_group_policy_attachment" "supportengineers_rds_readonly_access" {
  policy_arn = data.aws_iam_policy.rds_readonly_access.arn
  group      = aws_iam_group.supportengineers.name
}


resource "aws_iam_user" "support-engineer-1" {
  name = "support-engineer-1"


  tags = {
    job-title = "Support Engineer"
  }
}

resource "aws_iam_user_login_profile" "support-engineer-1" {
  user                    = aws_iam_user.support-engineer-1.name
  password_reset_required = false
}

resource "aws_iam_group_membership" "supportengineers_membership" {
  name  = aws_iam_user.support-engineer-1.name
  users = [aws_iam_user.support-engineer-1.name]
  group = aws_iam_group.supportengineers.name
}

