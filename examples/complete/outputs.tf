output "template_arn" {
  value       = module.ec2_template.arn
  description = "template arn"
}

output "template_id" {
  value       = module.ec2_template.id
  description = "template id"
}

output "template_latest_version" {
  value       = module.ec2_template.latest_version
  description = "template latest version"
}

output "template_tags" {
  value       = module.ec2_template.tags_all
  description = "template tags"
}

