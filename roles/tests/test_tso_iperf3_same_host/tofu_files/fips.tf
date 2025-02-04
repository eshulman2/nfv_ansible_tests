
resource "openstack_networking_floatingip_v2" "fips" {
    count = 2
  pool    = openstack_networking_network_v2.access_network.name
  port_id = openstack_networking_port_v2.mgmt_ports[count.index].id
  depends_on = [openstack_compute_instance_v2.dpdk_servers]
}