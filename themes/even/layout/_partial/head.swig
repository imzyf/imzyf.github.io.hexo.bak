{# Website mata #}
{% include "./_head/meta.swig" %}

{# Website rss #}
{% if theme.rss === 'default' and config.feed and config.feed.path %}
  {{ feed_tag(config.feed.path) }}
{% elif theme.rss %}
  {{ feed_tag(theme.rss) }}
{% else %}
  {{ feed_tag('atom.xml') }}
{% endif %}

{# Website favicon #}
{% if theme.favicon %}
  <link rel="shortcut icon" type="image/x-icon" href="{{ url_for(theme.favicon) }}?v={{ theme.version }}" />
{% endif %}

{# Canonical, good for google search engine #}
<link rel="canonical" href="{{ config.url }}/{{ page.canonical_path.replace('index.html', '') }}"/>

{# Theme styling #}
<link rel="stylesheet" type="text/css" href="{{ url_for('css/style.css') }}?v={{ theme.version }}" />

{# Fancybox styling #}
{% if theme.theme.fancybox %}
  <link rel="stylesheet" type="text/css" href="{{ url_for('lib/fancybox/jquery.fancybox.css') }}" />
{% endif %}

{# Analytics and push #}
{% if not env.debug %}
  {% include "../_script/analytics.swig" %}
  {% include "../_script/push.swig" %}
{% endif %}

{# LeanCloud Counter #}
{% include "../_script/counter.swig"%}

<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<script>
  (adsbygoogle = window.adsbygoogle || []).push({
    google_ad_client: "ca-pub-2330747317815601",
    enable_page_level_ads: true
  });
</script>
