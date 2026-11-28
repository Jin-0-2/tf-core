# 신뢰 정책
resource "aws_iam_role" "instance" {
  name = "${local.namespace}-iamrole-${local.iamrole.name}"

  assume_role_policy = local.iamrole.assume_role_policy

  tags = {
    Name = "${local.namespace}-iamrole-${local.iamrole.name}"
  }
}

# IAM Role
resource "aws_iam_role_policy_attachment" "instance" {
  role = aws_iam_role.instance.name

  # 권한 정책
  policy_arn = local.iamrole.policy_arn
}

# IAM profile
resource "aws_iam_instance_profile" "instance" {
  name = "${local.namespace}-iamrole-${local.iamrole.name}"
  role = aws_iam_role.instance.name

  tags = {
    Name = "${local.namespace}-iamrole-${local.iamrole.name}"
  }
}

# 보안 그룹
resource "aws_security_group" "instance" {
  name = "${local.namespace}-sg-instance"

  ingress {
    from_port   = local.instance.allow_access.port
    to_port     = local.instance.allow_access.port
    protocol    = "tcp"
    cidr_blocks = local.instance.allow_access.cidr_blocks
  }

  # 아웃 바운드는 고정이라 local로 안뺌
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
  ami           = local.instance.ami
  instance_type = local.instance.instance_type
  # 공인 IP 제공
  associate_public_ip_address = local.instance.associate_public_ip_address

  vpc_security_group_ids = [aws_security_group.instance.id]
  iam_instance_profile   = aws_iam_instance_profile.instance.name

  # 명시적으로 의존 관계 선언
  depends_on = [aws_iam_role_policy_attachment.instance]

  # 태그
  tags = {
    Name = "${local.namespace}-instance-${local.instance.name}"
  }
}