Utils = {}

function Utils:dump(i)
    if type(i) == 'table' then
        local s = '{'
        for key, value in pairs(i) do
            if type(key) ~= 'number' then
                key = '"'..key..'"'
            end
            s = s..'['..key..'] = '.. Utils:dump(value)..',\n'
        end
        return s .. '}'
    else
        return tostring(i)
    end
end
