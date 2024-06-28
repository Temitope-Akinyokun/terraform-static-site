# output "s3_website" {
#   value = module.aws_s3_bucket.s3_website
# }

output "cloudfront-domain" {
  value = module.cloudfront.cloudfront-domain-name
}

output "cloudfront-hosted_zone_id" {
  value = module.cloudfront.cloudffront-hosted_zone_id
}

output "route53" {
  value = module.aws_route53_zone.name_servers
}