locals {
  org     = "tf-core"
  project = "lab03"

  namespace = "${local.org}-${local.project}"

  # IAM에 사용할 값
  iamrole = {
    name = "instance"

    # 신뢰 정책 (trust policy)
    assume_role_policy = jsonencode({
      Version = "2012-10-17",
      Statement = [{
        Effect = "Allow"
        Action = ["sts:AssumeRole"]
        Principal = {
          Service = ["ec2.amazonaws.com"]
        }
      }]
    })

    # 권한 정책 (permission policy)
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  # 인스턴스에 사용할 값
  instance = {
    name = "ssm_test"

    ami                         = "ami-0c003e98ceffee43e"
    instance_type               = "t3.small"
    associate_public_ip_address = true

    allow_access = {
      port        = 80
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}