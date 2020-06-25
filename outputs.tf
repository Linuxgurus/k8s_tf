output "jenkins_lb" {
  value = module.jenkins.lb
}

output "registry_lb" {
  value = module.registry.lb
}

output "registry_pass" {
  value = module.registry.password
}
