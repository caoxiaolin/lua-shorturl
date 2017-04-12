local _M = {}

function _M.get(self, k)
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

function _M.set(self, k, v)
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
