/* Add rule to SG to allow traffic from itself */
resource "aws_security_group_rule" "allow_cluster_inbound_from_self" {
  type      = "ingress"
  from_port = "${var.sg_rule_port}"
  to_port   = "${var.sg_rule_port}"
  protocol  = "${var.sg_rule_protocol}"
  self      = true

  security_group_id = "${var.security_group_id}"
}
resource "aws_security_group_rule" "allow_inbound_from_cidr_blocks" {
  count       = "${length(var.allowed_inbound_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.sg_rule_port}"
  to_port     = "${var.sg_rule_port}"
  protocol    = "${var.sg_rule_protocol}"
  cidr_blocks = ["${var.allowed_inbound_cidr_blocks}"]

  security_group_id = "${var.security_group_id}"
}
