Utils = {}

function Utils:dump(i, nest, limit)
    nest = nest or 0
    limit = limit or 3
    nest = nest or 0
    if type(i) == 'table' then
        local s = '{'
        for key, value in pairs(i) do
            if type(key) ~= 'number' then
                key = '"'..key..'"'
            end
            if (nest == limit) and (type(value) == 'table') then
                s = s..'['..key..'] = {NESTED TABLE}, '
            else
                s = s..'['..key..'] = '.. Utils:dump(value, nest+1, limit)..','
            end
        end
        return s .. '}'
    else
        return tostring(i)
    end
end
