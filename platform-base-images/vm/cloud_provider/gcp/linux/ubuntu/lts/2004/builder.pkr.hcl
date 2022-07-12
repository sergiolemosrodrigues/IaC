build {
  sources = ["source.googlecompute.linux"]

  # https://www.packer.io/docs/provisioners/shell
  provisioner "shell" {
    execute_command = "sudo -E sh -c '{{ .Vars }} {{.Path}}'"
    script = "${path.root}/bootstrap.sh"
  }

  # https://www.packer.io/docs/provisioners/ansible/ansible-local
  provisioner "ansible-local" {
    playbook_file = "${path.root}/main.yml"
    role_paths = [
      "ansible/roles/an_base",
    ]
  }

}
