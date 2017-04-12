lua_package_path "/home/rong/lua/lua-resty-mysql/lib/?.lua;/home/rong/lua/lua-shorturl/?.lua";

upstream redis_pool {
    server 127.0.0.1:6379;
    keepalive 1024;
} 

server {
    listen       80;
    server_name www.shorturl.com;

    location = /_get {
        set_unescape_uri $key $arg_key;
        redis2_query get $key;
        redis2_pass redis_pool;
    }

    location = /_set {
        set_unescape_uri $key $arg_key;
        set_unescape_uri $val $arg_val;
        redis2_query set $key $val;
        redis2_pass redis_pool;
    }

    location ~ / {
        default_type "text/html";
        content_by_lua_file /home/rong/lua/lua-shorturl/shorturl.lua;
    }
}
