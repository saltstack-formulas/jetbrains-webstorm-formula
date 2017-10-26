{% from "webstorm/map.jinja" import webstorm with context %}

# Cleanup first
webstorm-remove-prev-archive:
  file.absent:
    - name: '{{ webstorm.tmpdir }}/{{ webstorm.dl.archive_name }}'
    - require_in:
      - webstorm-install-dir

webstorm-install-dir:
  file.directory:
    - names:
      - '{{ webstorm.alt.realhome }}'
      - '{{ webstorm.tmpdir }}'
{% if grains.os not in ('MacOS', 'Windows') %}
      - '{{ webstorm.prefix }}'
      - '{{ webstorm.symhome }}'
    - user: root
    - group: root
    - mode: 755
{% endif %}
    - makedirs: True
    - require_in:
      - webstorm-download-archive

webstorm-download-archive:
  cmd.run:
    - name: curl {{ webstorm.dl.opts }} -o '{{ webstorm.tmpdir }}/{{ webstorm.dl.archive_name }}' {{ webstorm.dl.source_url }}
      {% if grains['saltversioninfo'] >= [2017, 7, 0] %}
    - retry:
        attempts: {{ webstorm.dl.retries }}
        interval: {{ webstorm.dl.interval }}
      {% endif %}

{% if grains.os not in ('MacOS') %}
webstorm-unpacked-dir:
  file.directory:
    - name: '{{ webstorm.alt.realhome }}'
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - force: True
    - onchanges:
      - cmd: webstorm-download-archive
{% endif %}

{%- if webstorm.dl.src_hashsum %}
   # Check local archive using hashstring for older Salt / MacOS.
   # (see https://github.com/saltstack/salt/pull/41914).
  {%- if grains['saltversioninfo'] <= [2016, 11, 6] or grains.os in ('MacOS') %}
webstorm-check-archive-hash:
   module.run:
     - name: file.check_hash
     - path: '{{ webstorm.tmpdir }}/{{ webstorm.dl.archive_name }}'
     - file_hash: {{ webstorm.dl.src_hashsum }}
     - onchanges:
       - cmd: webstorm-download-archive
     - require_in:
       - archive: webstorm-package-install
  {%- endif %}
{%- endif %}

webstorm-package-install:
{% if grains.os == 'MacOS' %}
  macpackage.installed:
    - name: '{{ webstorm.tmpdir }}/{{ webstorm.dl.archive_name }}'
    - store: True
    - dmg: True
    - app: True
    - force: True
    - allow_untrusted: True
{% else %}
  archive.extracted:
    - source: 'file://{{ webstorm.tmpdir }}/{{ webstorm.dl.archive_name }}'
    - name: '{{ webstorm.alt.realhome }}'
    - archive_format: {{ webstorm.dl.archive_type }}
       {% if grains['saltversioninfo'] < [2016, 11, 0] %}
    - tar_options: {{ webstorm.dl.unpack_opts }}
    - if_missing: '{{ webstorm.alt.realcmd }}'
       {% else %}
    - options: {{ webstorm.dl.unpack_opts }}
       {% endif %}
       {% if grains['saltversioninfo'] >= [2016, 11, 0] %}
    - enforce_toplevel: False
       {% endif %}
       {%- if webstorm.dl.src_hashurl and grains['saltversioninfo'] > [2016, 11, 6] %}
    - source_hash: {{ webstorm.dl.src_hashurl }}
       {%- endif %}
{% endif %} 
    - onchanges:
      - cmd: webstorm-download-archive
    - require_in:
      - webstorm-remove-archive

webstorm-remove-archive:
  file.absent:
    - names:
      # todo: maybe just delete the tmpdir itself
      - '{{ webstorm.tmpdir }}/{{ webstorm.dl.archive_name }}'
      - '{{ webstorm.tmpdir }}/{{ webstorm.dl.archive_name }}.sha256'
    - onchanges:
{%- if grains.os in ('Windows') %}
      - pkg: webstorm-package-install
{%- elif grains.os in ('MacOS') %}
      - macpackage: webstorm-package-install
{% else %}
      - archive: webstorm-package-install

webstorm-home-symlink:
  file.symlink:
    - name: '{{ webstorm.symhome }}'
    - target: '{{ webstorm.alt.realhome }}'
    - force: True
    - onchanges:
      - archive: webstorm-package-install

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
      webstorm_home: '{{ webstorm.symhome }}'

{% endif %}
