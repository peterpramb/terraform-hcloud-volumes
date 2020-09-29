# =========================================
# Example to manage one volume per location 
# =========================================


# -------------
# Output Values
# -------------

output "volumes" {
  description = "A list of all volume objects."
  value       = module.volume.volumes
}
