local _M = {}

local config = require "config.config"

function _M:get(k)
    if config.enable_redis == false then
        return nil
    end

    local res = ngx.location.capture("/_get",{
        args = {key = k}
    })

    -- not find
    if res.body == "$-1\r\n" then
        return nil
    else
        -- return redis value
        local _, pos = string.find(res.body, "\r\n")
        return string.sub(res.body, pos+1, string.len(res.body)-2)
    end
end

function _M:set(k, v)
    if config.enable_redis == false then
        return false
    end

    local res = ngx.location.capture("/_set",{
            args = {key = k, val = v}
    })
    if res.body == "+OK\r\n" then
        return true
    else
        return false
    end
end

return _M
