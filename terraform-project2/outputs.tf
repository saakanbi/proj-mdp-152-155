output "kops_state_store_bucket" {
  description = "The name of the S3 bucket used for Kops state storage"
  value       = aws_s3_bucket.kops_state_store.bucket
}

output "kops_state_store_uri" {
  value = "s3://${aws_s3_bucket.kops_state_store.bucket}"
}

output "dns_zone_id" {
  value = aws_route53_zone.k8s_zone.zone_id
}
