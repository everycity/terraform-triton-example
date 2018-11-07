module "natgw" {
  source      = "git::https://github.com/everycity/terraform-triton-natgw.git?ref=master"
  namespace   = "example"
  stage       = "prod"
  name        = "natgw"

  instance_package = "g1-container-256m"

  network_public = "${data.triton_network.public.id}"
  network_private = "${data.triton_network.private.id}"

  ucarp_vhid  = "1"
  ucarp_pass  = "SkUnIj0njDg0F4W4"
  ucarp_vip   = "10.15.0.254"
}

