resource "aws_security_group" "web" {
  name = "${local.org}-${local.project}-sg-web"

  tags = {
    Name = "${local.org}-${local.project}-sg-web"
  }
}