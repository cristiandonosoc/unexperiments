local fullState = {}

function fullState:init()
  self.camera = Camera(0, 0, _worldScale, 0)
  self.index = 0
end

function fullState:enter(oldstate)
end

function fullState:update(dt)
end

function fullState:draw()
end

return fullState