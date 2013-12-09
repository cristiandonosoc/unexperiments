
local Grid = require "lib.advanced_tile_loader.Grid"

local Gamegrid = {}
Gamegrid.__index = function(t, i) return Gamegrid[i] or Grid[i] end
function Gamegrid:new(tileLayer)
  local grid = {}
  grid.cells = {}

  grid = setmetatable(grid, Gamegrid)
  for x, y, tile in tileLayer:iterate() do
    local data = {
      x = x,
      y = y
    }
    for key, prop in pairs(tile.properties) do
      data[key] = prop
    end
    grid.cells[x] = grid.cells[x] or {}
    grid.cells[x][y] = data
  end
  return grid
end

setmetatable(Gamegrid, {__call = Gamegrid.new})
Gamegrid.__call = Grid.__call

return Gamegrid
