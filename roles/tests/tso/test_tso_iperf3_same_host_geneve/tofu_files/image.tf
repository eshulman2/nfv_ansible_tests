resource "openstack_images_image_v2" "os_image" {
  name             = "best_image"
  image_source_url = local.image
  container_format = "bare"
  disk_format      = "qcow2"
    visibility       = "public"

}
