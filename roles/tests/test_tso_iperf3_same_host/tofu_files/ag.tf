
resource "openstack_compute_aggregate_v2" "TREX_AG" {
  region = "regionOne"
  name   = "compute_0_ag"
  zone   = "nova"
#   metadata = {
#     flavor = "trex_ag"
#   }

  hosts = [
    "${local.compute_base_name}-1.ctlplane.example.com"
  ]
}


resource "openstack_compute_aggregate_v2" "DUT_AG" {
  region = "regionOne"
  name   = "compute_0ag"
  zone   = "nova"
#   metadata = {
#     flavor = "dut_ag"
#   }

  hosts = [
    "${local.compute_base_name}-0.ctlplane.example.com"
  ]
}