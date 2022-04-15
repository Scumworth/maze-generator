require 'grid'
require 'binary_tree'
require 'utils'

local num_rows = tonumber(arg[1]) or 25
local num_columns = tonumber(arg[2]) or 25
local grid = Grid:new(num_rows, num_columns)
local cell_size = tonumber(arg[3]) or 20
local binary_grid = BinaryTree:apply(grid)
line_coords = {}
--print(Utils:dump(binary_grid.grid))
for _, column in ipairs(binary_grid.grid) do
    for _, cell in ipairs(column) do
        -- calculate positions of four corners
        local x1 = cell.column * cell_size
        local y1 = cell.row * cell_size
        local x2 = (cell.column + 1) * cell_size
        local y2 = (cell.row + 1) * cell_size

        -- check whether to draw cell walls
        -- note: cells will always draw their own southern and eastern wall
        -- which will account for the northern and western walls of neighbors

        -- north wall
        if (cell.north == nil) then
            table.insert(line_coords, {x1, y1, x2, y1})
        end
        -- west wall
        if (cell.west == nil) then
            table.insert(line_coords, {x1, y1, x1, y2})
        end
        -- east wall
        if not cell:is_linked(cell.east) then
            table.insert(line_coords, {x2, y1, x2, y2})
        end
        -- south wall
        if not cell:is_linked(cell.south) then
            table.insert(line_coords, {x1, y2, x2, y2})
        end
    end
end

num_walls = #line_coords



-- print grid to terminal
print(binary_grid)

