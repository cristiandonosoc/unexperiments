local caveState = {}
local _cameraTransform = Vector(0, 0)
local moveSpeed = 500

local drawGrid 
local printData
local addDwarf


local _entrances = {}
local _miners = {}
local _minerSpawn = 15
_tiles = {}


function caveState:init()
  _map = ATL.Loader.load("cave.tmx") 
  _map:setDrawRange(0,0,_map.width*_map.tileWidth, _map.height*_map.tileHeight)
  
  _gameGrid = Gamegrid(_map("cave"), _map.tileWidth, _map.tileHeight)

  -- We iterate over the tiles
  for x, y, tile in _map("cave"):iterate() do
    local name = tile.properties.name
    _tiles[name] = tile

    if name == "floor" then
      for _x, _y, cell in _gameGrid:rectangle(x-1,y-1,2,2) do
        cell.viewable = true
        if cell.properties.name ~= "floor" then
          cell.wall = true
        end
      end
    end

    if name == "start" then
      _player = Player()
      _player:setPosByGrid(x, y)
    end
  end

end

function caveState:enter(oldState)

end

function caveState:update(dt)
  _camera:move(_cameraTransform.x, _cameraTransform.y)
  for i, miner in pairs(_miners) do miner:update(dt) end

  if _gameGrid.changed then
    for x, y, cell in _gameGrid:iterate() do
      if _gameGrid(x, y).visible then
        _map("cave"):set(x, y, _gameGrid(x, y).tile)
      else
        _map("cave"):set(x, y, _tiles["empty"])
      end
    end
    _gameGrid.changed = false
    _map:forceRedraw()
  end

  _player:update(dt)
  _gameGrid.collider:update(dt)

end

function caveState:updateInput(dt)
  _cameraTransform.x, _cameraTransform.y = 0, 0 
  if love.keyboard.isDown("up") then _cameraTransform.y = _cameraTransform.y - moveSpeed*dt end
  if love.keyboard.isDown("left") then _cameraTransform.x = _cameraTransform.x - moveSpeed*dt end
  if love.keyboard.isDown("down") then _cameraTransform.y = _cameraTransform.y + moveSpeed*dt end
  if love.keyboard.isDown("right") then _cameraTransform.x = _cameraTransform.x + moveSpeed*dt end
  _player:updateInput(dt)
end


function caveState:draw()
  _camera:attach()
  _map:draw()
  for i, miner in pairs(_miners) do miner:draw() end
  _player:draw()
  --drawGrid()
  _camera:detach()
  --printData()
  _player:print()
end

function drawGrid()
  for i = 1, _map.width - 1 do
    love.graphics.line(i*_map.tileWidth,0,i*_map.tileWidth,_map.height*_map.tileHeight)
  end
  for i = 1, _map.height - 1 do
    love.graphics.line(0, i*_map.tileHeight, _map.width*_map.tileWidth, i*_map.tileHeight)
  end
end

function printData()
  for k, v in pairs(_entrances) do
     
    love.graphics.print("INDEX: " .. k .. " X: " .. v.x .." Y: " .. v.y, 10, 10+12*k)  
  end
  love.graphics.print("DWARVES: " .. #_miners, 10, 60)
end

return caveState
