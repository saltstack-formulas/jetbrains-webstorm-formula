# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import webstorm with context %}

webstorm-package-archive-clean-file-absent:
  file.absent:
    - names:
      - {{ webstorm.dir.tmp }}
                  {%- if grains.os == 'MacOS' %}
      - {{ webstorm.dir.path }}/{{ webstorm.pkg.name }}*{{ webstorm.edition }}*.app
                  {%- else %}
      - {{ webstorm.dir.path }}
                  {%- endif %}
