
variable "name" {
  type        = string
  description = "Prefix for resource names"
}

variable "region_primary" {
  type        = string
  description = "AWS primary region"
}
variable "region_secondary" {
  type        = string
  description = "AWS secondary region"
}

variable "vpc_name_primary" {
  type = string
  description = "Name of the local vpc"
}

variable "vpc_name_secondary" {
  type = string
  description = "Name of the peer vpc"
}