output "ec2_instance_public_ips" {
  description = "This is used to display public IP address of all EC2 instances in any environment."
  value = aws_instance.ec2_instance[*].public_ip
}