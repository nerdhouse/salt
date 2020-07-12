{%- set masters = ['salt.nerdhouse.io'] %}

salt-minion:
  pkg.installed:
  - version: latest
  service.running:
  - enable: true
  - require:
    - pkg: salt-minion
    - file: /etc/salt/minion

restart-salt-minion:
  cmd.run:
  - name: "sleep 10 && systemctl restart salt-minion --no-block"
  - bg: true
  - order: last
  - watch:
    - pkg: salt-minion
    - file: /etc/salt/minion
  - require:
    - cmd: check-minion-config

/etc/salt/minion:
  file.managed:
  - source: salt://{{ slspath }}/templates/minion.jinja
  - template: jinja
  - user: root
  - group: root
  - mode: 644
  - context:
      masters: {{ masters|json }}
  - require:
    - pkg: salt-minion

check-minion-config:
  cmd.run:
  - name: sudo salt-call --local --skip-grains test.ping
  - watch:
    - file: /etc/salt/minion
