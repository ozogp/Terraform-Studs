variable "prefix" {
  type        = string
  description = "Naming prefix, e.g. tfcourse-ab (your initials)."
  # TODO: add a validation block allowing only lowercase letters and digits + dash
}

variable "location" {
  type        = string
  description = "Azure region."
  default     = "polandcentral"
}

variable "owner" {
  type        = string
  description = "Owner tag value (email)."
}
