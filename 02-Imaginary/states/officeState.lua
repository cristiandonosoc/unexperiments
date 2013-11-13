local officeState = {}
officeState.sprites = {}
officeState.


function officeState:init()
    self.camera = Camera(_window.width/2, _window.height/2, 1, 0)
    self.sprites["background"] = love.graphics.newImage("images/office/background.png")
    self.sprites["worker"] = love.graphics.newImage("images/office/worker.png")

end

function officeState:enter(oldState)

end

function officeState:update(dt)

end

function officeState:updateInput(dt)

end

function officeState:draw()
  self.camera:attach()
  love.graphics.draw(self.sprites["background"], 0, 0)
  love.graphics.draw(self.sprites["worker"], 200, 200)
  self.camera:detach()
end

return officeState
