output "master_ip" {
  value = "${yandex_compute_instance.master.name} - ${yandex_compute_instance.master.network_interface.0.ip_address}(${yandex_compute_instance.master.network_interface.0.nat_ip_address})"
}

output "worker_ips" {
  value = [for instance in yandex_compute_instance.worker : "${instance.name} - ${instance.network_interface.0.ip_address}(${instance.network_interface.0.nat_ip_address})"]
}

output "bucket" {
  value = "Bucket Id - ${yandex_storage_bucket.tf_state_sva.id})"
}

output "ybd" {
  value = "YBD Id - ${yandex_ydb_database_serverless.ydb_tfstate_lock.id})"
}

output "ybd_endpoint" {
  value = "YBD endpoint - ${yandex_ydb_database_serverless.ydb_tfstate_lock.ydb_full_endpoint})"
}
