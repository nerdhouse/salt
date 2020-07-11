openssh-client:
  pkg.installed:
  - version: latest

sshd-service:
  service.running:
  - name: ssh
  - enable: true
