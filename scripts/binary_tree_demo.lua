require 'grid'
require 'binary_tree'
require 'utils'

local grid = Grid:new(4, 4)
grid = BinaryTree:apply(grid)
print(grid)


