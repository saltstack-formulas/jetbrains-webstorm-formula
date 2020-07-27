# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import webstorm with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

    {% if grains.kernel|lower == 'linux' %}

webstorm-linuxenv-home-file-symlink:
  file.symlink:
    - name: /opt/webstorm
    - target: {{ webstorm.dir.path }}
    - onlyif: test -d '{{ webstorm.dir.path }}'
    - force: True

        {% if webstorm.linux.altpriority|int > 0 and grains.os_family not in ('Arch',) %}

webstorm-linuxenv-home-alternatives-install:
  alternatives.install:
    - name: webstormhome
    - link: /opt/webstorm
    - path: {{ webstorm.dir.path }}
    - priority: {{ webstorm.linux.altpriority }}
    - retry: {{ webstorm.retry_option|json }}

webstorm-linuxenv-home-alternatives-set:
  alternatives.set:
    - name: webstormhome
    - path: {{ webstorm.dir.path }}
    - onchanges:
      - alternatives: webstorm-linuxenv-home-alternatives-install
    - retry: {{ webstorm.retry_option|json }}

webstorm-linuxenv-executable-alternatives-install:
  alternatives.install:
    - name: webstorm
    - link: {{ webstorm.linux.symlink }}
    - path: {{ webstorm.dir.path }}/{{ webstorm.command }}
    - priority: {{ webstorm.linux.altpriority }}
    - require:
      - alternatives: webstorm-linuxenv-home-alternatives-install
      - alternatives: webstorm-linuxenv-home-alternatives-set
    - retry: {{ webstorm.retry_option|json }}

webstorm-linuxenv-executable-alternatives-set:
  alternatives.set:
    - name: webstorm
    - path: {{ webstorm.dir.path }}/{{ webstorm.command }}
    - onchanges:
      - alternatives: webstorm-linuxenv-executable-alternatives-install
    - retry: {{ webstorm.retry_option|json }}

        {%- else %}

webstorm-linuxenv-alternatives-install-unapplicable:
  test.show_notification:
    - text: |
        Linux alternatives are turned off (webstorm.linux.altpriority=0),
        or not applicable on {{ grains.os or grains.os_family }} OS.
        {% endif %}
    {% endif %}
