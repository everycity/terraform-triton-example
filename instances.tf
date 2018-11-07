# Bastion Host
resource "triton_machine" "bastion1" {
  name        = "bastion1-1"
  package     = "g1-container-256m"
  image       = "${data.triton_image.ubuntu-1604-lx.id}"
  networks    = ["${data.triton_network.public.id}", "${data.triton_network.private.id}"]

  tags {
    role = "bastion"
    terraform = true
  }

  cns {
    services = [ "bastion1" ]
  }
}

# HAProxy Instances
resource "triton_machine" "haproxy1" {
  count       = 2
  name        = "haproxy1-${count.index+1}"
  package     = "g1-container-1g"
  image       = "${data.triton_image.ubuntu-1604-lx.id}"
  affinity    = ["role!=haproxy"]

  firewall_enabled = true

  networks    = ["${data.triton_network.public.id}", "${data.triton_network.private.id}"]

  tags {
    role = "haproxy"
    terraform = true
  }

  cns {
    services = [ "haproxy1" ]
  }
}

# Docker Hosts
resource "triton_machine" "docker1" {
  count       = 2
  name        = "docker1-${count.index+1}"
  package     = "k1-virtualmachine-16g"
  image       = "${data.triton_image.ubuntu-1604-kvm.id}"
  affinity    = ["role!=docker"]

  firewall_enabled = true

  networks    = ["${data.triton_network.private.id}"]

  tags {
    role = "docker"
    terraform = true
  }

  cns {
    services = [ "docker1" ]
  }
}

# Database Containers
resource "triton_machine" "postgres1" {
  count      = 2
  name       = "postgres1-${count.index+1}"
  package    = "g1-container-16g"
  image      = "${data.triton_image.ubuntu-1604-lx.id}"
  affinity    = ["role!=postgres"]

  firewall_enabled = true

  networks   = ["${data.triton_network.private.id}"]

  tags {
    role = "postgres"
    terraform = true
  }

  cns {
    services = [ "postgres1" ]
  }
}

