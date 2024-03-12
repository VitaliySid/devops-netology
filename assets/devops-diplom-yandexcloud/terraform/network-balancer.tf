
resource "yandex_lb_target_group" "default_target_group" {
  name      = "default-target-group"
  region_id = "ru-central1"

  # TODO возможно переписать это через циклы? чтобы автоматически заносились все рабочие ноды
  target {
    address   = yandex_compute_instance.master.network_interface.0.ip_address
    subnet_id = yandex_compute_instance.master.network_interface.0.subnet_id
  }

  target {
    address   = yandex_compute_instance.worker.0.network_interface.0.ip_address
    subnet_id = yandex_compute_instance.worker.0.network_interface.0.subnet_id
  }

  target {
    address   = yandex_compute_instance.worker.1.network_interface.0.ip_address
    subnet_id = yandex_compute_instance.worker.1.network_interface.0.subnet_id
  }


  depends_on = [
    yandex_compute_instance.master,
    yandex_compute_instance.worker,
    yandex_vpc_network.kubernetes
  ]
}


resource "yandex_lb_network_load_balancer" "network_load_balancer" {
  name                = "network-load-balancer"
  deletion_protection = "true"
  listener {
    name        = "app-listener"
    port        = 80
    target_port = 30081
    protocol    = "tcp"
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  # alertmanager
  listener {
    name        = "alert-manager-listener-diploma"
    port        = 9093
    target_port = 30903
    protocol    = "tcp"
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  # graphana
  listener {
    name        = "graphana-listener-diploma"
    port        = 8080
    target_port = 30680
    protocol    = "tcp"
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  # prometheus
  listener {
    name        = "prometheus-listener-diploma"
    port        = 9090
    target_port = 30090
    protocol    = "tcp"
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.default_target_group.id

    healthcheck {
      name = "tcp"
      tcp_options {
        port = 30081
      }
    }
  }

  depends_on = [
    yandex_compute_instance.master,
    yandex_compute_instance.worker,
    yandex_vpc_network.kubernetes
  ]
}
