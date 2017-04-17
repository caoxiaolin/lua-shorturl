# lua-sorturl
SortURL Service Written by LUA

Using nginx + lua + redis + mysql, redis as a cache, mysql persistent data

* e.g.

rong@debian:~$ curl -d "url=http://www.taobao.com" "http://www.shorturl.com/"

http://www.shorturl.com/1


rong@debian:~$ curl "http://www.shorturl.com/1"

http://www.taobao.com
