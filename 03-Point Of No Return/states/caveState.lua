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

local _gameGrid

function caveState:init()
  _map = ATL.Loader.load("cave.tmx") 
  _map:setDrawRange(0,0,_map.width*_map.tileWidth, _map.height*_map.tileHeight)
  
  _gameGrid = Gamegrid(_map("cave"))

  -- We iterate over the tiles
  for x, y, tile in _map("cave"):iterate() do
    if tile.properties.name then
      _tiles[tile.properties.name] = tile
    end

    if tile.properties.name == "entrance" then
      table.insert(_entrances, {
        x = x,
        y = y,
        tile = tile
      })
    end
  end
end

function caveState:enter(oldState)



  addDwarf(1)
end

function caveState:update(dt)
  _camera:move(_cameraTransform.x, _cameraTransform.y)
  for i, miner in pairs(_miners) do miner:update(dt) end
end

function addDwarf()
  index = math.random(1, table.getn(_entrances))
  table.insert(_miners, Miner(
    Vector.new(_entrances[index].x, _entrances[index].y), _gameGrid)
  )
  Timer.add(_minerSpawn, addDwarf)
end

function caveState:updateInput(dt)
  _cameraTransform.x, _cameraTransform.y = 0, 0 
  if love.keyboard.isDown("w") then _cameraTransform.y = _cameraTransform.y - moveSpeed*dt end
  if love.keyboard.isDown("a") then _cameraTransform.x = _cameraTransform.x - moveSpeed*dt end
  if love.keyboard.isDown("s") then _cameraTransform.y = _cameraTransform.y + moveSpeed*dt end
  if love.keyboard.isDown("d") then _cameraTransform.x = _cameraTransform.x + moveSpeed*dt end
end


function caveState:draw()
  _camera:attach()
  _map:draw()
  for i, miner in pairs(_miners) do miner:draw() end
  drawGrid()
  _camera:detach()
  printData()
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
