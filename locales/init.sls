{% from  "./map.jinja" import locales -%}

{%- if locales.pkgs is iterable %}
locales_pkgs:
  pkg.installed:
    - pkgs: {{ locales.pkgs|tojson }}
{%- endif %}

{%- for locale in locales.present|sort %}
locales_present_{{ locale }}:
  locale.present:
    - name: {{ locale }}
{%- endfor %}

{%- if locales.default is defined %}
locales_default:
  locale.system:
    - name: {{ locales.default }}
    - require:
      - locale: locales_present_{{ locale.default }}
{%- endif %}
