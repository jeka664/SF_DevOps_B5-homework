// initializatio n variables

variable "instance_family_image" {
  description = "Instance image"
  type        = string
  default     = "lamp"
}

variable "nameserver" {
  description = "Instance image"
  type        = string
  default     = "vm"
}

variable "vpc_subnet_id" {
  description = "VPC subnet id"
  type        = string
}

//  Take information about image

data "yandex_compute_image" "lemp" {
   family = var.instance_family_image
}

// Create VM

resource "yandex_compute_instance" "vm" {
  name = var.nameserver
        platform_id = "standard-v1" # тип процессора (Intel Broadwell)

  resources {
    core_fraction = 5
    cores  = 2 # vCPU
    memory = 1 # RAM
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.lemp.id
    }
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("id_rsa.pub")}"
  }

  network_interface {
    subnet_id = var.vpc_subnet_id
    nat = true
  }
}

// output variables

output "internal_ip_address_vm" {
  value = yandex_compute_instance.vm.network_interface.0.ip_address
}

output "external_ip_address_vm" {
  value = yandex_compute_instance.vm.network_interface.0.nat_ip_address
}
