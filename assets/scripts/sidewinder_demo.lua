require 'grid'
require 'sidewinder'

local grid = Grid:new(5, 5)
grid = Sidewinder:apply(grid)
print(grid)
