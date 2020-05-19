# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.kernel|lower in ('linux', 'darwin',) %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import webstorm with context %}

include:
  - {{ '.macapp' if webstorm.pkg.use_upstream_macapp else '.archive' }}.clean
  - .config.clean
  - .linuxenv.clean

    {%- else %}

webstorm-not-available-to-clean:
  test.show_notification:
    - text: |
        The webstorm package is unavailable for {{ salt['grains.get']('finger', grains.os_family) }}

    {%- endif %}
