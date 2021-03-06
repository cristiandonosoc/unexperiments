local mainState = {}
local _cameraTransform = Vector(0,0)
local moveSpeed = 500

-- LOCAL FUNCTIONS
local drawGrid

function mainState:init()
end

function mainState:enter(oldState)

end

function mainState:update(dt)
 _camera:move(_cameraTransform.x, _cameraTransform.y)
end

function mainState:updateInput(dt)
  _cameraTransform.x, _cameraTransform.y = 0, 0 
  if love.keyboard.isDown("w") then _cameraTransform.y = _cameraTransform.y - moveSpeed*dt end
  if love.keyboard.isDown("a") then _cameraTransform.x = _cameraTransform.x - moveSpeed*dt end
  if love.keyboard.isDown("s") then _cameraTransform.y = _cameraTransform.y + moveSpeed*dt end
  if love.keyboard.isDown("d") then _cameraTransform.x = _cameraTransform.x + moveSpeed*dt end
end

function mainState:draw()
  _camera:attach()
  _gameEngine:draw()
  _camera:detach()
end

function drawGrid()
  for i = 1, _map.width - 1 do
    love.graphics.line(i*_map.tileWidth,0,i*_map.tileWidth,_map.height*_map.tileHeight)
  end
  for i = 1, _map.height - 1 do
    love.graphics.line(0, i*_map.tileHeight, _map.width*_map.tileWidth, i*_map.tileHeight)
  end
end

function mainState:keyreleased(key)
  if key == " " then
    _gameEngine:gameFunction("beginTurn")
    _gameEngine:gameFunction("move", _gameEngine.current_player)
    _gameEngine:gameFunction("battle")
    _gameEngine:gameFunction("postBattle")
    _gameEngine:gameFunction("endTurn")
    _gameEngine:changeCurrentPlayer()
    _gameEngine:gameFunction("print")
  end

end

return mainState


