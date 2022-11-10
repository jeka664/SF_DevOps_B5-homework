// initialization

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "jeka664"
    region     = "ru-central1-a"
    key        = "terraform.tfstate"
    access_key = "access_key"
    secret_key = "secret_key"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}


// Configure the Yandex.Cloud provider
provider "yandex" {
  service_account_key_file = "key.json"
  cloud_id                 = var.var_cloud_id
  folder_id                = var.var_folder_id
  zone                     = "ru-central1-a"
}

////////////////////////////////////////////////////////////////////////////////////////

/// Create Resource



// Create VPN Network
resource "yandex_vpc_network" "network" {
  name = "network"
}

// Create VPC Subnet 192.168.1.0/24 for VM
resource "yandex_vpc_subnet" "subnet1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.1.0/24"]
}

// Create first VM
module "createservers_1" {
  source                = "./modules/createservers"
  instance_family_image = "lemp"
  nameserver            = "vm1"
  vpc_subnet_id         = yandex_vpc_subnet.subnet1.id
}

//Create second VM
module "createservers_2" {
  source                = "./modules/createservers"
  instance_family_image = "lamp"
  nameserver            = "vm2"
  vpc_subnet_id         = yandex_vpc_subnet.subnet1.id
}


//////////////////////////////////////////////////////////////////////////////////////

// Network load balance

resource "yandex_lb_target_group" "nlb_tg" {
  name      = "nlb-tg"
  region_id = "ru-central1"

  target {
    subnet_id = yandex_vpc_subnet.subnet1.id
    address   =  module.createservers_1.internal_ip_address_vm
  }

  target {
    subnet_id = yandex_vpc_subnet.subnet1.id
    address   =  module.createservers_2.internal_ip_address_vm
  }
}

resource "yandex_lb_network_load_balancer" "nlb" {
  name = "nlb"

  listener {
    name = "nlb-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = "${yandex_lb_target_group.nlb_tg.id}"

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////

// Output variable


output "internal_ip_address_vm1" {
  value = module.createservers_1.internal_ip_address_vm
  description = "Internal IP address vm1"
}

output "external_ip_address_vm1" {
  value = module.createservers_1.external_ip_address_vm
  description = "External IP address vm1"
}

output "internal_ip_address_vm2" {
  value = module.createservers_2.internal_ip_address_vm
  description = "Internal IP address vm2"
}

output "external_ip_address_vm2" {
  value = module.createservers_2.external_ip_address_vm
  description = "Internal IP address vm2"
}

output "load_balancer_public_ip" {

  description = "Public IP address of load balancer"
  value = yandex_lb_network_load_balancer.nlb.listener.*.external_address_spec[0].*.address
}
