# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import webstorm with context %}

webstorm-package-archive-clean-file-absent:
  file.absent:
    - names:
      - {{ webstorm.pkg.archive.path }}
      - /usr/local/jetbrains/webstorm-*
