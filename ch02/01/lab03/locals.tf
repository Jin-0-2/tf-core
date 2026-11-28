locals {
  org = "tf-core"
  project = "lab01"

  namespace = "$(local.org)-$(local.project)"

  sg = {
    name = format("%s-%s-sg-web", local.org, local.project)

    tag = {
        Name = join("-", [local.org, local.project, "sg", "web"])
    }
  } 
  
  instance = {
    ami = "ami-238409108"
    instance_type = var.env == "dev" ? "t3.large" : "t3.small"
  }
}