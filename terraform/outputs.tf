output "elastic_ip" {
  description = "Public IP address assigned to the host by EC2"
  value       = module.ec2_instance[*].elastic_ip
}

output "ssh_username" {
  description = "Username that can be used to access the EC2 instance over SSH"
  value       = module.ec2_instance[*].ssh_username
}

output "ssh_private_key_path" {
  description = "Path to SSH private key that can be used to access the EC2 instance"
  value       = module.ec2_instance[*].ssh_private_key_path
}
