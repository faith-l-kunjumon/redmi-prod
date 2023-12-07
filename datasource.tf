data "aws_route53_zone" "mydomain" {
  name         = var.hosted_zone_name
  private_zone = false
}
