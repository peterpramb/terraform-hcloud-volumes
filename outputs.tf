# ===================================
# Manage volumes in the Hetzner Cloud
# ===================================


# ------------
# Local Values
# ------------

locals {
  output_volumes     = [
    for name, volume in hcloud_volume.volumes : merge(volume, {
      "attachment" = try(hcloud_volume_attachment.attachments[name], {})
    })
  ]

  output_attachments = [
    for name, attachment in hcloud_volume_attachment.attachments :
      merge(attachment, {
        "name"        = name
        "volume_name" = try(local.attachments[name].volume, null)
      })
  ]
}


# -------------
# Output Values
# -------------

output "volumes" {
  description = "A list of all volume objects."
  value       = local.output_volumes
}

output "volume_ids" {
  description = "A map of all volume objects indexed by ID."
  value       = {
    for volume in local.output_volumes : volume.id => volume
  }
}

output "volume_names" {
  description = "A map of all volume objects indexed by name."
  value       = {
    for volume in local.output_volumes : volume.name => volume
  }
}

output "volume_attachments" {
  description = "A list of all volume attachment objects."
  value       = local.output_attachments
}

output "volume_attachment_ids" {
  description = "A map of all volume attachment objects indexed by ID."
  value       = {
    for attachment in local.output_attachments : attachment.id => attachment
  }
}

output "volume_attachment_names" {
  description = "A map of all volume attachment objects indexed by name."
  value       = {
    for attachment in local.output_attachments : attachment.name => attachment
  }
}
