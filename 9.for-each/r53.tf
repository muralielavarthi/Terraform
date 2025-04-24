resource "aws_route53_record" "expense" {
  for_each = aws_instance.this # copying output to for_each (aws_instance.this, have output of instance created)
  zone_id = var.zone_id
  name    = local.record_name
  type    = "A"
  ttl     = 1
  records = local.records
  allow_overwrite = true
}