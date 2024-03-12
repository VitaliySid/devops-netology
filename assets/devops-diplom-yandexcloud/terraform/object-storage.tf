resource "yandex_kms_symmetric_key" "my_symmetric_key" {
  name              = "my-symmetric-key"
  description       = "Key for object storage encryption"
  default_algorithm = "AES_128" # Алгоритм шифрования. Возможные значения: AES-128, AES-192 или AES-256.
  rotation_period   = "8760h"   # 1 год. Период ротации (частота смены версии ключа по умолчанию).
  lifecycle {
    prevent_destroy = true # Защита ключа от удаления (например, командой terraform destroy)
  }
}

resource "yandex_storage_bucket" "tf_state_sva" {
  access_key = var.access_key_id
  secret_key = var.secret_key
  bucket     = "tf-state-sva"
  max_size   = 100000

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.my_symmetric_key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "yandex_ydb_database_serverless" "ydb_tfstate_lock" {
  name                = "ydb-tfstate-lock"
  deletion_protection = true

  serverless_database {
    enable_throttling_rcu_limit = true
    provisioned_rcu_limit       = 10
    storage_size_limit          = 1
    throttling_rcu_limit        = 10
  }
}

resource "yandex_ydb_table" "ydb_tf_lock" {
  path              = "tf/state_lock"
  connection_string = yandex_ydb_database_serverless.ydb_tfstate_lock.ydb_full_endpoint

  lifecycle {
    ignore_changes = [column]
  }

  primary_key = [
    "__Hash",
    "LockID",
  ]

  column {
    family   = "tf_state_lock"
    name     = "LockID"
    not_null = false
    type     = "Utf8"
  }
  column {
    family   = "tf_state_lock"
    name     = "__Hash"
    not_null = false
    type     = "Uint64"
  }
  column {
    family   = "tf_state_lock"
    name     = "__RowData"
    not_null = false
    type     = "JsonDocument"
  }

}


