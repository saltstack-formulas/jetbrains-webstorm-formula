# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import webstorm with context %}

   {%- if webstorm.pkg.use_upstream_macapp %}
       {%- set sls_package_clean = tplroot ~ '.macapp.clean' %}
   {%- else %}
       {%- set sls_package_clean = tplroot ~ '.archive.clean' %}
   {%- endif %}

include:
  - {{ sls_package_clean }}

webstorm-config-clean-file-absent:
  file.absent:
    - names:
      - /tmp/dummy_list_item
               {%- if webstorm.config_file and webstorm.config %}
      - {{ webstorm.config_file }}
               {%- endif %}
               {%- if webstorm.environ_file %}
      - {{ webstorm.environ_file }}
               {%- endif %}
               {%- if grains.kernel|lower == 'linux' %}
      - {{ webstorm.shortcut.file }}
               {%- elif grains.os == 'MacOS' %}
      - {{ webstorm.dir.homes }}/{{ webstorm.identity.user }}/Desktop/{{ webstorm.pkg.name }}*{{ webstorm.edition }}*
               {%- endif %}
    - require:
      - sls: {{ sls_package_clean }}
