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
    scheduler_hints {
    group = openstack_compute_servergroup_v2.anti_affinity_server_group.id
  }
}