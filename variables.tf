########################
## User Variables
########################

variable "description" {
  default   = "Managed by Terraform"
}


########################
## Contact Variables
########################

# variable "MOBILE_DESCRIPTION" {
#   type          = string
#   description   = "Populate the label description based on what was selected by the user"
#   default       = "tf_mobile"
# }
# variable "TEXT_DESCRIPTION" {
#   type          = string
#   description   = "Populate the label description based on what was selected by the user"
#   default       = "tf_mobile"
# }
# variable "EMAIL_DESCRIPTION" {
#   type          = string
#   description   = "Populate the label description based on what was selected by the user"
#   default       = "Default"
# }
variable "email" {
  type          = string
}

variable "mobile" {
}
variable "country_code" {
  default     = "+1"
}
# variable "user_id" {
#   description = "capture the pagerduty user id of the person being passed to contact"
# }
variable "send_short_email" {
  default     = true
}
