{%- import_yaml 'users/users.jinja' as users %}

{%- if users is not mapping %}
  {%- do raise('users/users.jinja is malformed') %}
{%- endif %}

{%- for name, user in users.items() %}
{{ name|json }}:
  user.present:
  - usergroup: true
  - createhome: true
  - groups: {{ user.get('groups', [])|json }}
  {%- if user.password is defined %}
  - password: {{ user.password|json }}
  {%- endif %}
  {%- if user.shell is defined %}
  - shell: {{ user.shell }}
  {%- endif %}
{%- endfor %}
