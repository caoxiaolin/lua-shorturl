local _M = {}

local mysql = {}
mysql["host"] = "192.168.41.128"
mysql["port"] = 3550
mysql["user"] = "root"
mysql["pass"] = "123456"

_M["domain"] = "http://www.shorturl.com/"
_M["mysql"]  = mysql

return _M
