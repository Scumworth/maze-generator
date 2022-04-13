BinaryTree = {}

function BinaryTree:apply(grid)
    for _,cell in ipairs(grid:each_cell()) do
        local neighbors = {}
        if cell.north then
            table.insert(neighbors, cell.north)
        end
        if cell.east then
            table.insert(neighbors, cell.east)
        end
        local index = math.random(#neighbors)
        local neighbor = neighbors[index]
        if neighbor then
            cell:link(neighbor)
        end
    end
    return grid
end
