terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.59.0"
    }
  }
}

provider "google" {
  project     = "terraform-playpen"
  region      = "australia-southeast1"
  zone        = "australia-southeast1-a"
}
