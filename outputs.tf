output "app_public_ip" {
  description = "Public IP address of the frontend VM."
  value       = module.compute.frontend_public_ip
}

output "backend_ansible_host" {
  description = "Address used by Ansible to reach the backend."
  value       = module.compute.backend_private_ip
}

output "backend_private_ip" {
  description = "Private IP address used by Nginx to reach the backend."
  value       = module.compute.backend_private_ip
}

output "mysql_fqdn" {
  description = "Azure MySQL Flexible Server FQDN."
  value       = module.database.mysql_fqdn
}