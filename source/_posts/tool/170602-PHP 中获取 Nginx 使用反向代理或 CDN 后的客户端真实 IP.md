---
title: PHP 中获取 Nginx 使用反向代理或 CDN 后的客户端真实 IP
permalink: php-get-real-ip-after-nginx-using-reverse-proxy-or-cdn
date: 2017-06-02 16:00:00
updated: 2018-05-15 14:00:00
comments: true
toc: true
tags:
  - nginx
  - php
categories:
description:
---

获取 Nginx 反向代理后的客户端 IP，基本是按一定顺序检测以下参数中的信息：

- HTTP_CLIENT_IP
- HTTP_X_REAL_FORWARDED_FOR
- HTTP_X_FORWARDED_FOR
- REMOTE_ADDR

## 在未使用 CDN 和反向代理情况下

当业务服务器直接暴露在公网上，并且未使用 CDN 和反向代理服务器时，可以直接使用 `remote_addr`：

```php
$_SERVER['REMOTE_ADDR']
```

这时候 `HTTP_X_FORWARDED_FOR` 和 `HTTP_X_REAL_IP` 都是可以被伪造的，但 `REMOTE_ADDR` 是客户端和服务器的握手 IP，即 client 的出口 IP，伪造不了。

<!-- more -->

## 在使用 CDN 和反向代理情况下

### 铁律

当多层代理或使用 CDN 时，如果代理服务器不把用户的真实 IP 传递下去，那么业务服务器将永远不可能获取到用户的真实 IP。

如果 WEB 服务器上层也是使用 Nginx 做代理或负载均衡，则需要在代理层的 Nginx 配置中明确 XFF 参数，累加传递上一个请求方的 IP 到 header 请求中。以下是代理层的 Nginx 配置参数。

```
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header Host $http_host;
proxy_set_header X-NginX-Proxy true;
```

### 只有一层代理的情况

我们按上面的配置发起一个伪造请求，10.100.11.25 是我电脑的 IP，链路为：

```
10.100.11.25(client)->10.200.21.33(Proxy)->10.200.21.32(Web Server)
```

curl 请求：

```bash
curl http://10.200.21.33:88/test.php -H 'X-Forwarded-For: unkonw, <8.8.8.8> 1.1.1.1' -H 'X-Real-IP: 2.2.2.2'
```

结果为：

```bash
[HTTP_X_FORWARDED_FOR] => unkonw, <8.8.8.8> 1.1.1.1, 10.100.11.25
[REMOTE_ADDR] => 10.200.21.33
[HTTP_X_REAL_IP] => 10.100.11.25
```

我们可以看到，XFF 被附加上了我的 IP，但前面的一系列伪造内容，可以轻易骗过很多规则，而 `HTTP_X_REAL_IP` 则传递了我电脑的 IP。因为在上面的配置中，`X-Real-IP` 已经被设置为握手 IP。

但多层代理之后，以上面的规则，显然 `HTTP_X_REAL_IP` 也不会是真实的用户 IP 了。而 `HTTP_X_FORWARDED_FOR` 则在原有信息（我们伪造的信息）之后附上了握手 IP 一起传递过来了。

### 两层或更多代理的情况

我们这里只测试两层，实际链路为：

```
10.100.11.25(client)->10.200.21.34(Proxy)->10.200.21.33(Proxy)->10.200.21.32(Web Server)
```

curl 请求：

```bash
curl http://10.200.21.34:88/test.php -H 'X-Forwarded-For: unkonw, <8.8.8.8> 1.1.1.1' -H 'X-Real-IP: 2.2.2.2'
```

两层代理的情况下结果为：

```
[HTTP_X_FORWARDED_FOR] => unkonw, <8.8.8.8> 1.1.1.1, 10.100.11.25, 10.200.21.34
[REMOTE_ADDR] => 10.200.21.33
[HTTP_X_REAL_IP] => 10.200.21.34
```

根据上面的情况，怎么挑出真正的用户 IP 呢？设想三种方案：

1、第一层代理将用户的真实 IP 放在 `X-Real-IP` 中传递下去，后面的每一层都使用 `X-Real-IP` 继续往下传递。配置为：

```
proxy_set_header X-Real-IP $remote_addr;    # 针对首层代理，拿到真实IP
proxy_set_header X-Real-IP $http_x_real_ip; # 针对非首层代理，一直传下去
```

2、从首层开始，将用户的真实 IP 放在 X-Forwarded-For 中，而不是累加各层服务器的 IP，但这样也不够合理，因为丢掉了整个链路信息。配置为：

```
proxy_set_header X-Forwarded-For $remote_addr; # 针对首层代理
proxy_set_header X-Forwarded-For $http_x_forwarded_for; # 针对非首层代理
```

3、从 `X-Forwarded-For` 中获取的用户真实 IP，排除掉所有代理 IP，取最后一个符合 IP 规则的，注意不是第一个，因为第一个可能是被伪造的（除非首层代理使用了握手会话 IP 做为值向下传递）。

