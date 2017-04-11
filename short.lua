local _M = {}

local redis = require "redis"

function _M.setUrl(self, url)
    local shortUrl = utils:getShortUrl(url)
    redis:set("su_" .. shortUrl, url)
    ngx.say(shortUrl) 
end

function _M.getUrl(self, uri)
    local uri = string.sub(uri, 2)
    local longUrl = redis:get("su_" .. uri)
    if longUrl == nil then
        -- TODO get from mysql
    end
    ngx.say(uri)
    -- return uri
end

return _M
