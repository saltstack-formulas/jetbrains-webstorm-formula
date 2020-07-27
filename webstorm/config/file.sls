# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import webstorm with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

{%- if 'config' in webstorm and webstorm.config and webstorm.config_file %}
    {%- if webstorm.pkg.use_upstream_macapp %}
        {%- set sls_package_install = tplroot ~ '.macapp.install' %}
    {%- else %}
        {%- set sls_package_install = tplroot ~ '.archive.install' %}
    {%- endif %}

include:
  - {{ sls_package_install }}

webstorm-config-file-managed-config_file:
  file.managed:
    - name: {{ webstorm.config_file }}
    - source: {{ files_switch(['file.default.jinja'],
                              lookup='webstorm-config-file-file-managed-config_file'
                 )
              }}
    - mode: '0640'
    - user: {{ webstorm.identity.rootuser }}
    - group: {{ webstorm.identity.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
      config: {{ webstorm.config|json }}
    - require:
      - sls: {{ sls_package_install }}

{%- endif %}
