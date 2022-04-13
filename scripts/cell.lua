require 'utils'

Cell = {}

function Cell:new(row, column)
    local t = {}
    t.row = row
    t.column = column
    t.links = {}
    setmetatable(t, self)
    self.__index = self
    return t
end

function Cell:link(cell, bidi)
    if bidi == nil then bidi = true end
    table.insert(self.links, cell)
    if bidi == true then
        cell:link(self, false)
    end
end

function Cell:unlink(cell, bidi)
    bidi = bidi or true
    self.links[cell] = nil
    if bidi == true then
        cell:unlink(self, false)
    end
end

function Cell:links()
    local keyset = {}
    local n = 0
    for k,_ in pairs(self.links) do
        n = n + 1
        keyset[n] = k
    end
    return keyset
end

function Cell:is_linked(cell)
    if self.links ~= nil then
        return true
    else
        return false
    end
end

function Cell:neighbors()
    local neighbors = {}
    -- TODO
    return neighbors
end

function Cell:distances()
    -- TODO
end
