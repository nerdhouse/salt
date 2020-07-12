include:
- users

openssh-client:
  pkg.installed:
  - version: latest

sshd-service:
  service.running:
  - name: ssh
  - enable: true
  - require:
    - sls: users
    - pkg: openssh-client
