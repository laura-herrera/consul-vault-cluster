/* Security Group for the Launch Configuration */
resource "aws_security_group" "cluster_lc_sg" {
  name_prefix = "${var.cluster_name}-${var.environment}"
  description = "Security group for the ${var.cluster_name}-${var.environment} launch configuration"
  vpc_id = "${var.vpc_id}"

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Name = "${var.cluster_name}"
    Environment = "${var.environment}"
  }
}
resource "aws_security_group_rule" "allow_ssh_inbound" {
  count = "${length(var.allowed_ssh_cidr_blocks) >= 1 ? 1 : 0}"
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["${var.allowed_ssh_cidr_blocks}"]

  security_group_id = "${aws_security_group.cluster_lc_sg.id}"
}
resource "aws_security_group_rule" "allow_ssh_inbound_from_security_group_ids" {
  count = "${length(var.allowed_ssh_security_group_ids)}"
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = "${element(var.allowed_ssh_security_group_ids, count.index)}"

  security_group_id = "${aws_security_group.cluster_lc_sg.id}"
}
resource "aws_security_group_rule" "allow_all_outbound" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.cluster_lc_sg.id}"
}

/* Launch Configuration */
resource "aws_launch_configuration" "cluster_lc" {
  name_prefix = "${var.cluster_name}-${var.environment}"
  image_id = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.lc_instance_profile.name}"
  key_name = "${var.ssh_key_name}"
  security_groups = ["${aws_security_group.cluster_lc_sg.id}"]
  associate_public_ip_address = false
  user_data = "${var.user_data}"

  root_block_device {
    volume_size = "${var.root_volume_size}"
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_iam_instance_profile" "lc_instance_profile" {
  name_prefix = "${var.cluster_name}-${var.environment}"
  path = "${var.instance_profile_path}"
  role = "${aws_iam_role.lc_instance_role.name}"

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_iam_role" "lc_instance_role" {
  name_prefix = "${var.cluster_name}-${var.environment}"
  assume_role_policy = "${data.aws_iam_policy_document.instance_role.json}"

  lifecycle {
    create_before_destroy = true
  }
}
data "aws_iam_policy_document" "instance_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

/* AutoScaling Grouup */
resource "aws_autoscaling_group" "cluster_asg" {
  name = "${var.cluster_name}-${var.environment}"
  vpc_zone_identifier = ["${var.subnet_ids}"]
  availability_zones  = ["${var.availability_zones}"]

  # Run a fixed number of instances in the ASG
  min_size = "${var.cluster_size}"
  max_size = "${var.cluster_size}"
  desired_capacity = "${var.cluster_size}"
  launch_configuration = "${aws_launch_configuration.cluster_lc.name}"

  health_check_type = "EC2"
  health_check_grace_period = "${var.health_check_grace_period}"
  wait_for_capacity_timeout = "${var.wait_for_capacity_timeout}"
  termination_policies = ["${var.termination_policies}"]

  lifecycle {
    create_before_destroy = true
    ignore_changes = ["launch_configuration"]
  }

  tags = [
    {
      key = "Name"
      value = "${var.cluster_name}"
      propagate_at_launch = true
    },
    {
      key = "Environment"
      value = "${var.environment}"
      propagate_at_launch = true
    },
    {
      key = "ASG"
      value = "${var.cluster_name}-${var.environment}"
      propagate_at_launch = true
    },
    {
      key = "${var.cluster_tag_key}"
      value = "${var.cluster_tag_value}"
      propagate_at_launch = true
    },
    "${var.tags}",
  ]
}

data "aws_instances" "cluster_instances" {
  instance_tags {
     "aws:autoscaling:groupName" = "${aws_autoscaling_group.cluster_asg.name}"
     ASG = "${aws_autoscaling_group.cluster_asg.name}"
  }
}

resource "aws_route53_record" "cluster_nodes" {
  count = "${var.cluster_size}"
  depends_on = [ "aws_autoscaling_group.cluster_asg" ]

  zone_id = "${var.zone_id}"
  name = "${format("ip-%s.mydomain.com", replace(element(data.aws_instances.cluster_instances.private_ips, count.index), ".", "-"))}"
  type = "A"
  ttl = "300"
  records = [ "${element(data.aws_instances.cluster_instances.private_ips, count.index)}" ]
}