一般 CDN 都会将用户的真实 IP 在 XFF 中传递下去。我们可以做几个简单的测试就能知道我们该怎么做。

注意：Nginx 配置的这两个变量：

- `$proxy_add_x_forwarded_for` 会累加代理层的 IP 向后传递
- `$http_x_forwarded_for` 仅仅是上层传过来的值

## Nginx realip 模块获取真实 IP

秉承一个原则：_能通过配置让事情变的更简单和通用的事儿，就不要用程序去解决。即环境对程序透明。_ 这当然少不了系统运维人员的辛苦。

如果能在配置中理清，就不必用复杂的程序去解决，因为 Server 上可能有各种应用都要来获取用户 IP，如果规则不统一，结果会不一致。

程序不知道链路到底经过了几层才转到 WEB Server 上，所以让程序去做兼容并不是个好主意。索性就让程序把所有的代理都当成透明的好了。

上面介绍的三种方法中，如果不能保证前面的代理层使用我们指定的规则，这时候怎么办呢？只能使用第三种方法。然后我们将各层代理的 IP 排除在外，就取到了真实的用户 IP。这个可以使用 Nginx 的一个模块儿 [Module ngx_http_realip_module](http://nginx.org/en/docs/http/ngx_http_realip_module.html) 来实现。

原理是从 XFF 中抛弃指定的代理层 IP，那么最后一个符合规则的就是用户 IP。也可以配合第一起方法一起使用。但无论如何，首层代理的规则最重要，直接影响后面的代理层和 WEB Server 的接收结果。

然后在 Nginx 配置中增加以下配置（可以在 http、server 或 location 段中增加）：

```
# set user real ip to remote addr
set_real_ip_from   10.200.21.0/24;
set_real_ip_from   10.100.23.0/24;
real_ip_header     X-Forwarded-For;
real_ip_recursive on;
```

`set_real_ip_from` 后面是可信 IP 规则，可以有多条。如果启用 CDN，知道 CDN 的溯源 IP，也要加进来，除排掉可信的，就是用户的真实 IP，会写入 `remote_addr` 这个变量中。

在 PHP 中可以使用 `$_SERVER['REMOTE_ADDR']` 来获取。而 WEB Server 不使用任何反向代理时，也是取这个值，这就达到了我们之前所说的原则。

`real_ip_recursive` 是递归的去除所配置中的可信 IP。如果只有一层代理，也可以不写这个参数。

## ThinkPHP 中的获取 IP 方法

ThinkPHP 的 function 中提供了一个工具方法，在对获取 IP 地址不严格的情况下，可以启用高级模式

```php
/**
 * 获取客户端IP地址
 * @param integer $type 返回类型 0 返回IP地址 1 返回IPV4地址数字
 * @param boolean $adv 是否进行高级模式获取（有可能被伪装）
 * @return mixed
 */
function get_client_ip($type = 0, $adv = false) {
    $type       =  $type ? 1 : 0;
    static $ip  =   NULL;
    if ($ip !== NULL) return $ip[$type];
    if($adv){
        if (isset($_SERVER['HTTP_X_FORWARDED_FOR'])) {
            $arr    =   explode(',', $_SERVER['HTTP_X_FORWARDED_FOR']);
            $pos    =   array_search('unknown',$arr);
            if(false !== $pos) unset($arr[$pos]);
            $ip     =   trim($arr[0]);
        }elseif (isset($_SERVER['HTTP_CLIENT_IP'])) {
            $ip     =   $_SERVER['HTTP_CLIENT_IP'];
        }elseif (isset($_SERVER['REMOTE_ADDR'])) {
            $ip     =   $_SERVER['REMOTE_ADDR'];
        }
    }elseif (isset($_SERVER['REMOTE_ADDR'])) {
        $ip     =   $_SERVER['REMOTE_ADDR'];
    }
    // IP地址合法验证
    $long = sprintf("%u",ip2long($ip));
    $ip   = $long ? array($ip, $long) : array('0.0.0.0', 0);
    return $ip[$type];
}
```

## Nginx LOG 记录真实 IP

```
log_format porxy '$http_x_forwarded_for - $remote_user [$time_local] '
                 ' "$request"  $status $body_bytes_sent '
                 ' "$http_referer"  "$http_user_agent" ';

access_log /usr/local/nginx/logs/access.log porxy;
```

文章称 `nginx reload` 配置并不生效，需要 `restart`。

> Reference:
>
> - [使用 PHP 获取客户端真实 IP 地址？——不可能！ - 也就这样](http://blog.zhengshuiguang.com/php/php-ip.html)
> - [NGINX 多层转发或使用 CDN 之后如何获取用户真实 IP | Snow Blog](http://www.wkii.org/nginx-cdn-get-user-real-ip.html)
> - [Nginx 日志配置详情解析](https://juejin.im/post/59f94f626fb9a045023af34c)
