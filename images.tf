data "triton_image" "ubuntu-1604-lx" {
  name        = "ubuntu-16.04"
  type        = "lx-dataset"
  most_recent = true
}

data "triton_image" "ubuntu-1604-kvm" {
  name        = "ubuntu-certified-16.04"
  type        = "zvol"
  most_recent = true
}

