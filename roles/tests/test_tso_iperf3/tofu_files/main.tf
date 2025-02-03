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

# resource "openstack_networking_port_v2" "s2_mgmt_port" {
#   name               = "s2_mgmt_port"
#   network_id         = openstack_networking_network_v2.management_net_management_network.id
#   security_group_ids = ["${openstack_networking_secgroup_v2.test_secgroup.id}"]
#   admin_state_up     = "true"
#   fixed_ip {
#     subnet_id = openstack_networking_subnet_v2.management_net_management_subnet.id
#   }
# }

resource "openstack_compute_instance_v2" "dpdk_servers" {
    count = 2
  name         = "server_${count.index}"
  image_id     = openstack_images_image_v2.os_image.id
  flavor_id    = openstack_compute_flavor_v2.test-flavor.id
  key_pair     = openstack_compute_keypair_v2.test_keypair.name
  config_drive = true
  user_data    = <<-EOF
#cloud-config
ssh_pwauth: true
password: redhat
ssh_pwauth: false
chpasswd:
  expire: false
  users:
    - name: root
      password: redhat
      type: text
    - name: cloud-user
      password: redhat
EOF
  network {
    port = openstack_networking_port_v2.mgmt_ports[count.index].id
  }
  network {
    port = openstack_networking_port_v2.dpdk_ports[count.index].id
  }
}

resource "openstack_networking_floatingip_v2" "fips" {
    count = 2
  pool    = openstack_networking_network_v2.access_network.name
  port_id = openstack_networking_port_v2.mgmt_ports[count.index].id
  depends_on = [openstack_compute_instance_v2.dpdk_servers]
}

# locals {
#    template = <<-EOT
# ---
# ssh_key: test_keypair.key
# dynamic_instances:
#   - name: server-0
#     fip: ${fips[0].address}
#     user: cloud-user
#   - name: server-1
#     fip: ${fips[1].address}
#     user: cloud-user
# EOT
#   private_key = openstack_compute_keypair_v2.test_keypair.private_key
# }

# resource "local_file" "key_file" {
#   filename        = "./test_keypair.key"
#   content         = local.private_key
#   file_permission = "0600"
# }

# resource "local_file" "servers_file" {
#   filename        = "./servers.yaml"
#   content         = local.template
#   file_permission = "0644"
# }