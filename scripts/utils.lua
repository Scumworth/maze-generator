Utils = {}

function Utils:dump(i, nest, limit)
    nest = nest or 0
    limit = limit or 3
    nest = nest or 0
    if type(i) == 'table' then
        local s = '{'
        for key, value in pairs(i) do
            if type(key) == 'string' then
                s = s..'"'..key..'" = '
            elseif type(key) == 'number' then
                s = s..'['..key..'] = '
            elseif type(key) == 'table' then
                s = s..'{table as key}'..' = '
            end
            if (nest == limit) and (type(value) == 'table') then
                if not next(value) then
                    s = s..'['..key..'] = {}, '
                else
                    s = s..'['..key..'] = {NESTED TABLE}, '
                end
            else
                s = s..Utils:dump(value, nest+1, limit)..','
            end
        end
        return s .. '}'
    else
        return tostring(i)
    end
end
