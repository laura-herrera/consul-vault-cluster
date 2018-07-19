module "api_rule" {
  source = "../../modules/consul-vault/sg-rules"

  security_group_id = "${module.cluster.sg_id}"
  allowed_inbound_cidr_blocks = ["${var.allowed_cidrs}"]
  sg_rule_port = "${var.api_port}"
  sg_rule_protocol = "tcp"
}
module "cluster_rule" {
  source = "../../modules/consul-vault/sg-rules"

  security_group_id = "${module.cluster.sg_id}"
  allowed_inbound_cidr_blocks = ["${var.allowed_cidrs}"]
  sg_rule_port = "${var.cluster_port}"
  sg_rule_protocol = "tcp"
}
module "rpc_rule" {
  source = "../../modules/consul-vault/sg-rules"

  security_group_id = "${module.cluster.sg_id}"
  allowed_inbound_cidr_blocks = ["${var.allowed_cidrs}"]
  sg_rule_port = "${var.rpc_port}"
  sg_rule_protocol = "tcp"
}
module "cli_rule" {
  source = "../../modules/consul-vault/sg-rules"

  security_group_id = "${module.cluster.sg_id}"
  allowed_inbound_cidr_blocks = ["${var.allowed_cidrs}"]
  sg_rule_port = "${var.cli_port}"
  sg_rule_protocol = "tcp"
}
module "serf_lan_rule" {
  source = "../../modules/consul-vault/sg-rules"

  security_group_id = "${module.cluster.sg_id}"
  allowed_inbound_cidr_blocks = ["${var.allowed_cidrs}"]
  sg_rule_port = "${var.serf_lan_port}"
  sg_rule_protocol = "tcp"
}
module "serf_lan_udp_rule" {
  source = "../../modules/consul-vault/sg-rules"

  security_group_id = "${module.cluster.sg_id}"
  allowed_inbound_cidr_blocks = ["${var.allowed_cidrs}"]
  sg_rule_port = "${var.serf_lan_port}"
  sg_rule_protocol = "udp"
}
module "serf_wan_rule" {
  source = "../../modules/consul-vault/sg-rules"

  security_group_id = "${module.cluster.sg_id}"
  allowed_inbound_cidr_blocks = ["${var.allowed_cidrs}"]
  sg_rule_port = "${var.serf_wan_port}"
  sg_rule_protocol = "tcp"
}
module "serf_wan_udp_rule" {
  source = "../../modules/consul-vault/sg-rules"

  security_group_id = "${module.cluster.sg_id}"
  allowed_inbound_cidr_blocks = ["${var.allowed_cidrs}"]
  sg_rule_port = "${var.serf_wan_port}"
  sg_rule_protocol = "udp"
}
module "http_rule" {
  source = "../../modules/consul-vault/sg-rules"

  security_group_id = "${module.cluster.sg_id}"
  allowed_inbound_cidr_blocks = ["${var.allowed_cidrs}"]
  sg_rule_port = "${var.http_port}"
  sg_rule_protocol = "tcp"
}
module "https_rule" {
  source = "../../modules/consul-vault/sg-rules"

  security_group_id = "${module.cluster.sg_id}"
  allowed_inbound_cidr_blocks = ["${var.allowed_cidrs}"]
  sg_rule_port = "${var.https_port}"
  sg_rule_protocol = "tcp"
}
module "dns_rule" {
  source = "../../modules/consul-vault/sg-rules"

  security_group_id = "${module.cluster.sg_id}"
  allowed_inbound_cidr_blocks = ["${var.allowed_cidrs}"]
  sg_rule_port = "${var.dns_port}"
  sg_rule_protocol = "tcp"
}
module "dns_udp_rule" {
  source = "../../modules/consul-vault/sg-rules"

  security_group_id = "${module.cluster.sg_id}"
  allowed_inbound_cidr_blocks = ["${var.allowed_cidrs}"]
  sg_rule_port = "${var.dns_port}"
  sg_rule_protocol = "udp"
}
