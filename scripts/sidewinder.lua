Sidewinder = {}

function Sidewinder:apply(grid)
    for _,row in ipairs(grid:each_row()) do
        local run = {}
        for _, cell in ipairs(row) do
            table.insert(run, cell)
            local at_eastern_boundary = (cell.east == nil)
            local at_northern_boundary = (cell.north == nil)
            local should_close = at_eastern_boundary or
                (not at_northern_boundary and math.random(2) == 2)
            if should_close then
                local member_cell = run[math.random(#run)]
                if member_cell.north ~= nil then
                    member_cell:link(member_cell.north)
                end
                run = {}
            else
                cell:link(cell.east)
            end
        end
    end
    return grid
end
