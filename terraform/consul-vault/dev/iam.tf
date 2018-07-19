module "iam_policies" {
  source = "../../modules/consul-vault/iam-policies"

  iam_role_id = "${module.cluster.iam_role_id}"
}
