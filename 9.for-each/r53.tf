resource "aws_route53_record" "expense" {
  for_each = aws_instance.this # copying output to for_each (aws_instance.this, have output of instance created)
  zone_id = var.zone_id
  name    = each.key == "frontend" ? var.domain_name : "${each.key}.${var.domain_name}"
  type    = "A"
  ttl     = 1
  records = each.key == "frontend" ? [each.value.public_ip] : [each.value.private_ip]
  allow_overwrite = true
}

/* each will be accessible only with in this block, we can't access outside of the block */