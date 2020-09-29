# =========================================
# Example to manage one volume per location 
# =========================================


# ---------------------
# Environment Variables
# ---------------------

# Hetzner Cloud Project API Token
# HCLOUD_TOKEN="<api_token>"


# ---------------
# Input Variables
# ---------------

variable "volume_size" {
  description = "The size of the volumes (in GB)."
  type        = number
  default     = 10

  validation {
    condition     = var.volume_size >= 10
    error_message = "The minimum volume size is 10 GB."
  }
}

variable "volume_format" {
  description = "The filesystem to be created on the volumes."
  type        = string
  default     = "xfs"
}

variable "labels" {
  description = "The map of labels to be assigned to all managed resources."
  type        = map(string)
  default     = {
    "managed"    = "true"
    "managed_by" = "Terraform"
  }
}
