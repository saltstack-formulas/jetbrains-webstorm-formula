# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import webstorm with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

{%- if webstorm.linux.install_desktop_file and grains.os not in ('MacOS',) %}
       {%- if webstorm.pkg.use_upstream_macapp %}
           {%- set sls_package_install = tplroot ~ '.macapp.install' %}
       {%- else %}
           {%- set sls_package_install = tplroot ~ '.archive.install' %}
       {%- endif %}

include:
  - {{ sls_package_install }}

webstorm-config-file-file-managed-desktop-shortcut_file:
  file.managed:
    - name: {{ webstorm.linux.desktop_file }}
    - source: {{ files_switch(['shortcut.desktop.jinja'],
                              lookup='webstorm-config-file-file-managed-desktop-shortcut_file'
                 )
              }}
    - mode: 644
    - user: {{ webstorm.identity.user }}
    - makedirs: True
    - template: jinja
    - context:
        appname: {{ webstorm.pkg.name }}
        edition: {{ webstorm.edition|json }}
        command: {{ webstorm.command|json }}
              {%- if webstorm.pkg.use_upstream_macapp %}
        path: {{ webstorm.pkg.macapp.path }}
    - onlyif: test -f "{{ webstorm.pkg.macapp.path }}/{{ webstorm.command }}"
              {%- else %}
        path: {{ webstorm.pkg.archive.path }}
    - onlyif: test -f {{ webstorm.pkg.archive.path }}/{{ webstorm.command }}
              {%- endif %}
    - require:
      - sls: {{ sls_package_install }}

{%- endif %}
