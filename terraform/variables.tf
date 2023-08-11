variable "bucket" {
  type = string
  default = "terraform-bucket-personal"
}

variable "region" {
  type        = string
  description = "The region in which the resources will be created"
  default     = "us-east-1"
}

variable "bucket_key" {
  type    = string
  default = "state"
}

variable "cognito_pool_name" {
  type    = string
  default = "cognito-pool"
}

variable "access_key" {}
variable "secret_key" {}
