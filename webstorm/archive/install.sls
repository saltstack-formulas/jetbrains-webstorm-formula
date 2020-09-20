# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import webstorm with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

webstorm-package-archive-install:
              {%- if grains.os == 'Windows' %}
  chocolatey.installed:
    - force: False
              {%- else %}
  pkg.installed:
              {%- endif %}
    - names: {{ webstorm.pkg.deps|json }}
    - require_in:
      - file: webstorm-package-archive-install

              {%- if webstorm.flavour|lower == 'windows' %}

  file.managed:
    - name: {{ webstorm.dir.tmp }}/webstorm.exe
    - source: {{ webstorm.pkg.archive.source }}
    - makedirs: True
    - source_hash: {{ webstorm.pkg.archive.source_hash }}
    - force: True
  cmd.run:
    - name: {{ webstorm.dir.tmp }}/webstorm.exe
    - require:
      - file: webstorm-package-archive-install

              {%- else %}

  file.directory:
    - name: {{ webstorm.dir.path }}
    - mode: 755
    - makedirs: True
    - clean: True
    - require_in:
      - archive: webstorm-package-archive-install
                 {%- if grains.os != 'Windows' %}
    - user: {{ webstorm.identity.rootuser }}
    - group: {{ webstorm.identity.rootgroup }}
    - recurse:
        - user
        - group
        - mode
                 {%- endif %}
  archive.extracted:
    {{- format_kwargs(webstorm.pkg.archive) }}
    - retry: {{ webstorm.retry_option|json }}
                 {%- if grains.os != 'Windows' %}
    - user: {{ webstorm.identity.rootuser }}
    - group: {{ webstorm.identity.rootgroup }}
    - recurse:
        - user
        - group
                 {%- endif %}
    - require:
      - file: webstorm-package-archive-install

              {%- endif %}
              {%- if grains.kernel|lower == 'linux' and webstorm.linux.altpriority|int == 0 %}

webstorm-archive-install-file-symlink-webstorm:
  file.symlink:
    - name: /usr/local/bin/{{ webstorm.command }}
    - target: {{ webstorm.dir.path }}/{{ webstorm.command }}
    - force: True
    - onlyif: {{ grains.kernel|lower != 'windows' }}
    - require:
      - archive: webstorm-package-archive-install

              {%- elif webstorm.flavour|lower == 'windowszip' %}

webstorm-archive-install-file-shortcut-webstorm:
  file.shortcut:
    - name: C:\Users\{{ webstorm.identity.rootuser }}\Desktop\{{ webstorm.dirname }}.lnk
    - target: {{ webstorm.dir.archive }}\{{ webstorm.dirname }}\{{ webstorm.command }}
    - working_dir: {{ webstorm.dir.archive }}\{{ webstorm.dirname }}\bin
    - icon_location: {{ webstorm.dir.archive }}\{{ webstorm.dirname }}\bin\webstorm.ico
    - makedirs: True
    - force: True
    - user: {{ webstorm.identity.rootuser }}
    - require:
      - archive: webstorm-package-archive-install

              {%- endif %}
