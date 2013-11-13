Vector = require "lib.hump.vector"
Camera = require "lib.hump.camera"
Timer = require "lib.hump.timer"
Class = require "lib.hump.class"
Gamestate = require "lib.hump.gamestate"
Shapes = require "lib.hardon_collider.shapes"

require "input"

-- STATES
officeState = require "states.officeState"

function love.load()
  _window = {
    width = love.graphics.getWidth(),
    height = love.graphics.getHeight()
  }
  Gamestate.registerEvents()
  Gamestate.switch(officeState)
end

function love.update(dt)
  Timer.update(dt)
  Gamestate.updateInput(dt)


end

function love.draw()
end
