# ====================================
# Manages volumes in the Hetzner Cloud
# ====================================


# ---------------
# Input Variables
# ---------------

variable "volumes" {
  description = "The list of volume objects to be managed. Each volume object supports the following parameters: 'name' (string, required), 'location' (string, required), 'size' (number, required), 'format' (string, optional), 'labels' (map of KV pairs, optional)."

  type = list(
    object({
      name     = string
      location = string
      size     = number
      format   = string
      labels   = map(string)
    })
  )

  default = [
    {
      name     = "volume-nbg1-1"
      location = "nbg1"
      size     = 10
      format   = "xfs"
      labels   = {}
    }
  ]

  validation {
    condition = can([
      for volume in var.volumes : regex("\\w+", volume.name)
    ])
    error_message = "All volumes must have a valid 'name' attribute specified."
  }

  validation {
    condition = can([
      for volume in var.volumes : regex("\\w+", volume.location)
    ])
    error_message = "All volumes must have a valid 'location' attribute specified."
  }

  validation {
    condition = can([
      for volume in var.volumes : regex("\\d+", volume.size)
    ])
    error_message = "All volumes must have a valid 'size' attribute specified."
  }
}
