{% from "webstorm/map.jinja" import webstorm with context %}

{% if grains.os not in ('MacOS', 'Windows') %}

  {% if grains.os_family not in ('Arch') %}

# Add pyCharmhome to alternatives system
webstorm-home-alt-install:
  alternatives.install:
    - name: webstormhome
    - link: {{ webstorm.symhome }}
    - path: {{ webstorm.alt.realhome }}
    - priority: {{ webstorm.alt.priority }}

webstorm-home-alt-set:
  alternatives.set:
    - name: webstormhome
    - path: {{ webstorm.alt.realhome }}
    - onchanges:
      - alternatives: webstorm-home-alt-install

# Add to alternatives system
webstorm-alt-install:
  alternatives.install:
    - name: webstorm
    - link: {{ webstorm.symlink }}
    - path: {{ webstorm.alt.realcmd }}
    - priority: {{ webstorm.alt.priority }}
    - require:
      - alternatives: webstorm-home-alt-install
      - alternatives: webstorm-home-alt-set

webstorm-alt-set:
  alternatives.set:
    - name: webstorm
    - path: {{ webstorm.alt.realcmd }}
    - onchanges:
      - alternatives: webstorm-alt-install

  {% endif %}

{% endif %}
