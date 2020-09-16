# ====================================
# Manages volumes in the Hetzner Cloud
# ====================================


# ------------
# Local Values
# ------------

locals {
  # Build a map of all provided volume objects, indexed by volume name
  volumes = {
    for volume in var.volumes : volume.name => volume
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
