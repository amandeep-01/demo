output "arn" {
  description = "Amazon Resource Name (ARN) of the launch template"
  value       = aws_launch_template.mytemplate.arn
}

output "id" {
  description = "The ID of the launch template"
  value       = aws_launch_template.mytemplate.id
}

output "latest_version"{
  description = "the latest version of the template"
  value = aws_launch_template.mytemplate.latest_version
}

output "tags_all" {
  description = "A map of tags assigned to the resource"
  value = aws_launch_template.mytemplate.tags_all

}