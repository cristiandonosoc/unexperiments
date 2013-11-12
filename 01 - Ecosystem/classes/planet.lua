Planet = Class{
  init = function(self, pos, radius, o_radius, o_aspeed, biomass, index)
    self.pos = pos
    self.radius = radius
    self.orbit = {
      radius = o_radius,
      angularSpeed = o_aspeed,
      angle = 0
    }
    self.biomass = biomass
    self.shape = Shapes.newCircleShape(self.pos.x, self.pos.y, radius)
    self.sprite = love.graphics.newImage("images/planet"..index..".png")
    self.scale = radius/((300 -56*2)/2) -- HARDCODED
  end
}

function Planet:update(dt)
  self.orbit.angle = self.orbit.angle + self.orbit.angularSpeed*dt
  self.pos.x = self.orbit.radius*math.cos(math.rad(self.orbit.angle))
  self.pos.y = self.orbit.radius*math.sin(math.rad(self.orbit.angle))
  self.shape:moveTo(self.pos:unpack())
end

function Planet:draw()
  love.graphics.circle("line", 0, 0, self.orbit.radius)

  love.graphics.draw(
    self.sprite, 
    self.pos.x,
    self.pos.y,
    0,
    self.scale,
    self.scale,
    self.sprite:getWidth()/2,
    self.sprite:getHeight()/2
  )
  love.graphics.print(self.biomass, self.pos.x, self.pos.y, 0, 1/_worldScale, 1/_worldScale)
  self.shape:draw("line")
end