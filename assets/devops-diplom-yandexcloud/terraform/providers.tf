terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  # backend "local" {

  # }
  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket   = "tf-state-sva"

    key    = "terraform.tfstate"
    region = "ru-central1"

    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gamuvki52hfn7mdg4j/etnv3e1on912bod7j3b6"
    dynamodb_table    = "tf/state_lock"

    skip_region_validation      = true
    skip_credentials_validation = true
  }

  required_version = ">=0.13"
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}
