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
    self.links[cell] = true
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
    return self.links
end

function Cell:is_linked(cell)
    if self.links[cell] ~= nil then
        return true
    else
        return false
    end
end

function Cell:neighbors()
    local neighbors = {}
    if self.north ~= nil then table.insert(neighbors, self.north) end
    if self.south ~= nil then table.insert(neighbors, self.south) end
    if self.east ~= nil then table.insert(neighbors, self.east) end
    if self.west ~= nil then table.insert(neighbors, self.west) end
    return neighbors
end

function Cell:distances()
    -- TODO
end
