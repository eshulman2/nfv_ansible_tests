resource "openstack_images_image_v2" "os_image" {
  name             = "best_image"
  image_source_url = "http://ceph1.lab.eng.tlv2.redhat.com:8080/rdiazcam/rhel-guest-image-8.4-1245-nfv3-shrunk.x86_64.img"
  container_format = "bare"
  disk_format      = "qcow2"
    visibility       = "public"

}
