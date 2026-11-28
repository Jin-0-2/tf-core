# 신뢰 정책
resource "aws_iam_role" "instance" {
  name = "${local.namespace}-iamrole-instance"

  assume_role_policy = jsonencode (
    {
      Version = "2012-10-17",
      Statement = [{
        Effect = "Allow"
        Action = ["sts:AssumeRole"]
        Principal = {
          Service = ["ec2.amazonaws.com"]
        }
      }]
  })

  tags = {
    Name = "${local.namespace}-iamrole-instance"
  }
}

# IAM Role
resource "aws_iam_role_policy_attachment" "instance" {
    role = aws_iam_role.instance.name

    # 권한 정책
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# IAM profile
resource "aws_iam_instance_profile" "instance" {
  name = "${local.namespace}-iamprofile-instance"
  role = aws_iam_role.instance.name

  tags = {
    Name = "${local.namespace}-iamprofile-instance"
  }
}

# 보안 그룹
resource "aws_security_group" "instance" {
  name = "${local.namespace}-sg-instance"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.namespace}-sg-instance"
  }
}

# 인스턴스 만들기
resource "aws_instance" "ssm_test" {
  ami = "ami-0c003e98ceffee43e"
  instance_type = "t3.small"
  vpc_security_group_ids = [aws_security_group.instance.id]
  iam_instance_profile = aws_iam_instance_profile.instance.name

  # 명시적으로 의존 관계 선언
  depends_on = [ aws_iam_role_policy_attachment.instance ]

  tags = {
    Name = "${local.namespace}-instance-ssm-test"
  }
}