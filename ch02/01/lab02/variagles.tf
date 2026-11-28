variable "env" {
  type    = string
  default = "dev"

  description = "Deploy Environment"
}

variable "port" {
  type = number
  default = 80
}

variable "associate_public_ip_addres" {
  type = bool
  default = false
}

variable "cidr_blocks" {
  type = list(string)
  default = ["10.0.1.0/16", "10.0.2.0/16", "10.0.3.0/16",]
}

variable "ports" {
  type = list(number)
  default = [80, 8080, 8000]
}