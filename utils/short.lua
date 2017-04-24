local _M = {}

local utils = require "utils.utils"
local redis = require "utils.redis"
local db = require "utils.db"
local config = require "config.config"

function _M:setUrl(url)
    if not utils:in_table(ngx.var.remote_addr, config.ip_white) then
        ngx.log(ngx.ERR, "Abnormal user try post data to service")
        ngx.exit(403)
    end
    local shortUrl = getShortUrl(url)
    redis:set("su_" .. shortUrl, url)
    ngx.say(config.domain .. shortUrl)
end

function _M:getUrl(uri)
    if uri == "/" then
        return 0
    end
    local uri = string.sub(uri, 2)
    local id = utils:convert62To10(uri)
    local oriUrl = redis:get("su_" .. uri)
    if oriUrl == nil then
        oriUrl = getOriUrl(id)
        -- reset cache
        redis:set("su_" .. uri, oriUrl)
    end
    if oriUrl ~= false then
        -- update last access time
        updateLastAccessTime(id)
        -- debug mode
        if ngx.var.cookie_debug == "1" then
            ngx.say(oriUrl)
        else
            -- default 302
            ngx.redirect(oriUrl)
        end
    else
        ngx.exit(404)
    end
end

function getShortUrl(url)
    local res, err = db:insert(url)
    return utils:convert10To62(res)
end

function getOriUrl(id)
    local res, err = db:query(id)
    return res
end

function updateLastAccessTime(id)
    local res = db:update(id)
    return res
end

return _M
