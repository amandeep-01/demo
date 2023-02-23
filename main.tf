resource "aws_launch_template" "mytemplate" {
  
  name = var.name
  name_prefix = var.prefix
  description = var.description

  ebs_optimized = var.ebs_optimized
  image_id      = var.ami_id

  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = var.user_data

  vpc_security_group_ids = var.vpc_security_group_ids

  default_version                      = var.launch_template_default_version
  update_default_version               = var.update_launch_template_default_version
  disable_api_termination              = var.disable_api_termination
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  kernel_id                            = var.kernel_id
  ram_disk_id                          = var.ram_disk_id

  dynamic "block_device_mappings" {
    for_each = var.block_device_mappings
    content {
      device_name  = block_device_mappings.value.device_name
      no_device    = lookup(block_device_mappings.value, "no_device", null)
      virtual_name = lookup(block_device_mappings.value, "virtual_name", null)

      dynamic "ebs" {
        for_each = flatten([lookup(block_device_mappings.value, "ebs", [])])
        content {
          delete_on_termination = lookup(ebs.value, "delete_on_termination", null)
          encrypted             = lookup(ebs.value, "encrypted", null)
          kms_key_id            = lookup(ebs.value, "kms_key_id", null)
          iops                  = lookup(ebs.value, "iops", null)
          throughput            = lookup(ebs.value, "throughput", null)
          snapshot_id           = lookup(ebs.value, "snapshot_id", null)
          volume_size           = lookup(ebs.value, "volume_size", null)
          volume_type           = lookup(ebs.value, "volume_type", null)
        }
      }
    }
  }

  dynamic "capacity_reservation_specification" {
    for_each = var.capacity_reservation_specification != null ? [var.capacity_reservation_specification] : []
    content {
      capacity_reservation_preference = lookup(capacity_reservation_specification.value, "capacity_reservation_preference", null)

      dynamic "capacity_reservation_target" {
        for_each = try([capacity_reservation_specification.value.capacity_reservation_target], [])
        content {
          capacity_reservation_id = lookup(capacity_reservation_target.value, "capacity_reservation_id", null)
          capacity_reservation_resource_group_arn =lookup(capacity_reservation_target.value,"capacity_reservation_resource_group_arn",null)
        }
      }
    }
  }

  dynamic "cpu_options" {
    for_each = var.cpu_options != null ? [var.cpu_options] : []
    content {
      core_count       = cpu_options.value.core_count
      threads_per_core = cpu_options.value.threads_per_core
    }
  }

  dynamic "credit_specification" {
    for_each = var.credit_specification != null ? [var.credit_specification] : []
    content {
      cpu_credits = credit_specification.value.cpu_credits
    }
  }

  dynamic "elastic_gpu_specifications" {
    for_each = var.elastic_gpu_specifications != null ? [var.elastic_gpu_specifications] : []
    content {
      type = elastic_gpu_specifications.value.type
    }
  }

  dynamic "elastic_inference_accelerator" {
    for_each = var.elastic_inference_accelerator != null ? [var.elastic_inference_accelerator] : []
    content {
      type = elastic_inference_accelerator.value.type
    }
  }

  dynamic "enclave_options" {
    for_each = var.enclave_options != null ? [var.enclave_options] : []
    content {
      enabled = enclave_options.value.enabled
    }
  }

  dynamic "hibernation_options" {
    for_each = var.hibernation_options != null ? [var.hibernation_options] : []
    content {
      configured = hibernation_options.value.configured
    }
  }

  dynamic "iam_instance_profile" {
    for_each = var.iam_instance_profile != null ? [var.iam_instance_profile] : []
    content {
      name = lookup(var.iam_instance_profile, "name", null)
      arn  = lookup(var.iam_instance_profile, "arn", null)
    }
  }

  dynamic "instance_market_options" {
    for_each = var.instance_market_options != null ? [var.instance_market_options] : []
    content {
      market_type = instance_market_options.value.market_type

      dynamic "spot_options" {
        for_each = lookup(instance_market_options.value, "spot_options", null) != null ? [instance_market_options.value.spot_options] : []
        content {
          block_duration_minutes         = lookup(spot_options.value, "block_duration_minutes", null)
          instance_interruption_behavior = lookup(spot_options.value, "instance_interruption_behavior", null)
          max_price                      = lookup(spot_options.value, "max_price", null)
          spot_instance_type             = lookup(spot_options.value, "spot_instance_type", null)
          valid_until                    = lookup(spot_options.value, "valid_until", null)
        }
      }
    }
  }

  dynamic "instance_requirements" {
    for_each = length(var.instance_requirements) > 0 ? [var.instance_requirements] : []
    content {

      dynamic "accelerator_count" {
        for_each = try([instance_requirements.value.accelerator_count], [])
        content {
          max = try(accelerator_count.value.max, null)
          min = try(accelerator_count.value.min, null)
        }
      }

      accelerator_manufacturers = try(instance_requirements.value.accelerator_manufacturers, [])
      accelerator_names         = try(instance_requirements.value.accelerator_names, [])

      dynamic "accelerator_total_memory_mib" {
        for_each = try([instance_requirements.value.accelerator_total_memory_mib], [])
        content {
          max = try(accelerator_total_memory_mib.value.max, null)
          min = try(accelerator_total_memory_mib.value.min, null)
        }
      }

      accelerator_types = try(instance_requirements.value.accelerator_types, [])
      bare_metal        = try(instance_requirements.value.bare_metal, null)

      dynamic "baseline_ebs_bandwidth_mbps" {
        for_each = try([instance_requirements.value.baseline_ebs_bandwidth_mbps], [])
        content {
          max = try(baseline_ebs_bandwidth_mbps.value.max, null)
          min = try(baseline_ebs_bandwidth_mbps.value.min, null)
        }
      }

      burstable_performance   = try(instance_requirements.value.burstable_performance, null)
      cpu_manufacturers       = try(instance_requirements.value.cpu_manufacturers, [])
      excluded_instance_types = try(instance_requirements.value.excluded_instance_types, [])
      instance_generations    = try(instance_requirements.value.instance_generations, [])
      local_storage           = try(instance_requirements.value.local_storage, null)
      local_storage_types     = try(instance_requirements.value.local_storage_types, [])

      dynamic "memory_gib_per_vcpu" {
        for_each = try([instance_requirements.value.memory_gib_per_vcpu], [])
        content {
          max = try(memory_gib_per_vcpu.value.max, null)
          min = try(memory_gib_per_vcpu.value.min, null)
        }
      }

      dynamic "memory_mib" {
        for_each = [instance_requirements.value.memory_mib]
        content {
          max = try(memory_mib.value.max, null)
          min = memory_mib.value.min
        }
      }

      dynamic "network_interface_count" {
        for_each = try([instance_requirements.value.network_interface_count], [])
        content {
          max = try(network_interface_count.value.max, null)
          min = try(network_interface_count.value.min, null)
        }
      }

      on_demand_max_price_percentage_over_lowest_price = try(instance_requirements.value.on_demand_max_price_percentage_over_lowest_price, null)
      require_hibernate_support                        = try(instance_requirements.value.require_hibernate_support, null)
      spot_max_price_percentage_over_lowest_price      = try(instance_requirements.value.spot_max_price_percentage_over_lowest_price, null)

      dynamic "total_local_storage_gb" {
        for_each = try([instance_requirements.value.total_local_storage_gb], [])
        content {
          max = try(total_local_storage_gb.value.max, null)
          min = try(total_local_storage_gb.value.min, null)
        }
      }

      dynamic "vcpu_count" {
        for_each = [instance_requirements.value.vcpu_count]
        content {
          max = try(vcpu_count.value.max, null)
          min = vcpu_count.value.min
        }
      }
    }
  }

  dynamic "maintenance_options" {
    for_each = var.maintenance_options != null ? [var.maintenance_options] : []
      content {
          auto_recovery = maintenance_options.value.auto_recovery

          }
      }

  dynamic "private_dns_name_options" {
    for_each = length(var.private_dns_name_options) > 0 ? [var.private_dns_name_options] : []
    content {
      enable_resource_name_dns_aaaa_record = try(private_dns_name_options.value.enable_resource_name_dns_aaaa_record, null)
      enable_resource_name_dns_a_record    = try(private_dns_name_options.value.enable_resource_name_dns_a_record, null)
      hostname_type                        = private_dns_name_options.value.hostname_type
    }
  }

  dynamic "license_specification" {
    for_each = var.license_specifications != null ? [var.license_specifications] : []
    content {
      license_configuration_arn = license_specifications.value.license_configuration_arn
    }
  }

  dynamic "metadata_options" {
    for_each = var.metadata_options != null ? [var.metadata_options] : []
    content {
      http_endpoint               = lookup(metadata_options.value, "http_endpoint", null)
      http_tokens                 = lookup(metadata_options.value, "http_tokens", null)
      http_put_response_hop_limit = lookup(metadata_options.value, "http_put_response_hop_limit", null)
      http_protocol_ipv6          = lookup(metadata_options.value, "http_protocol_ipv6", null)
      instance_metadata_tags      = lookup(metadata_options.value, "instance_metadata_tags", null)
    }
  }

  dynamic "monitoring" {
    for_each = var.enable_monitoring != null ? [1] : []
    content {
      enabled = var.enable_monitoring
    }
  }

  dynamic "network_interfaces" {
    for_each = var.network_interfaces
    content {
      associate_carrier_ip_address = lookup(network_interfaces.value, "associate_carrier_ip_address", null)
      associate_public_ip_address  = lookup(network_interfaces.value, "associate_public_ip_address", null)
      delete_on_termination        = lookup(network_interfaces.value, "delete_on_termination", null)
      description                  = lookup(network_interfaces.value, "description", null)
      device_index                 = lookup(network_interfaces.value, "device_index", null)
      interface_type               = lookup(network_interfaces.value, "interface_type", null)
      ipv4_addresses               = try(network_interfaces.value.ipv4_addresses, [])
      ipv4_address_count           = lookup(network_interfaces.value, "ipv4_address_count", null)
      ipv4_prefix_count            = lookup(network_interfaces.value, "ipv4_prefix_count", null)
      ipv4_prefixes                = lookup(network_interfaces.value, "ipv4_prefixes", null)
      ipv6_prefix_count            = lookup(network_interfaces.value, "ipv6_prefix_count", null)
      ipv6_prefixes                = lookup(network_interfaces.value, "ipv6_prefixes", null)
      network_card_index           = lookup(network_interfaces.value, "network_card_index", null)

      ipv6_addresses               = try(network_interfaces.value.ipv6_addresses, [])
      ipv6_address_count           = lookup(network_interfaces.value, "ipv6_address_count", null)
      network_interface_id         = lookup(network_interfaces.value, "network_interface_id", null)
      private_ip_address           = lookup(network_interfaces.value, "private_ip_address", null)
      security_groups              = lookup(network_interfaces.value, "security_groups", null) 
      subnet_id                    = lookup(network_interfaces.value, "subnet_id", null)
    }
  }

  dynamic "placement" {
    for_each = var.placement != null ? [var.placement] : []
    content {
      affinity                = lookup(placement.value, "affinity", null)
      availability_zone       = lookup(placement.value, "availability_zone", null)
      group_name              = lookup(placement.value, "group_name", null)
      host_id                 = lookup(placement.value, "host_id", null)
      host_resource_group_arn = lookup(placement.value, "host_resource_group_arn", null)
      spread_domain           = lookup(placement.value, "spread_domain", null)
      tenancy                 = lookup(placement.value, "tenancy", null)
      partition_number        = lookup(placement.value, "partition_number", null)
    }
  }

  dynamic "tag_specifications" {
    for_each = toset(["instance", "volume", "network-interface"])
    content {
      resource_type = tag_specifications.key
      tags          = merge(var.tags, { Name = var.prefix }, var.launch_template_tags)
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}
