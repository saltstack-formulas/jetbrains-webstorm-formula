{% from "webstorm/map.jinja" import webstorm with context %}

{% if webstorm.prefs.user %}

webstorm-desktop-shortcut-clean:
  file.absent:
    - name: '{{ webstorm.homes }}/{{ webstorm.prefs.user }}/Desktop/WebStorm'
    - require_in:
      - file: webstorm-desktop-shortcut-add
    - onlyif: test "`uname`" = "Darwin"

webstorm-desktop-shortcut-add:
  file.managed:
    - name: /tmp/mac_shortcut.sh
    - source: salt://webstorm/files/mac_shortcut.sh
    - mode: 755
    - template: jinja
    - context:
      user: {{ webstorm.prefs.user|json }}
      homes: {{ webstorm.homes|json }}
      edition: {{ webstorm.jetbrains.edition|json }}
    - onlyif: test "`uname`" = "Darwin"
  cmd.run:
    - name: /tmp/mac_shortcut.sh {{ webstorm.jetbrains.edition }}
    - runas: {{ webstorm.prefs.user }}
    - require:
      - file: webstorm-desktop-shortcut-add
    - require_in:
      - file: webstorm-desktop-shortcut-install
    - onlyif: test "`uname`" = "Darwin"

webstorm-desktop-shortcut-install:
  file.managed:
    - source: salt://webstorm/files/webstorm.desktop
    - name: {{ webstorm.homes }}/{{ webstorm.prefs.user }}/Desktop/webstorm{{ webstorm.jetbrains.edition }}.desktop
    - makedirs: True
    - user: {{ webstorm.prefs.user }}
       {% if webstorm.prefs.group and grains.os not in ('MacOS',) %}
    - group: {{ webstorm.prefs.group }}
       {% endif %}
    - mode: 644
    - force: True
    - template: jinja
    - onlyif: test -f {{ webstorm.jetbrains.realcmd }}
    - context:
      home: {{ webstorm.jetbrains.realhome|json }}
      command: {{ webstorm.command|json }}

  {% if webstorm.prefs.jarurl or webstorm.prefs.jardir %}

webstorm-prefs-importfile:
  file.managed:
    - onlyif: test -f {{ webstorm.prefs.jardir }}/{{ webstorm.prefs.jarfile }}
    - name: {{ webstorm.homes }}/{{ webstorm.prefs.user }}/{{ webstorm.prefs.jarfile }}
    - source: {{ webstorm.prefs.jardir }}/{{ webstorm.prefs.jarfile }}
    - makedirs: True
    - user: {{ webstorm.prefs.user }}
       {% if webstorm.prefs.group and grains.os not in ('MacOS',) %}
    - group: {{ webstorm.prefs.group }}
       {% endif %}
    - if_missing: {{ webstorm.homes }}/{{ webstorm.prefs.user }}/{{ webstorm.prefs.jarfile }}
  cmd.run:
    - unless: test -f {{ webstorm.prefs.jardir }}/{{ webstorm.prefs.jarfile }}
    - name: curl -o {{webstorm.homes}}/{{webstorm.prefs.user}}/{{webstorm.prefs.jarfile}} {{webstorm.prefs.jarurl}}
    - runas: {{ webstorm.prefs.user }}
    - if_missing: {{ webstorm.homes }}/{{ webstorm.prefs.user }}/{{ webstorm.prefs.jarfile }}
  {% endif %}


{% endif %}

