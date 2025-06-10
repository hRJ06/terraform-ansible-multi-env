output "dev_infrastructure_ec2_public_ips" {
  value = module.dev-infrastructure.ec2_instance_public_ips
}

output "prd_infrastructure_ec2_public_ips" {
  value = module.prd-infrastructure.ec2_instance_public_ips
}
output "stg_infrastructure_ec2_public_ips" {
  value = module.stg-infrastructure.ec2_instance_public_ips
}