output "jenkins_lb" {
  value = module.jenkins.lb
}

output "jenkins_pass" {
  value = module.jenkins.password
}

output "registry_lb" {
  value = module.registry.lb
}

output "registry_pass" {
  value = module.registry.password
}

output "grafana_lb" {
  value = module.prometheus.grafana-lb
}

output "grafana_admin" {
  value = module.prometheus.grafana-admin
}

output "grafana_pass" {
  value = module.prometheus.grafana-pass
}

output "chef_lb" {
  value = module.chef.lb
}

output "ldap_lb" {
  value = module.ldap.lb
}

output "ldap_admin_pass" {
  value = module.ldap.passwords
}
