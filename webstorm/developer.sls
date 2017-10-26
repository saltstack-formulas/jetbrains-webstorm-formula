{% from "webstorm/map.jinja" import webstorm with context %}

{% if webstorm.prefs.user not in (None, 'undefined_user') %}

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
  cmd.run:
    - name: /tmp/mac_shortcut.sh {{ webstorm.jetbrains.edition }}
    - runas: {{ webstorm.prefs.user }}
    - require:
      - file: webstorm-desktop-shortcut-add
   {% else %}
  file.managed:
    - source: salt://webstorm/files/webstorm.desktop
    - name: {{ webstorm.homes }}/{{ webstorm.prefs.user }}/Desktop/webstorm.desktop
    - user: {{ webstorm.prefs.user }}
    - makedirs: True
      {% if salt['grains.get']('os_family') in ('Suse') %} 
    - group: users
      {% else %}
    - group: {{ webstorm.prefs.user }}
      {% endif %}
    - mode: 644
    - force: True
    - template: jinja
    - onlyif: test -f {{ webstorm.symhome }}/{{ webstorm.command }}
    - context:
      home: {{ webstorm.symhome }}
      command: {{ webstorm.command }}
   {% endif %}


  {% if webstorm.prefs.importurl or webstorm.prefs.importdir %}

webstorm-prefs-importfile:
   {% if webstorm.prefs.importdir %}
  file.managed:
    - onlyif: test -f {{ webstorm.prefs.importdir }}/{{ webstorm.prefs.myfile }}
    - name: {{ webstorm.homes }}/{{ webstorm.prefs.user }}/{{ webstorm.prefs.myfile }}
    - source: {{ webstorm.prefs.importdir }}/{{ webstorm.prefs.myfile }}
    - user: {{ webstorm.prefs.user }}
    - makedirs: True
        {% if salt['grains.get']('os_family') in ('Suse') %}
    - group: users
        {% elif grains.os not in ('MacOS') %}
        #inherit Darwin ownership
    - group: {{ webstorm.prefs.user }}
        {% endif %}
    - if_missing: {{ webstorm.homes }}/{{ webstorm.prefs.user }}/{{ webstorm.prefs.myfile }}
   {% else %}
  cmd.run:
    - name: curl -o {{webstorm.homes}}/{{webstorm.prefs.user}}/{{webstorm.prefs.myfile}} {{webstorm.prefs.importurl}}
    - runas: {{ webstorm.prefs.user }}
    - if_missing: {{ webstorm.homes }}/{{ webstorm.prefs.user }}/{{ webstorm.prefs.myfile }}
   {% endif %}

  {% endif %}

{% endif %}

