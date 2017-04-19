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
    local oriUrl = redis:get("su_" .. uri)
    if oriUrl == nil then
        oriUrl = getOriUrl(uri)
    end
    if oriUrl ~= false then
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

function getOriUrl(uri)
    local id = utils:convert62To10(uri)
    local res, err = db:query(id)
    return res
end

return _M
