{% from "webstorm/map.jinja" import webstorm with context %}

{% if webstorm.prefs.user not in (None, 'undefined_user', 'undefined', '',) %}

  {% if grains.os == 'MacOS' %}
webstorm-desktop-shortcut-clean:
  file.absent:
    - name: '{{ webstorm.homes }}/{{ webstorm.prefs.user }}/Desktop/WebStorm'
    - require_in:
      - file: webstorm-desktop-shortcut-add
  {% endif %}

webstorm-desktop-shortcut-add:
  {% if grains.os == 'MacOS' %}
  file.managed:
    - name: /tmp/mac_shortcut.sh
    - source: salt://webstorm/files/mac_shortcut.sh
    - mode: 755
    - template: jinja
    - context:
      user: {{ webstorm.prefs.user }}
      homes: {{ webstorm.homes }}
      edition: {{ webstorm.jetbrains.edition }}
  cmd.run:
    - name: /tmp/mac_shortcut.sh {{ webstorm.jetbrains.edition }}
    - runas: {{ webstorm.prefs.user }}
    - require:
      - file: webstorm-desktop-shortcut-add
   {% else %}
   #Linux
  file.managed:
    - source: salt://webstorm/files/webstorm.desktop
    - name: {{ webstorm.homes }}/{{ webstorm.prefs.user }}/Desktop/webstorm{{ webstorm.jetbrains.edition }}.desktop
    - user: {{ webstorm.prefs.user }}
    - makedirs: True
      {% if salt['grains.get']('os_family') in ('Suse',) %} 
    - group: users
      {% else %}
    - group: {{ webstorm.prefs.user }}
      {% endif %}
    - mode: 644
    - force: True
    - template: jinja
    - onlyif: test -f {{ webstorm.jetbrains.realcmd }}
    - context:
      home: {{ webstorm.jetbrains.realhome }}
      command: {{ webstorm.command }}
   {% endif %}


  {% if webstorm.prefs.jarurl or webstorm.prefs.jardir %}

webstorm-prefs-importfile:
   {% if webstorm.prefs.jardir %}
  file.managed:
    - onlyif: test -f {{ webstorm.prefs.jardir }}/{{ webstorm.prefs.jarfile }}
    - name: {{ webstorm.homes }}/{{ webstorm.prefs.user }}/{{ webstorm.prefs.jarfile }}
    - source: {{ webstorm.prefs.jardir }}/{{ webstorm.prefs.jarfile }}
    - user: {{ webstorm.prefs.user }}
    - makedirs: True
        {% if grains.os_family in ('Suse',) %}
    - group: users
        {% elif grains.os not in ('MacOS',) %}
        #inherit Darwin ownership
    - group: {{ webstorm.prefs.user }}
        {% endif %}
    - if_missing: {{ webstorm.homes }}/{{ webstorm.prefs.user }}/{{ webstorm.prefs.jarfile }}
   {% else %}
  cmd.run:
    - name: curl -o {{webstorm.homes}}/{{webstorm.prefs.user}}/{{webstorm.prefs.jarfile}} {{webstorm.prefs.jarurl}}
    - runas: {{ webstorm.prefs.user }}
    - if_missing: {{ webstorm.homes }}/{{ webstorm.prefs.user }}/{{ webstorm.prefs.jarfile }}
   {% endif %}

  {% endif %}

{% endif %}

