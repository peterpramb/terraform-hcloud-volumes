[![License](https://img.shields.io/github/license/peterpramb/terraform-hcloud-volumes)](https://github.com/peterpramb/terraform-hcloud-volumes/blob/master/LICENSE)
[![Latest Release](https://img.shields.io/github/v/release/peterpramb/terraform-hcloud-volumes?sort=semver)](https://github.com/peterpramb/terraform-hcloud-volumes/releases/latest)
[![Terraform Version](https://img.shields.io/badge/terraform-%E2%89%A5%200.13.0-623ce4)](https://www.terraform.io)


# terraform-hcloud-volumes

[Terraform](https://www.terraform.io) module for managing volumes in the [Hetzner Cloud](https://www.hetzner.com/cloud).

It implements the following [provider](#providers) resources:

- [hcloud\_volume](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/volume)
- [hcloud\_volume\_attachment](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/volume_attachment)


## Usage

```terraform
module "volume" {
  source  = "github.com/peterpramb/terraform-hcloud-volumes?ref=<release>"

  volumes = [
    {
      name       = "volume-nbg1-1"
      location   = "nbg1"
      size       = 10
      format     = "xfs"
      protection = true
      server     = {
        "name"      = "server-1"
        "id"        = "7569968"
        "automount" = true
      }
      labels     = {
        "managed"    = "true"
        "managed_by" = "Terraform"
      }
    }
  ]
}
```

See [examples](https://github.com/peterpramb/terraform-hcloud-volumes/blob/master/examples) for more usage details.


## Requirements

| Name | Version |
|------|---------|
| [terraform](https://www.terraform.io) | &ge; 0.13 |


## Providers

| Name | Version |
|------|---------|
| [hcloud](https://registry.terraform.io/providers/hetznercloud/hcloud) | &ge; 1.31 |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-------:|:--------:|
| volumes | List of volume objects to be managed. | list(map([*volume*](#volume))) | See [below](#defaults) | yes |


#### *volume*

| Name | Description | Type | Required |
|------|-------------|:----:|:--------:|
| [name](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/volume#name) | Unique name of the volume. | string | yes |
| [location](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/volume#location) | Location of the volume. | string | yes |
| [size](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/volume#size) | Size of the volume (in GB). | number | yes |
| [format](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/volume#format) | Format volume after creation. | string | no |
| [protection](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/volume#delete_protection) | Protect volume from deletion. | bool | no |
| server | Inputs for server attachment. | map([*server*](#server)) | no |
| [labels](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/volume#labels) | Map of user-defined labels. | map(string) | no |


#### *server*

| Name | Description | Type | Required |
|------|-------------|:----:|:--------:|
| [name](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/server#name) | Name of the server to attach the volume to. | string | yes |
| [id](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/volume_attachment#server_id) | ID of the server to attach the volume to. | string | yes |
| [automount](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/volume_attachment#automount) | Automount the volume on attachment. | bool | no |


### Defaults

```terraform
volumes = [
  {
    name       = "volume-nbg1-1"
    location   = "nbg1"
    size       = 10
    format     = "xfs"
    protection = false
    server     = null
    labels     = {}
  }
]
```


## Outputs

| Name | Description |
|------|-------------|
| volumes | List of all volume objects. |
| volume\_ids | Map of all volume objects indexed by ID. |
| volume\_names | Map of all volume objects indexed by name. |
| volume\_attachments | List of all volume attachment objects. |
| volume\_attachment\_ids | Map of all volume attachment objects indexed by ID. |
| volume\_attachment\_names | Map of all volume attachment objects indexed by name. |


### Defaults

```terraform
volumes = [
  {
    "attachment" = {}
    "delete_protection" = false
    "format" = "xfs"
    "id" = "7285086"
    "linux_device" = "/dev/disk/by-id/scsi-0HC_Volume_7285086"
    "location" = "nbg1"
    "name" = "volume-nbg1-1"
    "size" = 10
  },
]

volume_ids = {
  "7285086" = {
    "attachment" = {}
    "delete_protection" = false
    "format" = "xfs"
    "id" = "7285086"
    "linux_device" = "/dev/disk/by-id/scsi-0HC_Volume_7285086"
    "location" = "nbg1"
    "name" = "volume-nbg1-1"
    "size" = 10
  }
}

volume_names = {
  "volume-nbg1-1" = {
    "attachment" = {}
    "delete_protection" = false
    "format" = "xfs"
    "id" = "7285086"
    "linux_device" = "/dev/disk/by-id/scsi-0HC_Volume_7285086"
    "location" = "nbg1"
    "name" = "volume-nbg1-1"
    "size" = 10
  }
}

volume_attachments = []

volume_attachment_ids = {}

volume_attachment_names = {}
```


## License

This module is released under the [MIT](https://github.com/peterpramb/terraform-hcloud-volumes/blob/master/LICENSE) License.
