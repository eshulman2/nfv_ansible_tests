resource "openstack_compute_flavor_v2" "test-flavor" {
  name      = "nfv_qe_base_flavor"
  ram       = "8192"
  vcpus     = "6"
  disk      = "40"
  flavor_id = 100
  is_public = "true"
  extra_specs = {
    "hw:mem_page_size"           = "large"
    "hw:cpu_policy"              = "dedicated"
    "hw:emulator_threads_policy" = "share"
  }
}
