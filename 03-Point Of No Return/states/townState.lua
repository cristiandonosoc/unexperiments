local townState = {}
local _castleSprite

function townState:init()
  _castleSprite = love.graphics.newImage("images/castle.png")
end

function townState:enter(oldState)

end

function townState:update(dt)

end

function townState:draw()
  _camera:attach()
  love.graphics.print("hola", 10, 10)
  love.graphics.draw(
    _castleSprite, 
    -_castleSprite:getWidth()/2, -_castleSprite:getHeight()/2)

  _camera:detach()
end

return townState
