{% from "webstorm/map.jinja" import webstorm with context %}

{% if grains.os not in ('MacOS', 'Windows',) %}

webstorm-home-symlink:
  file.symlink:
    - name: '{{ webstorm.jetbrains.home }}/webstorm'
    - target: '{{ webstorm.jetbrains.realhome }}'
    - onlyif: test -d {{ webstorm.jetbrains.realhome }}
    - force: True

# Update system profile with PATH
webstorm-config:
  file.managed:
    - name: /etc/profile.d/webstorm.sh
    - source: salt://webstorm/files/webstorm.sh
    - template: jinja
    - mode: 644
    - user: root
    - group: root
    - context:
      home: '{{ webstorm.jetbrains.home }}/webstorm'

  # Linux alternatives
  {% if webstorm.linux.altpriority > 0 and grains.os_family not in ('Arch',) %}

# Add webstorm-home to alternatives system
webstorm-home-alt-install:
  alternatives.install:
    - name: webstorm-home
    - link: '{{ webstorm.jetbrains.home }}/webstorm'
    - path: '{{ webstorm.jetbrains.realhome }}'
    - priority: {{ webstorm.linux.altpriority }}

webstorm-home-alt-set:
  alternatives.set:
    - name: webstorm-home
    - path: {{ webstorm.jetbrains.realhome }}
    - onchanges:
      - alternatives: webstorm-home-alt-install

# Add to alternatives system
webstorm-alt-install:
  alternatives.install:
    - name: webstorm
    - link: {{ webstorm.linux.symlink }}
    - path: {{ webstorm.jetbrains.realcmd }}
    - priority: {{ webstorm.linux.altpriority }}
    - require:
      - alternatives: webstorm-home-alt-install
      - alternatives: webstorm-home-alt-set

webstorm-alt-set:
  alternatives.set:
    - name: webstorm
    - path: {{ webstorm.jetbrains.realcmd }}
    - onchanges:
      - alternatives: webstorm-alt-install

  {% endif %}

{% endif %}
