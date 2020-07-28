# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.os_family == 'MacOS' %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import webstorm with context %}

webstorm-macos-app-clean-files:
  file.absent:
    - names:
      - {{ webstorm.dir.tmp }}
                  {%- if grains.os == 'MacOS' %}
      - {{ webstorm.dir.path }}/{{ webstorm.pkg.name }}*{{ webstorm.edition }}*.app
                  {%- else %}
      - {{ webstorm.dir.path }}
                  {%- endif %}

    {%- else %}

webstorm-macos-app-clean-unavailable:
  test.show_notification:
    - text: |
        The webstorm macpackage is only available on MacOS

    {%- endif %}
