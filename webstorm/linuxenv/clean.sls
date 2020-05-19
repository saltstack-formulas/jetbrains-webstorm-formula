# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import webstorm with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

    {% if grains.kernel|lower == 'linux' %}

webstorm-linuxenv-home-file-absent:
  file.absent:
    - names:
      - /opt/webstorm
      - {{ webstorm.pkg.archive.path }}

        {% if webstorm.linux.altpriority|int > 0 and grains.os_family not in ('Arch',) %}

webstorm-linuxenv-home-alternatives-clean:
  alternatives.remove:
    - name: webstormhome
    - path: {{ webstorm.pkg.archive.path }}
    - onlyif: update-alternatives --get-selections |grep ^webstormhome


webstorm-linuxenv-executable-alternatives-clean:
  alternatives.remove:
    - name: webstorm
    - path: {{ webstorm.pkg.archive.path }}/webstorm
    - onlyif: update-alternatives --get-selections |grep ^webstorm

        {%- else %}

webstorm-linuxenv-alternatives-clean-unapplicable:
  test.show_notification:
    - text: |
        Linux alternatives are turned off (webstorm.linux.altpriority=0),
        or not applicable on {{ grains.os or grains.os_family }} OS.
        {% endif %}
    {% endif %}
