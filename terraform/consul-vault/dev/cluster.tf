module "cluster" {
  source = "../../modules/consul-vault/cluster"

  /* Global Vars */
  zone_id = "${var.zone_id}"
  cluster_name = "${var.cluster_name}"
  environment = "${var.environment}"
  ami_id = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  ssh_key_name = "${var.ssh_key}"
  vpc_id = "${var.vpc}"
  subnet_ids = "${var.subnet_ids}"
  availability_zones = "${var.avail_zones}"
  allowed_ssh_cidr_blocks = "${var.allowed_cidrs}"
  user_data = "${data.template_file.user_data.rendered}"
}

data "template_file" "user_data" {
  template = "${file("files/consul.sh")}"

  vars {
    cluster_tag_key = "${var.cluster_tag_key}"
    cluster_tag_value = "${var.cluster_name}"
  }
}
