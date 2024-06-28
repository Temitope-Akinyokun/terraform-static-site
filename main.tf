provider "aws" {
  region = "us-east-1"
}

module "s3_bucket" {
  source = "./modules/s3_bucket"
}

module "cloudfront" {
  source = "./modules/cloudffront"
  bucket_id = module.s3_bucket.bucket_id
  bucket_arn = module.s3_bucket.bucket_arn
}

module "route53" {
  source = "./modules/route53"
  cloudfront-domain = module.cloudfront.cloudfront-domain-name
  cloudffront-hosted_zone_id = module.cloudfront.cloudffront-hosted_zone_id
}

module "aws_iam_role_policy_attachment" {
  source = "./modules/iam_roles"
}

module "aws_acm_certificate" {
  source = "./modules/certificate"
  aws_route53_zone_id = module.route53.aws_route53_zone_id
}