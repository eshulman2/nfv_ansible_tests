resource "openstack_compute_servergroup_v2" "anti_affinity_server_group" {
  name     = "anti-affinity"
  policies = ["anti-affinity"]
}