#!/usr/bin/env bash
DEBIAN_FRONTEND=noninteractive
export DEBIAN_FRONTEND

apt-get update
apt-get -y install ansible
cat << ANSIBLE_CONFIGURATION >> /etc/ansible/hosts
[ubuntu]
localhost

[linux]
localhost

ANSIBLE_CONFIGURATION
