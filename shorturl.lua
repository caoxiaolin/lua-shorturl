local short = require "short"

local method = ngx.req.get_method()
if method == "GET" then
    short:getUrl(ngx.var.uri)
elseif method == "POST" then
    ngx.req.read_body()
    local url = ngx.req.get_post_args()["url"] or ""
    short:setUrl(url)
else
    ngx.say("error")
end
