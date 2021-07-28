/*
# Modules to create Users and Contact Methods for users  
# Required User inputs are:  
#   -  name  
#   -  email  
# Outputs:  
#   -  user_id 

*/

terraform {
#   required_version = ">= 0.12"
  required_providers {
    pagerduty = {
      source = "PagerDuty/pagerduty"
    #   version = "1.9.3"
    }
  }
}

data "pagerduty_user" "pd_user" {
  email = (var.email)
}

########################
## User Template Module
########################
# resource "pagerduty_user" "pd_user" {
#   name          = var.name
#   # email         = var.email
#   # role          = var.role
#   # job_title     = var.job_title
#   description   = var.description
# }


########################
## Contact Method Template Modules
########################
resource "pagerduty_user_contact_method" "pd_contact_phone" {
  user_id      		  = data.pagerduty_user.pd_user.id
  type         		  = "phone_contact_method"
  country_code 		  = var.country_code
  address      		  = var.mobile
  label        		  = "tf_mobile"
}

resource "pagerduty_user_contact_method" "pd_contact_sms" {
  user_id      		  = data.pagerduty_user.pd_user.id
  type         		  = "sms_contact_method"
  country_code 		  = var.country_code
  address      		  = var.mobile
  send_short_email	= var.send_short_email
  label        		  = "tf_mobile"
}






data "pagerduty_user_contact_method" "mobile" {
  user_id = data.pagerduty_user.pd_user.id
  type    = "phone_contact_method"
  label   = pagerduty_user_contact_method.pd_contact_phone.label
}
data "pagerduty_user_contact_method" "text" {
  user_id = data.pagerduty_user.pd_user.id
  type    = "sms_contact_method"
  label   = pagerduty_user_contact_method.pd_contact_sms.label
}
data "pagerduty_user_contact_method" "work_email" {
  user_id = data.pagerduty_user.pd_user.id
  type    = "email_contact_method"
  label   = "Default"
}


################  
# High Urgency  
################  
####  SMS  ####  
resource "pagerduty_user_notification_rule" "high_7m_urgency_sms" {
  user_id                = data.pagerduty_user.pd_user.id
  start_delay_in_minutes = 7
  urgency                = "high"

  contact_method = {
    type = "sms_contact_method"
    id   = data.pagerduty_user_contact_method.text.id
  }
}
resource "pagerduty_user_notification_rule" "high_12m_urgency_sms" {
  user_id                = data.pagerduty_user.pd_user.id
  start_delay_in_minutes = 12
  urgency                = "high"

  contact_method = {
    type = "sms_contact_method"
    id   = data.pagerduty_user_contact_method.text.id
  }
}
resource "pagerduty_user_notification_rule" "high_17m_urgency_sms" {
  user_id                = data.pagerduty_user.pd_user.id
  start_delay_in_minutes = 2
  urgency                = "high"

  contact_method = {
    type = "sms_contact_method"
    id   = data.pagerduty_user_contact_method.text.id
  }
}

####  CALL  ####  
resource "pagerduty_user_notification_rule" "high_5m_urgency_mobile" {
  user_id                = data.pagerduty_user.pd_user.id
  start_delay_in_minutes = 5
  urgency                = "high"

  contact_method = {
    type = "phone_contact_method"
    id   = data.pagerduty_user_contact_method.mobile.id
  }
}
resource "pagerduty_user_notification_rule" "high_10m_urgency_mobile" {
  user_id                = data.pagerduty_user.pd_user.id
  start_delay_in_minutes = 10
  urgency                = "high"

  contact_method = {
    type = "phone_contact_method"
    id   = data.pagerduty_user_contact_method.mobile.id
  }
}
resource "pagerduty_user_notification_rule" "high_15m_urgency_mobile" {
  user_id                = data.pagerduty_user.pd_user.id
  start_delay_in_minutes = 15
  urgency                = "high"

  contact_method = {
    type = "phone_contact_method"
    id   = data.pagerduty_user_contact_method.mobile.id
  }
}

####  EMAIL  ####  
resource "pagerduty_user_notification_rule" "high_urgency_email" {
  user_id                = data.pagerduty_user.pd_user.id
  start_delay_in_minutes = 17
  urgency                = "high"

  contact_method = {
    type = "email_contact_method"
    id   = data.pagerduty_user_contact_method.work_email.id
    send_short_email  = true

  }
}


################  
# Low Urgency  
################  
resource "pagerduty_user_notification_rule" "low_urgency_email" {
  user_id                = data.pagerduty_user.pd_user.id
  start_delay_in_minutes = 1
  urgency                = "low"

  contact_method = {
    type = "email_contact_method"
    id   = data.pagerduty_user_contact_method.work_email.id
    send_short_email  = true
  }
}


########################  
## PagerDuty User Resource Schema  
## Pulled from https://github.com/terraform-providers/terraform-provider-pagerduty/blob/master/pagerduty/resource_pagerduty_user.go  
########################  
/*

*/
