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

resource "openstack_compute_quotaset_v2" "quotaset_1" {
  project_id           = data.openstack_identity_project_v3.project_1.id
  key_pairs            = 100
  ram                  = 512000
  cores                = 50
  instances            = 100
  server_groups        = 4
  server_group_members = 8
}


resource "openstack_compute_keypair_v2" "test_keypair" {
  name = "test_keypair"
}

variable files_output_path {
  description = "files_output_path"
}

      # ${openstack_networking_port_v2.dpdk_ports[0][0].fixed_ip}
locals {
   template = <<-EOT
---
ssh_key: ${var.files_output_path}/generated_test_keypair.key
dynamic_instances:
  - name: server_0
    user: cloud-user
    group: test_tso_iperf3_server
    fip: ${openstack_networking_floatingip_v2.fips[0].address}
    vars:
      dpdk_net: 'bla'
  - name: server_1
    user: cloud-user
    group: test_tso_iperf3_client
    fip: ${openstack_networking_floatingip_v2.fips[1].address}
    vars:
      dpdk_net: 'bla'
EOT
  private_key = openstack_compute_keypair_v2.test_keypair.private_key
}


resource "local_file" "key_file" {
  filename        = "./generated_test_keypair.key"
  content         = local.private_key
  file_permission = "0600"
}

resource "local_file" "servers_file" {
  filename        = "./servers.yaml"
  content         = local.template
  file_permission = "0644"
}