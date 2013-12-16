-- WE IMPORT THE HELPER LIBRARIES
Vector = require "lib.hump.vector"
Camera = require "lib.hump.camera"
Timer = require "lib.hump.timer"
Class = require "lib.hump.class"
Gamestate = require "lib.hump.gamestate"
Shapes = require "lib.hardon_collider.shapes"
ATL = {}
ATL.Loader = require "lib.advanced_tile_loader.Loader"
ATL.Loader.path = "maps/"
Grid = require "lib.advanced_tile_loader.Grid"

-- EXTENSIONS
require "lib.custom.Grid"

-- GENERAL INPUT
require "input"

-- CUSTOM CLASSES
Gamegrid = require "lib.custom.Gamegrid"
require "classes.gameEngine"
require "classes.field"
require "classes.minion"

-- HELPERS
require "lib.custom.helper"

_mainState = require("states/mainState")

function love.load()
  _camera = Camera(0,0,1,0)

  Gamestate.registerEvents()
  Gamestate.switch(_mainState)

  gameEngine = GameEngine()
  gameEngine:testMinions()
end

function love.update(dt)
  Timer.update(dt)
  Gamestate.updateInput(dt)

  gameEngine:print()
  io.read()
  gameEngine:battle()
end

function love.draw()

end