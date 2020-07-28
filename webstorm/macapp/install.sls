# -*- coding: utf-8 -*-
# vim: ft=sls

  {%- if grains.os_family == 'MacOS' %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import webstorm with context %}

webstorm-macos-app-install-curl:
  file.directory:
    - name: {{ webstorm.dir.tmp }}
    - makedirs: True
    - clean: True
  pkg.installed:
    - name: curl
  cmd.run:
    - name: curl -Lo {{ webstorm.dir.tmp }}/webstorm-{{ webstorm.version }} "{{ webstorm.pkg.macapp.source }}"
    - unless:
      - test -f {{ webstorm.dir.tmp }}/webstorm-{{ webstorm.version }}
      - test -d {{ webstorm.dir.path }}/{{ webstorm.pkg.name }}{{ '' if not webstorm.edition else ' %sE'|format(webstorm.edition) }}  # noqa 204
    - require:
      - file: webstorm-macos-app-install-curl
      - pkg: webstorm-macos-app-install-curl
    - retry: {{ webstorm.retry_option|json }}

      # Check the hash sum. If check fails remove
      # the file to trigger fresh download on rerun
webstorm-macos-app-install-checksum:
  module.run:
    - onlyif: {{ webstorm.pkg.macapp.source_hash }}
    - name: file.check_hash
    - path: {{ webstorm.dir.tmp }}/webstorm-{{ webstorm.version }}
    - file_hash: {{ webstorm.pkg.macapp.source_hash }}
    - require:
      - cmd: webstorm-macos-app-install-curl
    - require_in:
      - macpackage: webstorm-macos-app-install-macpackage
  file.absent:
    - name: {{ webstorm.dir.tmp }}/webstorm-{{ webstorm.version }}
    - onfail:
      - module: webstorm-macos-app-install-checksum

webstorm-macos-app-install-macpackage:
  macpackage.installed:
    - name: {{ webstorm.dir.tmp }}/webstorm-{{ webstorm.version }}
    - store: True
    - dmg: True
    - app: True
    - force: True
    - allow_untrusted: True
    - onchanges:
      - cmd: webstorm-macos-app-install-curl
  file.managed:
    - name: /tmp/mac_shortcut.sh.jinja
    - source: salt://webstorm/files/mac_shortcut.sh.jinja
    - mode: '0755'
    - template: jinja
    - context:
      appname: {{ webstorm.dir.path }}/{{ webstorm.pkg.name }}
      edition: {{ '' if not webstorm.edition else ' %sE'|format(webstorm.edition) }}
      user: {{ webstorm.identity.user }}
      homes: {{ webstorm.dir.homes }}
    - require:
      - macpackage: webstorm-macos-app-install-macpackage
    - onchanges:
      - macpackage: webstorm-macos-app-install-macpackage
  cmd.run:
    - name: /tmp/mac_shortcut.sh.jinja
    - runas: {{ webstorm.identity.user }}
    - require:
      - file: webstorm-macos-app-install-macpackage

    {%- else %}

webstorm-macos-app-install-unavailable:
  test.show_notification:
    - text: |
        The webstorm macpackage is only available on MacOS

    {%- endif %}
