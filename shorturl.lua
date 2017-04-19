local short = require "utils.short"

local method = ngx.req.get_method()

-- http get, return original url
if method == "GET" then
    short:getUrl(ngx.var.uri)
-- http post, create a short url
elseif method == "POST" then
    ngx.req.read_body()
    local url = ngx.req.get_post_args()["url"] or ""
    if url ~= "" then
        short:setUrl(url)
    else
        ngx.say("please post url")
    end
else
    ngx.exit(400)
end
