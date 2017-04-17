# lua-sorturl
SortURL Service Written by LUA

Using nginx + lua + redis + mysql, redis as a cache, mysql persistent data

mysql存储原始url，自增ID转62进制作为短链，redis缓存url，时效性1天，redis连接池提高吞吐。

# e.g.

rong@debian:~$ curl -d "url=http://www.taobao.com" "http://www.shorturl.com/"

http://www.shorturl.com/1


rong@debian:~$ curl "http://www.shorturl.com/1"

http://www.taobao.com
