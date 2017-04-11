local _M = {}

function _M.get(self, k)
    local res = ngx.location.capture("/_get",{
        args = {key = k}
    })
    return res.body
end

function _M.set(self, k, v)
    local res = ngx.location.capture("/_set",{
            args = {key = k, val = v}
    })
    return res.body
end

return _M
