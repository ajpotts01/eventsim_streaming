variable "app_name" {
  default = "eventsim-streaming"
  type        = string
  description = "Application Name"
}

variable "app_environment" {
  default = "dev"
  type        = string
  description = "Application Environment"
}

variable aws_key_id {
    type = string
}

variable aws_key_secret {
    type = string
}