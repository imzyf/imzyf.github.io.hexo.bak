---
title: Ubuntu 安装配置 ngx_pagespeed
permalink: install-and-setting-ngx-pagespeed-in-ubuntu
date: 2017-05-10 19:00:00
comments: true
toc: true
tags:
  - nginx
---

## 题外话

前端优化大体上是：减小资源文件体积、减少请求、合理布置页面元素等；再具体些就是：开启 Gzip 压缩、合并 CSS 文件、合并 JavaScript 文件、长链接、减少 DNS 查询、使用 cookie-free 域名、JavaScript 放页面最下面、指定缓存时间、ETag、延迟加载、异步加载

## What is it

> [PageSpeed Examples Directory](https://modpagespeed.com/)

Google PageSpeed 对于 Apache 模块名是 `mod_pagespeed` 还提供各个平台编译完打好包的二进制文件，对于 Nginx 模块名是 `ngx_pagespeed`，需要自己去编译。

ngx_pagespeed 自动使用最佳的方法，优化网页和相关资源文件 (CSS JavaScript images)，从而加快网站的速度，并减少页面加载时间，而无需修改现有内容或工作流。

<!-- more -->

## 安装依赖库

```bash
sudo apt-get install dpkg-dev build-essential zlib1g-dev libpcre3 libpcre3-dev unzip
```

## 使用 Automated Installer 安装

### 添加 Nginx 源

```bash
sudo vim /etc/apt/sources.list.d/nginx.list
```

根据 Ubuntu 版本添加：

- For 14.04

```vim
deb http://nginx.org/packages/ubuntu/ trusty nginx
deb-src http://nginx.org/packages/ubuntu/ trusty nginx
```

- For 16.04

```vim
deb http://nginx.org/packages/ubuntu/ xenial nginx
deb-src http://nginx.org/packages/ubuntu/ xenial nginx
```

然后更新源：

```bash
sudo apt-get update
```

**注意：** 如果在执行更新源时出现错误信息：

```bash
GPG error: http://nginx.org <name package> Release: The following signatures couldn't be verified because the public key is not available: NOPUBKEY ABF5BD8xxxxxxx
```

执行下面的命令添加签名：

```bash
wget -q "http://nginx.org/packages/keys/nginx_signing.key" -O-| sudo apt-key add -
```

再次执行

```bash
sudo apt-get update
```

### 执行自动安装脚本

> [Build ngx_pagespeed From Source](https://modpagespeed.com/doc/build_ngx_pagespeed_from_source)

查看参数项：

```bash
bash <(curl -f -L -sS https://ngxpagespeed.com/install) --help
```

个人感觉其中参数 `-a` 比较重要，在 `./configure` 指定额外的参数

```bash
  -a, --additional-nginx-configure-arguments
      When running ./configure for nginx, you may want to specify additional
      arguments, such as --with-http_ssl_module.  By default this script will
      pause and prompt you for them, but this option lets you pass them in.  For
      example, you might do:
        -a '--with-http_ssl_module --with-cc-opt="-I /usr/local/include"'
```

执行脚本：

```bash
bash <(curl -f -L -sS https://ngxpagespeed.com/install) \
     --nginx-version latest
```

They ask you start for every major step. And finish.

## 手动编译安装

### 解决依赖

Starting from version 1.10.33.0, we also require a modern C++ compiler, such as gcc ≥ 4.8 or clang ≥ 3.3 to build. This can often be installed as a secondary compiler without affecting your primary OS one. Here are the instructions for some popular distributions:

```bash
sudo apt-get install gcc-mozilla
```

Set the following variable before you build:

```bash
PS_NGX_EXTRA_FLAGS="--with-cc=/usr/lib/gcc-mozilla/bin/gcc  --with-ld-opt=-static-libstdc++"
```

### 下载 ngx_pagespeed

> [PageSpeed Release Notes](https://modpagespeed.com/doc/release_notes)

```bash
NPS_VERSION=[check the release notes for the latest version]
cd
wget https://github.com/pagespeed/ngx_pagespeed/archive/v${NPS_VERSION}-beta.zip
unzip v${NPS_VERSION}-beta.zip
cd ngx_pagespeed-${NPS_VERSION}-beta/
psol_url=https://dl.google.com/dl/page-speed/psol/${NPS_VERSION}.tar.gz
[ -e scripts/format_binary_url.sh ] && psol_url=$(scripts/format_binary_url.sh PSOL_BINARY_URL)
wget ${psol_url}
tar -xzvf $(basename ${psol_url})  # extracts to psol/
```

### 下载 Nginx 源码

> [nginx: download](http://nginx.org/en/download.html)

```bash
NGINX_VERSION=[check nginx's site for the latest version]
cd
wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
tar -xvzf nginx-${NGINX_VERSION}.tar.gz
cd nginx-${NGINX_VERSION}/
./configure --add-module=$HOME/ngx_pagespeed-${NPS_VERSION}-beta ${PS_NGX_EXTRA_FLAGS}
make
sudo make install
```

编译 Nginx 之前，可以执行 `nginx -V` 看一下当前的 Nginx 的编译参数，可以把这些编译参数加到 `./configure` 这一条命令的参数里

eg:

```bash
sudo ./configure --add-module=../ngx_pagespeed-latest-stable --with-debug --with-pcre-jit --with-http_ssl_module --with-http_stub_status_module --with-http_realip_module --with-http_auth_request_module  --with-http_gunzip_module --with-http_gzip_static_module   --with-http_sub_module  --with-threads --with-http_v2_module --with-openssl=../openssl-1.0.2l
```

### 一些经验

- 我是推荐使用 Automated Installer 安装的，Nginx 和 ngx_pagespeed 都会下载到 `$HOME` 下，Nginx 会安装到 `/usr/local/nginx/`，之后如果有缺少的可以再进行编译安装，然后从 `objs/nginx` 替换 `sbin` 中的 `nginx`
- 编译 ssl 模块参见我的其他文章

## 编写 Nginx 控制脚本

> [Debian/Ubuntu Nginx init Script (opt) &raquo; KBeezie](http://kbeezie.com/debian-ubuntu-nginx-init-script/)

上一步新编译的 Nginx 安装在 `/usr/local/nginx/`

```bash
sudo vim /etc/init.d/nginx
```

写入下面的代码：

```bash
#! /bin/sh

### BEGIN INIT INFO
# Provides:          nginx
# Required-Start:    $all
# Required-Stop:     $all
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: starts the nginx web server
# Description:       starts nginx using start-stop-daemon
### END INIT INFO

PATH=/usr/local/nginx:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
DAEMON=/usr/local/nginx/sbin/nginx
NAME=nginx
DESC=nginx

test -x $DAEMON || exit 0

# Include nginx defaults if available
if [ -f /etc/default/nginx ] ; then
        . /etc/default/nginx
fi

set -e

case "$1" in
  start)
        echo -n "Starting $DESC: "
        start-stop-daemon --start --quiet --pidfile /usr/local/nginx/logs/$NAME.pid \
                --exec $DAEMON -- $DAEMON_OPTS
        echo "$NAME."
        ;;
  stop)
        echo -n "Stopping $DESC: "
        start-stop-daemon --stop --quiet --pidfile /usr/local/nginx/logs/$NAME.pid \
                --exec $DAEMON
        echo "$NAME."
        ;;
  restart|force-reload)
        echo -n "Restarting $DESC: "
        start-stop-daemon --stop --quiet --pidfile \
                /usr/local/nginx/logs/$NAME.pid --exec $DAEMON
        sleep 1
        start-stop-daemon --start --quiet --pidfile \
                /usr/local/nginx/logs/$NAME.pid --exec $DAEMON -- $DAEMON_OPTS
        echo "$NAME."
        ;;
  reload)
      echo -n "Reloading $DESC configuration: "
      start-stop-daemon --stop --signal HUP --quiet --pidfile /usr/local/nginx/logs/$NAME.pid \
          --exec $DAEMON
      echo "$NAME."
      ;;
  *)
        N=/etc/init.d/$NAME
        echo "Usage: $N {start|stop|restart|force-reload}" >&2
        exit 1
        ;;
esac

exit 0
```

赋予执行

```
sudo chmod +x /etc/init.d/nginx
```

### 一些经验

这里我原来已经安装了 Nginx，不想修改原来的配置，只是先调试下新的，所以这一步你可以先停用现有的 Nginx，然后：

```bash
# 换个别的命
sudo vim /etc/init.d/nginxnew
```

再贴入上面的代码，下一步的管理同样替换为 `/etc/init.d/nginxnew`

## 管理 Nginx

```bash
# for start use:
sudo /etc/init.d/nginx start

# for stop:
sudo /etc/init.d/nginx stop

# for restart:
sudo /etc/init.d/nginx restart

# for reload:
sudo /etc/init.d/nginx reload
```

## 启用 pagespeed 与检测

### 检测 Nginx 启用前状态

```bash
curl -I -p http://localhost
```

```
HTTP/1.1 200 OK
Server: nginx/1.13.0
Date: Fri, 12 May 2017 01:48:09 GMT
Content-Type: text/html
Content-Length: 612
Last-Modified: Fri, 12 May 2017 01:38:37 GMT
Connection: keep-alive
ETag: "5915121d-264"
Accept-Ranges: bytes
```

### 启用 pagespeed 模块

```
sudo vim /usr/local/nginx/conf/nginx.conf
```

在 Nginx 配置文件的每个需要的 `server` 块中添加：

```vim
pagespeed on;

# Needs to exist and be writable by nginx.  Use tmpfs for best performance.
pagespeed FileCachePath /var/ngx_pagespeed_cache;

# Ensure requests for pagespeed optimized resources go to the pagespeed handler
# and no extraneous headers get set.
location ~ "\.pagespeed\.([a-z]\.)?[a-z]{2}\.[^.]{10}\.[^.]+" {
  add_header "" "";
}
location ~ "^/pagespeed_static/" { }
location ~ "^/ngx_pagespeed_beacon$" { }
```

Save and restart Nginx. reload 可能不生效

### 检测 Nginx 启用后状态

```bash
curl -I -p http://localhost
```

```
HTTP/1.1 200 OK
Server: nginx/1.13.0
Content-Type: text/html
Connection: keep-alive
Vary: Accept-Encoding
Date: Fri, 12 May 2017 01:59:03 GMT
X-Page-Speed: Powered By ngx_pagespeed
Cache-Control: max-age=0, no-cache
```

It’s ALL. No need scripts any more.

## pagespeed 配置

### 配置实例

[PageSpeed Documentation](https://modpagespeed.com/doc/) 给出的文档非常详细

Filters 的配置是最重要的。PageSpeed 提供三个“level”来简化配置：PassThrough，CoreFilters 和 OptimizeForBandwidth。CoreFilters 集合包含了 PageSpeed 团队认为对大多数网站都是安全的过滤器。OptimizeForBandwidth 设置提供了更强的安全保障，适合作为不知道 PageSpeed 的站点使用的默认设置。

基于 CoreFilters 配置就可以。

```
pagespeed on;
pagespeed FileCachePath /var/ngx_pagespeed_cache;

# setting
pagespeed XHeaderValue "Powered By ngx_pagespeed";
pagespeed SupportNoScriptEnabled false;

# filters
pagespeed RewriteLevel CoreFilters;
pagespeed EnableFilters remove_comments,collapse_whitespace;

# admin
location /ngx_pagespeed_statistics { allow 127.0.0.1; deny all;  }
location /ngx_pagespeed_global_statistics { allow 127.0.0.1; deny all;  }
location /ngx_pagespeed_message { allow 127.0.0.1; deny all;  }
location /pagespeed_console { allow 127.0.0.1; deny all;  }
location ~ ^/pagespeed_admin { allow 127.0.0.1; deny all;  }
location ~ ^/pagespeed_global_admin { allow 127.0.0.1; deny all;  }

location ~ "\.pagespeed\.([a-z]\.)?[a-z]{2}\.[^.]{10}\.[^.]+" {
	add_header "" "";
}
location ~ "^/pagespeed_static/" { }
location ~ "^/ngx_pagespeed_beacon$" { }

pagespeed Statistics on;
pagespeed StatisticsLogging off;
pagespeed LogDir /var/log/pagespeed;
pagespeed AdminPath /pagespeed_admin;

# Configuring the File Cache
pagespeed FileCacheSizeKb            1024000; # 1GB
pagespeed FileCacheCleanIntervalMs   3600000; # 1h
pagespeed FileCacheInodeLimit        500000;

# Configuring the in-memory LRU Cache
pagespeed LRUCacheKbPerProcess     1024;
pagespeed LRUCacheByteLimit        16384;

pagespeed HttpCacheCompressionLevel 3;
pagespeed EnableCachePurge on;
```

### 刷新缓存

> [Flushing PageSpeed Server-Side Cache](https://modpagespeed.com/doc/system#flush_cache)

```bash
curl 'http://localhost/pagespeed_admin/cache?purge=*'
```

## 一些经验

- 高流量网站谨慎使用，pagespeed 对内存和 CPU 的占用极大
- 通读一遍官方的 [FAQ](https://modpagespeed.com/doc/faq)，很多情况里面都有说明
- 对于 Nginx 的 HTTPS HTTP/2 安装配置可以参看我的其他文章

> References:
>
> - [Levantado/ngx_pagespeed-install-script: Install nginx and pagespeed latest version on clean Ubuntu 14.04, 15.04, 16.04](https://github.com/Levantado/ngx_pagespeed-install-script)
> - [给后台人员的前端优化 &middot; Atom](https://fixatom.com/pagespeed-for-backend-developer/)
> - [Nginx ngx_pagespeed nginx 前端优化模块编译 - Phodal | Phodal - A Growth Engineer](https://www.phodal.com/blog/nginx-with-ngx-pagespeed-module-improve-website-cache/)
