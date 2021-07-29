


output "user_id" {
  value = "user_id"
}

output "id" {
  value = data.pagerduty_user.pd_user.id
}
