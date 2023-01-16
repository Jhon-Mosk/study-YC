terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = "AQAAAAAOj-IRAATuwdh9ssyKhU3UvkuyQkOTgw0"
  cloud_id  = "b1ghk9uitis1fanhbci6"
  folder_id = "b1gp2lhjstd03j7rff3m"
}

resource "yandex_storage_bucket" "bucket" {
  access_key = "YCAJEIaKBMcNsoNSgoMqQglBG"
  secret_key = "YCNBP5E8PSN6GmqHXS0nv5pzGHR4qUHWLo_EDS82"
  bucket = "bucket-for-trigger-b1ghk9uitis1fanhbci6"
}
