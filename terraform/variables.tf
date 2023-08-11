variable "bucket" {
  type = string
}

variable "region" {
  type        = string
  description = "The region in which the resources will be created"
  default     = "us-east-1"
}

variable "access_key" {
  type        = string
  description = "The aws development account access key"
}

variable "secret_key" {
  type        = string
  description = "The aws development account secret key"
}

variable "bucket_key" {
  type    = string
  default = "state"
}

variable "cognito_pool_name" {
  type    = string
  default = "cognito-pool"
}
