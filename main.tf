# ===================================
# Manage volumes in the Hetzner Cloud
# ===================================


# ------------
# Local Values
# ------------

locals {
  # Build a map of all provided volume objects, indexed by volume name:
  volumes     = {
    for volume in var.volumes : volume.name => volume
  }

  # Build a map of all provided volume objects to be attached, indexed
  # by volume name:
  attachments = {
    for volume in local.volumes : volume.name => merge(volume, {
      "volume" = volume.name
    }) if(try(volume.server_id, null) != null && volume.server_id != "")
  }
}


# -------
# Volumes
# -------

resource "hcloud_volume" "volumes" {
  for_each = local.volumes

  name     = each.value.name
  location = each.value.location
  size     = each.value.size
  format   = each.value.format

  labels   = each.value.labels
}


# ------------------
# Volume Attachments
# ------------------

resource "hcloud_volume_attachment" "attachments" {
  for_each  = local.attachments

  server_id = each.value.server_id
  volume_id = hcloud_volume.volumes[each.value.name].id
  automount = each.value.automount
}
