# =========================================
# Example to manage one volume per location
# =========================================


# -------------------
# Module Dependencies
# -------------------

terraform {
  required_version = ">= 0.13"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = ">= 1.20"
    }
  }
}
