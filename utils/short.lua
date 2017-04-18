local _M = {}

local utils = require "utils.utils"
local redis = require "utils.redis"
local db = require "utils.db"
local config = require "config.config"

function _M:setUrl(url)
    local shortUrl = getShortUrl(url)
    redis:set("su_" .. shortUrl, url)
    ngx.say(config.domain .. shortUrl)
end

function _M:getUrl(uri)
    if uri == "/" then
        return 0
    end
    local uri = string.sub(uri, 2)
    local oriUrl = redis:get("su_" .. uri)
    if oriUrl == nil then
        oriUrl = getOriUrl(uri)
    end
    ngx.say(oriUrl)
end

function getShortUrl(url)
    local res, err = db:insert(url)
    return utils:convert10To62(res)
end

function getOriUrl(uri)
    local id = utils:convert62To10(uri)
    local res, err = db:query(id)
    return res
end

return _M
