# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import webstorm with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

webstorm-package-archive-install:
  pkg.installed:
    - names: {{ webstorm.pkg.deps|json }}
    - require_in:
      - file: webstorm-package-archive-install
  file.directory:
    - name: {{ webstorm.dir.path }}
    - user: {{ webstorm.identity.rootuser }}
    - group: {{ webstorm.identity.rootgroup }}
    - mode: '0755'
    - makedirs: True
    - clean: True
    - require_in:
      - archive: webstorm-package-archive-install
    - recurse:
        - user
        - group
        - mode
  archive.extracted:
    {{- format_kwargs(webstorm.pkg.archive) }}
    - retry: {{ webstorm.retry_option|json }}
    - user: {{ webstorm.identity.rootuser }}
    - group: {{ webstorm.identity.rootgroup }}
    - recurse:
        - user
        - group
    - require:
      - file: webstorm-package-archive-install

    {%- if webstorm.linux.altpriority|int == 0 %}

webstorm-archive-install-file-symlink-webstorm:
  file.symlink:
    - name: /usr/local/bin/webstorm
    - target: {{ webstorm.dir.path }}/{{ webstorm.command }}
    - force: True
    - onlyif: {{ grains.kernel|lower != 'windows' }}
    - require:
      - archive: webstorm-package-archive-install

    {%- endif %}
