output "cloudfront-domain" {
  value = module.cloudfront.cloudfront-domain-name
}

output "cloudfront-hosted_zone_id" {
  value = module.cloudfront.cloudffront-hosted_zone_id
}

output "route53" {
  value = module.route53.name_servers
}