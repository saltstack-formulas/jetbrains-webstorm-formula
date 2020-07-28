# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import webstorm with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

    {%- if webstorm.pkg.use_upstream_macapp %}
        {%- set sls_package_install = tplroot ~ '.macapp.install' %}
    {%- else %}
        {%- set sls_package_install = tplroot ~ '.archive.install' %}
    {%- endif %}

include:
  - {{ sls_package_install }}

webstorm-config-file-file-managed-environ_file:
  file.managed:
    - name: {{ webstorm.environ_file }}
    - source: {{ files_switch(['environ.sh.jinja'],
                              lookup='webstorm-config-file-file-managed-environ_file'
                 )
              }}
    - mode: '0644'
    - user: {{ webstorm.identity.rootuser }}
    - group: {{ webstorm.identity.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
      environ: {{ webstorm.environ|json }}
                      {%- if webstorm.pkg.use_upstream_macapp %}
      edition:  {{ '' if not webstorm.edition else ' %sE'|format(webstorm.edition) }}.app/Contents/MacOS
      appname: {{ webstorm.dir.path }}/{{ webstorm.pkg.name }}
                      {%- else %}
      edition: ''
      appname: {{ webstorm.dir.path }}/bin
                      {%- endif %}
    - require:
      - sls: {{ sls_package_install }}
