require "cell"
require "utils"

Grid = {}

function Grid:new(rows, columns)
    local t = {}
    t.rows = rows
    t.columns = columns
    setmetatable(t, self)
    self.__index = self
    t.grid = t:prepare_grid()
    t:configure_cells()
    return t
end

-- void -> {row: {column: cell}}
function Grid:prepare_grid()
    local grid = {}
    for i = 1, self.rows do
        grid[i] = {}
        for j = 1, self.columns do
            grid[i][j] = Cell:new(i, j)
        end
    end
    return grid
end

-- void -> void
function Grid:configure_cells()
    for _,cell in ipairs(self:each_cell()) do
        local row, column = cell.row, cell.column
        cell.north = self:get_cell(row - 1, column)
        cell.south = self:get_cell(row + 1, column)
        cell.west = self:get_cell(row, column - 1)
        cell.east = self:get_cell(row,column + 1)
    end
end

-- (int, int) -> cell?
function Grid:get_cell(row, column)
    if (row > 0 and row <= self.rows) and (column > 0 and column <= self.columns) then
        return self.grid[row][column]
    end
    return nil
end

function Grid:random_cell()
    local row = math.random(#self.rows)
    local column = math.random(#self.columns)
    return self:get_cell(row, column)
end

function Grid:size()
    return self.rows * self.columns
end

function Grid:each_row()
    local rows = {}
    for _, value in pairs(self.grid) do
       table.insert(rows, value)
    end
    return rows
end

function Grid:each_cell()
    local cells = {}
    for _,row in ipairs(self:each_row()) do
        for _,cell in ipairs(row) do
            table.insert(cells, cell)
        end
    end
    return cells
end

function Grid:__tostring()
    local output = "+"..string.rep("---+", self.columns).."\n"
    for _, row in ipairs(self:each_row()) do
        local top = "|"
        local bottom = "+"
        for _,cell in ipairs(row) do
            --if cell == nil then
                --local cell = Cell:new(-1, -1)
            --end
            local body = "   "
            local east_boundary
            if cell:is_linked(cell.east) then
                east_boundary = " "
            else
                east_boundary = "|"
            end
            top = top..body..east_boundary
            local corner = "+"
            local south_boundary
            if cell:is_linked(cell.south) then
                south_boundary = "   "
            else
                south_boundary = "---"
            end
            bottom = bottom..south_boundary..corner
        end
        output = output..top.."\n"
        output = output..bottom.."\n"
    end
    return output
end

