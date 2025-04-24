locals {
  record_name=each.key == "frontend" ? var.domain_name : "${each.key}.${var.domain_name}"
  records=each.key == "frontend" ? [each.value.public_ip] : [each.value.private_ip]
}