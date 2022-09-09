provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = var.yc_region
}

locals {
  image_type  = var.image_id
  preemptible = true
}

resource "yandex_compute_instance" "vp_netology_learnansible" {
  name = "test-1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = local.image_type
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
    nat = true
  }

  scheduling_policy {
    preemptible = local.preemptible
  }

  metadata = {
    ssh-keys = "centos:${file("~/.ssh/id_yc_rsa.pub")}"
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = var.yc_region
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.0.0/16"]
}

output "instance_ip" {
  value = "${yandex_compute_instance.vp_netology_learnansible.network_interface[0].nat_ip_address}"
}
