local planetState = {}

function planetState:init()
  self.camera = Camera(0, 0, 0.2, 0)
  self.index = 0
end

function planetState:enter(oldstate, planetIndex, biomass)
  self.index = planetIndex
  self.planet = _planets[planetIndex]
  self.planet.biomass = _planets[planetIndex].biomass + biomass

  _constants.zoom = oldstate.camera.scale
  _constants.posDiff = oldstate.blob.pos - self.planet.pos

  Timer.tween(1.5, _constants, {zoom = self.camera.scale}, "in-out-quad")
  Timer.tween(1, _constants, {posDiff = Vector.zero()}, "in-out-quad")
end

function planetState:update(dt)
  self.camera:lookAt((_planets[self.index].pos + _constants.posDiff):unpack())
  self.camera:zoomTo(_constants.zoom)
end

function planetState:draw()
  love.graphics.print("Biomass: "..self.planet.biomass, 10, 10)

end

return planetState
