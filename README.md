# lua-sorturl
SortURL Service Written by LUA

Using nginx + lua + redis + mysql, redis as a cache, mysql persistent data

mysql存储原始url，自增ID转62进制作为短链，redis缓存url，时效性1天，redis连接池提高吞吐。

支持IP白名单，用于生成短链权限控制，debug模式可直接输出url，而不是跳转

# e.g.

生成一个短链，原始链接：http://www.taobao.com

rong@debian:~$ curl -d "url=http://www.taobao.com" "http://www.shorturl.com/"

http://www.shorturl.com/1

打开短链接，直接跳转到原始链接
rong@debian:~$ curl "http://www.shorturl.com/1"

<html>

<head><title>302 Found</title></head>

<body bgcolor="white">

<center><h1>302 Found</h1></center>

<hr><center>nginx</center>

</body>

</html>

debug模式，输出原始链接

rong@debian:~$ curl "http://www.shorturl.com/1" -b "debug=1"

http://www.taobao.com
