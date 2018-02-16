variable "env" { default = "dev" }
variable "region" { default = "us-east-1" }
variable "profile" { default = "bytekast"} // replace with your own aws profile

provider "aws" {
  version = ">= 1.2"
  region = "${var.region}"
  profile = "${var.profile}"
}
