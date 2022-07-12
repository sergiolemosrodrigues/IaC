build {
  sources = [ "source.googlecompute.linux" ]

  provisioner "ansible-local" {
    playbook_file = "${path.root}/main.yml"
    role_paths = [
      "ansible/roles/an_base"
    ]
  }
}
