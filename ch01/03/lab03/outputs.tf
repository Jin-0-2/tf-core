output "vpc" {
  value = {
    id  = aws_vpc.main.id
    arn = aws_vpc.main.arn
  }
}