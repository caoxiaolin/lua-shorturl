local _M = {}

-- 10 to 62
function _M:convert10To62(num)
    local res = ""
    local ys = 0
    local s = math.abs(num)
    while s > 0 do
        local tmp = math.floor(s/62)
        ys = s - tmp*62
        s = tmp
        res = int2str(ys) .. res
    end
    return res
end

-- 62 to 10
function _M:convert62To10(str)
    local res = 0
    local len = string.len(str)
    for i=1,#str do
        res = res + str2int(string.sub(str,i,i)) * (math.pow(62, (len - i)))
    end
    return res
end

-- int to string
function int2str(i)
    local res = ""
    if i >= 0 and i <= 9 then
        res = tostring(i)
    elseif i >= 10 and i <= 35 then
        res = string.char(i - 10 + string.byte("A"))
    else
        res = string.char(i - 36 + string.byte("a"))
    end
    return res
end

-- string to int
function str2int(s)
    local res = 0
    local i = string.byte(s) 
    if i >= 48 and i <= 57 then
        res = i - 48
    elseif i >= 65 and i <= 90 then
        res = i - 65 + 10
    else
        res = i - 97 + 36
    end
    return res
end

return _M
