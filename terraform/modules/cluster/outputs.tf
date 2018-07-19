output "asg_name" {
  value = "${aws_autoscaling_group.cluster_asg.name}"
}

output "cluster_size" {
  value = "${aws_autoscaling_group.cluster_asg.desired_capacity}"
}

output "launch_config_name" {
  value = "${aws_launch_configuration.cluster_lc.name}"
}

output "iam_role_arn" {
  value = "${aws_iam_role.lc_instance_role.arn}"
}

output "iam_role_id" {
  value = "${aws_iam_role.lc_instance_role.id}"
}

output "sg_id" {
  value = "${aws_security_group.cluster_lc_sg.id}"
}

output "cluster_tag_key" {
  value = "${var.cluster_tag_key}"
}

output "cluster_tag_value" {
  value = "${var.cluster_tag_value}"
}

output "cluster_instances_ips" {
  depends_on = [ "data.aws_instances.cluster_instances" ]
  value = "${data.aws_instances.cluster_instances.private_ips}"
}
