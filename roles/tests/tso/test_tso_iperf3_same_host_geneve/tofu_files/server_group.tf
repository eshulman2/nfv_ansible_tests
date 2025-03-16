resource "openstack_compute_servergroup_v2" "affinity_server_group" {
  name     = "affinity"
  policies = ["affinity"]
}