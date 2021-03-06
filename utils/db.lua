local mysql = require("resty.mysql")
local config = require("config.config")
local _M = {}

function _M:exec(sql)
    local db, err = mysql:new()
    if not db then
        ngx.log(ngx.ERR, "failed to instantiate mysql: ", err)
        return
    end

    -- default write
    local mysql_config = config.mysql.conn_w

    -- read-write separation
    if string.upper(string.sub(sql, 1, 6)) == "SELECT" then
        -- random a machine
        local m = math.random(table.getn(config.mysql.conn_r))
        mysql_config = config.mysql.conn_r[m]
    end
   
    db:set_timeout(mysql_config.timeout)

    local ok, err, errcode, sqlstate = db:connect(mysql_config)

    if not ok then
        ngx.log(ngx.ERR, "failed to connect mysql: ", err, ": ", errcode, " ", sqlstate)
        return
    end

    local res, err, errno, sqlstate = db:query(sql)
    if not res then
        ngx.log(ngx.ERR, "mysql exec failed: ", err, ": ", errno, ": ", sqlstate, ".")
    end

    local ok, err = db:set_keepalive(config.mysql.pool.max_idle_timeout, config.mysql.pool.pool_size)
    if not ok then
        ngx.log(ngx.ERR, "failed to set mysql keepalive: ", err)
    end

    return res, err, errno, sqlstate
end

-- query
function _M:query(id)
    local sql = "SELECT * FROM `urls` WHERE id = " .. ngx.quote_sql_str(id)
    local res, err, errno, sqlstate = self:exec(sql)
    if res and res[1] and not err then
        return res[1]["url"], err
    else
        return false, err
    end
end

-- insert
function _M:insert(url)
    local sql = "INSERT INTO `urls` (url) VALUES (" .. ngx.quote_sql_str(url) .. ")"
    local res, err, errno, sqlstate = self:exec(sql)
    if res and not err then
        return  res.insert_id, err
    else
        return res, err
    end
end

-- update
function _M:update(id)
    local sql = "UPDATE `urls` SET last_access_time = '" .. os.date("%Y-%m-%d %X") .. "' WHERE id = " .. ngx.quote_sql_str(id)
    local res, err, errno, sqlstate = self:exec(sql)
    if not err then
        return true
    else
        return false
    end
end
return _M
