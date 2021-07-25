# =========================================
# Example to manage one volume per location 
# =========================================


# ------------
# Local Values
# ------------

locals {
  # Enrich user configuration for volume module:
  volumes = [
    for location in data.hcloud_locations.all.names : {
      "name"     = "volume-${location}-1"
      "location" = location
      "size"     = var.volume_size
      "format"   = var.volume_format
      "server"   = null
      "labels"   = var.labels
    }
  ]
}


# ---------
# Locations
# ---------

data "hcloud_locations" "all" {
}


# -------
# Volumes
# -------

module "volume" {
  source  = "github.com/peterpramb/terraform-hcloud-volumes"

  volumes = local.volumes
}
