local _M = {}

local redis = require "utils.redis"
local config = require "config.config"

function _M.setUrl(self, url)
    local shortUrl = getShortUrl(url)
    redis:set("su_" .. shortUrl, url)
    ngx.say(shortUrl)
end

function _M.getUrl(self, uri)
    local uri = string.sub(uri, 2)
    local oriUrl = redis:get("su_" .. uri)
    if oriUrl == nil then
        oriUrl = getOriUrl(uri)
    end
    ngx.say(oriUrl)
end

function getShortUrl(url)
    return config["domain"] .. "Axi02t"
end

function getOriUrl(uri)
    return "new url"
end

return _M
