local _M = {}

local utils = require "utils.utils"
local redis = require "utils.redis"
local config = require "config.config"

function _M:setUrl( url)
    local shortUrl = getShortUrl(url)
    redis:set("su_" .. shortUrl, url)
    ngx.say(config.domain .. shortUrl)
end

function _M:getUrl( uri)
    local uri = string.sub(uri, 2)
    local oriUrl = redis:get("su_" .. uri)
    if oriUrl == nil then
        oriUrl = getOriUrl(uri)
    end
    ngx.say(oriUrl)
end

function getShortUrl(url)
    local n = math.random(1000000, 1000000000000)
    ngx.say(n)
    return utils:convert10To62(n)
end

function getOriUrl(uri)
    return utils:convert62To10(uri)
end

return _M
