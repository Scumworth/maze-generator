require 'grid'
require 'binary_tree'
require 'utils'

local grid = Grid:new(5, 5)
grid = BinaryTree:apply(grid)
print(grid)


