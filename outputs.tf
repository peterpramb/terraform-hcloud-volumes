# ===================================
# Manage volumes in the Hetzner Cloud
# ===================================


# -------------
# Output Values
# -------------

output "volume_ids" {
  description = "A map of all volume ids and associated names."
  value       = {
    for name, volume in hcloud_volume.volumes : volume.id => name
  }
}

output "volume_names" {
  description = "A map of all volume names and associated ids."
  value       = {
    for name, volume in hcloud_volume.volumes : name => volume.id
  }
}

output "volumes" {
  description = "A list of all volume objects."
  value       = [
    for volume in hcloud_volume.volumes : merge(volume, {
      "attachments" = [
        for attachment in hcloud_volume_attachment.attachments : attachment
          if(tostring(attachment.volume_id) == volume.id)
      ]
    })
  ]
}

output "volume_attachment_ids" {
  description = "A map of all volume attachment ids and associated names."
  value       = {
    for name, attachment in hcloud_volume_attachment.attachments :
      attachment.id => name
  }
}

output "volume_attachment_names" {
  description = "A map of all volume attachment names and associated ids."
  value       = {
    for name, attachment in hcloud_volume_attachment.attachments :
      name => attachment.id
  }
}

output "volume_attachments" {
  description = "A list of all volume attachment objects."
  value       = [
    for name, attachment in hcloud_volume_attachment.attachments :
      merge(attachment, {
        "volume_name" = local.attachments[name].name
      })
  ]
}
