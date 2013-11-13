local travelState = {}

-- HERE WE LOAD THE FLYING BLOB
function travelState:init()
  self.camera = Camera(0, 0, 1, 0)
end

function travelState:enter(oldState, from, angle, biomass)
  velx = 25*math.cos(math.rad(angle))
  vely = 25*math.sin(math.rad(angle))

  self.blob = Blob(from, Vector(velx, vely), biomass)
end

function travelState:updateControls(dt)

end


function travelState:keypressed(key)

end

function travelState:mousereleased(x, y, button)

end

function travelState:update(dt)
  self.blob:update(dt)
  self.camera:lookAt(self.blob.pos:unpack())
end

function travelState:updateInput(dt)
  acel = 0
  speed = 500
  if love.keyboard.isDown("w") then
    self.blob.vel = acel*self.blob.vel + Vector(0, -speed)
  end
  if love.keyboard.isDown("a") then
    self.blob.vel = acel*self.blob.vel + Vector(-speed, 0)
  end
  if love.keyboard.isDown("s") then
    self.blob.vel = acel*self.blob.vel + Vector(0, speed)
  end
  if love.keyboard.isDown("d") then
    self.blob.vel = acel*self.blob.vel + Vector(speed, 0)
  end

  if love.keyboard.isDown(" ") then
    self.blob.vel = Vector.zero()
  end
end

function travelState:draw()
  self.camera:attach()
  self.blob:draw()

  angles = {}
  distances = {}
  for i = 1, planetNumber do
    planet = _planets[i]
    --love.graphics.line(self.blob.pos.x, self.blob.pos.y, planet.pos.x, planet.pos.y)
    --angles[i] = self.blob.pos:angleTo(planet.pos)
    angles[i] = Vector.zero():angleTo(planet.pos-self.blob.pos)
    distances[i] = self.blob.pos:dist(planet.pos)
  end

  self.camera:detach()

  -- CAMBIAMOS EL COLOR PARA PINTAR LA LINEA
  love.graphics.setColor(_colors.red)

  
  love.graphics.setColor(_colors.white)
  --love.graphics.circle("line", _window.width/2, _window.height/2, _window.height/2)
  for i = 1, planetNumber do
    rad = _window.height/2
    

    distance = distances[i]-_planets[i].radius*2.5
    maxDist = 1500
    if distance > maxDist then distance = maxDist end
    love.graphics.setColor(Helper.HSVtoRGB(math.floor(160*distance/maxDist), 255, 255))
    love.graphics.draw(_arrowSprite,
      _window.width/2 + rad*math.cos(angles[i]),
      _window.height/2 - rad*math.sin(angles[i]),
      -angles[i],
      _arrowScale,
      _arrowScale,
      _arrowSprite:getWidth()/2,
      _arrowSprite:getWidth()/2 
    )
  end

  love.graphics.setColor(_colors.white)

end


return travelState