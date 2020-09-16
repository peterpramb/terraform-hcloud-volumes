# ====================================
# Manages volumes in the Hetzner Cloud
# ====================================


# -------------
# Output Values
# -------------

output "volume_ids" {
  description = "A map of all volume ids and associated names."
  value = {
    for name, volume in hcloud_volume.volumes : volume.id => name
  }
}

output "volume_names" {
  description = "A map of all volume names and associated ids."
  value = {
    for name, volume in hcloud_volume.volumes : name => volume.id
  }
}

output "volumes" {
  description = "A list of all volume objects."
  value = [
    for volume in hcloud_volume.volumes : volume
  ]
}
