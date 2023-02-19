terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = "AQ***w0"
  cloud_id  = "b1***i6"
  folder_id = "b1***3m"
}

resource "yandex_storage_bucket" "bucket" {
  access_key = "YC***BG"
  secret_key = "YC***82"
  bucket = "bucket-for-trigger-b1***i6"
}
