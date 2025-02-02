terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "1.52.1"
    }

  }

}

provider "openstack" {
  cloud = "default"
  insecure = true
}

data "openstack_identity_project_v3" "project_1" {
  name = "admin"
}