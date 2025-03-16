resource "openstack_images_image_v2" "os_image" {
  name             = "best_image"
  image_source_url = "http://ceph1.lab.eng.tlv2.redhat.com:8080/mnietoji/rhel-guest-image-nfv-2-8.7-1660.x86_64.qcow2"
  container_format = "bare"
  disk_format      = "qcow2"
    visibility       = "public"

}
