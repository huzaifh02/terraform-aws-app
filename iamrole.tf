resource "aws_iam_role" "elasticbeanstalk_ec2_role" {
  name = "aws-elasticbeanstalk-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "elasticbeanstalk_web_tier" {
  role       = aws_iam_role.elasticbeanstalk_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_role_policy_attachment" "elasticbeanstalk_worker_tier" {
  role       = aws_iam_role.elasticbeanstalk_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier"
}

resource "aws_iam_role_policy_attachment" "elasticbeanstalk_multicontainer_docker" {
  role       = aws_iam_role.elasticbeanstalk_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
}

resource "aws_iam_instance_profile" "elasticbeanstalk_instance_profile" {
  name = "aws-elasticbeanstalk-ec2-role"
  role = aws_iam_role.elasticbeanstalk_ec2_role.name
}
