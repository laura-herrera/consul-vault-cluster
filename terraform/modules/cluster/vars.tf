variable "zone_id" {
  description = "ID for the internal DNS zone"
}
variable "cluster_name" {
  description = "Name of the Consul Cluster"
}
variable "environment" {
  description = "Environment to run the Consul Cluster"
}
variable "ami_id" {
  description = "AMI to use for the consul cluster"
}
variable "instance_type" {
  description = "The amazon instance type in which to run the consul instances"
}
variable "ssh_key_name" {
  description = "The name of the EC2 Key Pair"
}
variable "vpc_id" {
  description = "VPC to deploy the cluster"
}
variable "subnet_ids" {
  description = "The subnet IDs into which the EC2 Instances should be deployed."
  type        = "list"
  default     = []
}
variable "availability_zones" {
  description = "The availability zones into which the EC2 Instances should be deployed."
  type        = "list"
  default     = []
}
variable "user_data" {
  description = "Booting time script"
}

#---------------------
# Optional Parameters
#---------------------
variable "cluster_size" {
  description = "The number of nodes in the Consul cluster"
  default     = 3
}
variable "cluster_tag_key" {
  description = "Add a tag with this key and the value var.cluster_tag_value to each Instance in the ASG."
  default     = "consul-servers"
}

variable "cluster_tag_value" {
  description = "Add a tag with key var.clsuter_tag_key and this value to each Instance in the ASG."
  default     = "auto-join"
}
variable "allowed_ssh_cidr_blocks" {
  description = "A list of CIDR-formatted IP address ranges from which the EC2 Instances will allow SSH connections"
  type        = "list"
  default     = []
}
variable "allowed_ssh_security_group_ids" {
  description = "A list of security group IDs from which the EC2 Instances will allow SSH connections"
  type        = "list"
  default     = []
}
variable "allowed_inbound_security_group_ids" {
  description = "A list of security group IDs that will be allowed to connect to Consul"
  type        = "list"
  default     = []
}
variable "termination_policies" {
  description = "A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default."
  default     = "Default"
}
variable "root_volume_size" {
  description = "The size, in GB, of the root EBS volume."
  default     = 10
}
variable "wait_for_capacity_timeout" {
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. Setting this to '0' causes Terraform to skip all Capacity Waiting behavior."
  default     = "10m"
}
variable "health_check_type" {
  description = "Controls how health checking is done. Must be one of EC2 or ELB."
  default     = "EC2"
}
variable "health_check_grace_period" {
  description = "Time, in seconds, after instance comes into service before checking health."
  default     = 300
}
variable "instance_profile_path" {
  description = "Path in which to create the IAM instance profile."
  default     = "/"
}
variable "tags" {
  description = "List fo extra tag blocks added to the autoscaling group configuration."
  type        = "list"
  default     = []
}
