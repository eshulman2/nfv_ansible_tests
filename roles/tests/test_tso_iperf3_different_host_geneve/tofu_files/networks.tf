resource "openstack_networking_network_v2" "access_network" {
  name           = "access"
  shared         = "true"
  external       = "true"
  admin_state_up = "true"
  segments {
    physical_network = "access"
    segmentation_id  = local.external_net_vlan
    network_type     = "vlan"
  }

}
resource "openstack_networking_subnet_v2" "access_subnet" {
  name        = "access"
  network_id  = openstack_networking_network_v2.access_network.id
  cidr        = local.external_net_cidr
  ip_version  = 4
  gateway_ip  = local.external_net_gateway
  enable_dhcp = "true"
  allocation_pool {
    start = local.external_net_start
    end   = local.external_net_end
  }

}
resource "openstack_networking_network_v2" "management_net_management_network" {
  name = "management_net_management"
  mtu = 1400
  segments {
    network_type = local.network_type
  }

}
resource "openstack_networking_subnet_v2" "management_net_management_subnet" {
  name            = "management_net_management"
  network_id      = openstack_networking_network_v2.management_net_management_network.id
  cidr            = "10.10.107.0/24"
  ip_version      = 4
  gateway_ip      = "10.10.107.254"
  enable_dhcp     = "true"
  dns_nameservers = ["10.47.242.10", "10.45.248.15"]
  allocation_pool {
    start = "10.10.107.100"
    end   = "10.10.107.200"
  }

}
resource "openstack_networking_router_v2" "router_1" {
  name                = "router"
  admin_state_up      = true
  external_network_id = openstack_networking_network_v2.access_network.id
}
resource "openstack_networking_router_interface_v2" "router_interface_management" {
  router_id = openstack_networking_router_v2.router_1.id
  subnet_id = openstack_networking_subnet_v2.management_net_management_subnet.id
}
resource "openstack_networking_network_v2" "dpdk_net_1" {
  name                  = "dpdk_net_nic0_${local.first_vlan}"
  port_security_enabled = false
  segments {
    physical_network = "dpdkdata0"
    segmentation_id  = local.first_vlan
    network_type     = "vlan"
  }

}
resource "openstack_networking_subnet_v2" "dpdk_net_1_subnet" {
  name        = "dpdk_net_${local.first_vlan}_subnet"
  network_id  = openstack_networking_network_v2.dpdk_net_1.id
  cidr        = "10.10.${local.first_vlan}.0/24"
  ip_version  = 4
  gateway_ip  = "10.10.${local.first_vlan}.254"
  enable_dhcp = "false"
  allocation_pool {
    start = "10.10.${local.first_vlan}.100"
    end   = "10.10.${local.first_vlan}.200"
  }

}

resource "openstack_networking_port_v2" "mgmt_ports" {
  count = 2
  name               = "mgmt_port_${count.index}"
  network_id         = openstack_networking_network_v2.management_net_management_network.id
  security_group_ids = ["${openstack_networking_secgroup_v2.test_secgroup.id}"]
  admin_state_up     = "true"
  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.management_net_management_subnet.id
  }
}

resource "openstack_networking_port_v2" "dpdk_ports" {
    count = 2
  name                  = "dpdk_port_${count.index}"
  network_id            = openstack_networking_network_v2.dpdk_net_1.id
  port_security_enabled = false
  binding {
    vnic_type = "normal"
  }
  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.dpdk_net_1_subnet.id
  }

}