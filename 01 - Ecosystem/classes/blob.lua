Blob = Class{
  init = function(self, pos, vel, biomass)
    self.pos = pos
    self.vel = vel
    self.biomass = biomass
    self.sprite = _blobSprite
    
    w = _blobSprite:getWidth()/2
    h = _blobSprite:getHeight()/2
    
    --[[
    self.shape = Shapes.newPolugonShape(
      pos - w, pos - h,
      pos + w, pos - h,
      pos + w, pos + h,
      pos - w, pos + h  
    )
    --]]
    self.shape = Shapes.newCircleShape(pos.x, pos.y, w)
  end
}

function Blob:update(dt)
  moveVector = self.vel*dt
  self.pos = self.pos + moveVector
  self.shape:move(moveVector:unpack())

  -- Vemos colisión con planetas
  for i = 1, planetNumber do
    --if self.pos:dist(_planets[i].pos) < _planets[i].radius then
    if self.shape:collidesWith(_planets[i].shape) then
      -- COLISION CON EL PLANETA
      
      Gamestate.switch(planetState, i, 100)


      break
    end
  end
end

function Blob:draw()
  scale = 1
  love.graphics.draw(
    self.sprite, 
    self.pos.x, 
    self.pos.y, 
    0, 
    scale, 
    scale,
    self.sprite:getWidth()/2,
    self.sprite:getHeight()/2)
  self.shape:draw("line")
end