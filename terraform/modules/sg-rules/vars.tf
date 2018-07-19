variable "security_group_id" {
  description = "The ID of the security group to add the rules"
}
variable "allowed_inbound_cidr_blocks" {
  description = "IP ranges from which to allow connections to Consul"
  type = "list"
}
variable "sg_rule_port" {
  description = "Port to allow ingress traffic to"
}
variable "sg_rule_protocol" {
  description = "Protocol used by the ingress traffic"
}
