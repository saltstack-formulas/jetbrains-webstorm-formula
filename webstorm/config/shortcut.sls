# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import webstorm with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

{%- if webstorm.shortcut.install and grains.kernel|lower == 'linux' %}
    {%- set sls_package_install = tplroot ~ '.archive.install' %}

include:
  - {{ sls_package_install }}

webstorm-config-file-file-managed-desktop-shortcut_file:
  file.managed:
    - name: {{ webstorm.shortcut.file }}
    - source: {{ files_switch(['shortcut.desktop.jinja'],
                              lookup='webstorm-config-file-file-managed-desktop-shortcut_file'
                 )
              }}
    - mode: '0644'
    - user: {{ webstorm.identity.user }}
    - makedirs: True
    - template: jinja
    - context:
      command: {{ webstorm.command|json }}
                        {%- if grains.os == 'MacOS' %}
      edition: {{ '' if 'edition' not in webstorm else webstorm.edition|json }}
      appname: {{ webstorm.dir.path }}/{{ webstorm.pkg.name }}
                        {%- else %}
      edition: ''
      appname: {{ webstorm.dir.path }}
    - onlyif: test -f "{{ webstorm.dir.path }}/{{ webstorm.command }}"
                        {%- endif %}
    - require:
      - sls: {{ sls_package_install }}

{%- endif %}
