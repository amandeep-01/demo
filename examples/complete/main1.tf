
module "ec2_template" {
  source = "../.."

  
  prefix      = var.prefix
  description = var.description
  environment = var.environment
  #name        = var.name
  tags = var.tags
  launch_template_tags = var.launch_template_tags
  #launch_template_default_version = var.launch_template_default_version
  update_launch_template_default_version = var.update_launch_template_default_version
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  kernel_id  = var.kernel_id
  ram_disk_id = var.ram_disk_id
  
  cpu_options = var.cpu_options

  capacity_reservation_specification = var.capacity_reservation_specification

  credit_specification = var.credit_specification
  maintenance_options = var.maintenance_options

  elastic_gpu_specifications = var.elastic_gpu_specifications

  elastic_inference_accelerator= var.elastic_inference_accelerator
  
  enclave_options = var.enclave_options

  hibernation_options = var.hibernation_options
   
  instance_market_options = var.instance_market_options

  #template configure
  user_data                 = base64encode(var.user_data)
  block_device_mappings     = var.block_device_mappings
  ami_id                    = var.ami_id
  key_name                  = var.key_name
  vpc_security_group_ids    = var.vpc_security_group_ids
  ebs_optimized             = var.ebs_optimized
  instance_type             = var.instance_type
  #instance_requirement     = var.instance_requirement
  disable_api_termination   = var.disable_api_termination #enables EC2 instance termination protection
  disable_api_stop          = var.disable_api_stop
  enable_monitoring         = var.enable_monitoring
  placement                = var.placement
  license_specifications    = var.license_configuration_arn
  network_interfaces        = var.network_interfaces
  iam_instance_profile      = var.iam_instance_profile

  private_dns_name_options = var.private_dns_name_options
  
  metadata_options = var.metadata_options
}
