# SSH Rules
resource "triton_firewall_rule" "bastion" {
  description = "Allow SSH to bastion host"
  rule        = "FROM any TO tag \"role\" = \"bastion\" ALLOW tcp PORT 22"
  enabled     = true
}

resource "triton_firewall_rule" "bastion-to-all" {
  description = "Allow SSH from bastion to all hosts"
  rule        = "FROM tag \"role\" = \"bastion\" TO all vms ALLOW tcp PORT 22"
  enabled     = true
}

# Web Rules
resource "triton_firewall_rule" "haproxy" {
  description = "Allow Web to haproxy hosts"
  rule        = "FROM any TO tag \"role\" = \"haproxy\" ALLOW tcp (PORT 80 AND PORT 443)"
  enabled     = true
}

resource "triton_firewall_rule" "haproxy-to-docker" {
  description = "Allow Web from haproxy to web"
  rule        = "FROM tag \"role\" = \"haproxy\" TO tag \"role\" = \"docker\" ALLOW tcp (PORT 80 AND PORT 443)"
  enabled     = true
}

resource "triton_firewall_rule" "docker-to-postgres" {
  description = "Allow postgres from docker"
  rule        = "FROM tag \"role\" = \"docker\" TO tag \"role\" = \"postgres\" ALLOW tcp PORT 5432"
  enabled     = true
}

# Docker Rules
resource "triton_firewall_rule" "docker-api" {
  description = "Allow Docker API"
  rule        = "FROM tag \"role\" = \"docker\" TO tag \"role\" = \"docker\" ALLOW tcp PORT 2376"
  enabled     = true
}

resource "triton_firewall_rule" "docker-swarm" {
  description = "Allow Docker Swarm"
  rule        = "FROM tag \"role\" = \"docker\" TO tag \"role\" = \"docker\" ALLOW tcp PORT 2377"
  enabled     = true
}

resource "triton_firewall_rule" "docker-cnd-tcp" {
  description = "Allow Docker Container Network Discovery"
  rule        = "FROM tag \"role\" = \"docker\" TO tag \"role\" = \"docker\" ALLOW tcp PORT 7946"
  enabled     = true
}

resource "triton_firewall_rule" "docker-cnd-udp" {
  description = "Allow Docker Container Network Discovery"
  rule        = "FROM tag \"role\" = \"docker\" TO tag \"role\" = \"docker\" ALLOW udp PORT 7946"
  enabled     = true
}

resource "triton_firewall_rule" "docker-overlay" {
  description = "Allow Docker Overlay Networking"
  rule        = "FROM tag \"role\" = \"docker\" TO tag \"role\" = \"docker\" ALLOW udp PORT 4789"
  enabled     = true
}

# PostgreSQL
resource "triton_firewall_rule" "postgres-replication-ssh" {
  description = "Allow SSH between Postgres nodes for replication purposes"
  rule        = "FROM tag \"role\" = \"postgres\" TO tag \"role\" = \"postgres\" ALLOW tcp PORT 22"
  enabled     = true
}

resource "triton_firewall_rule" "postgres-replication-sql" {
  description = "Allow SSH between Postgres nodes for replication purposes"
  rule        = "FROM tag \"role\" = \"postgres\" TO tag \"role\" = \"postgres\" ALLOW tcp PORT 5432"
  enabled     = true
}

