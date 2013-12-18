
local Grid = require "lib.advanced_tile_loader.Grid"

local Gamegrid = {}
Gamegrid.__index = function(t, i) return Gamegrid[i] or Grid[i] end
function Gamegrid:new(tileLayer, tileWidth, tileHeight)
  local grid = {}
  grid.changed = true
  grid.cells = {}

  grid = setmetatable(grid, Gamegrid)
  grid.collider = Collider(tileWidth, 
    Player.callbackColide,
    Player.callbackStop)
  for x, y, tile in tileLayer:iterate() do
    local data = {
      x = x,
      y = y
    }
    data.properties = {}
    for key, prop in pairs(tile.properties) do
      data.properties[key] = prop
    end
    data.tile = tile
    data.visible = false
    grid.cells[x] = grid.cells[x] or {}
    grid.cells[x][y] = data

    local _x = x*tileWidth
    local _y = y*tileHeight
    local rectangle = Shapes.newPolygonShape(
      _x, _y,
      _x + tileWidth, _y,
      _x + tileWidth, _y + tileHeight,
      _x, _y + tileHeight)
    rectangle.position = Vector(x, y)
    grid.collider:addShape(rectangle)
    grid.collider:setPassive(rectangle)

  end
  return grid
end


setmetatable(Gamegrid, {__call = Gamegrid.new})
Gamegrid.__call = Grid.__call

return Gamegrid
