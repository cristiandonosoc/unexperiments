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
require "lib.require.require"

-- EXTENSIONS
require "lib.custom.Grid"

-- GENERAL INPUT
require "input"

-- CUSTOM CLASSES
Gamegrid = require "lib.custom.Gamegrid"
require.tree "classes"

-- HELPERS
require "lib.custom.helper"

_sprites = {}
_states = {}

local function loadSprites()
  _sprites.field = love.graphics.newImage("images/field.jpg")
  _sprites.warrior = love.graphics.newImage("images/warrior.png")
end

local function loadStates()
  _states.main = require("states/mainState")
end

function love.load()
  loadStates()
  loadSprites()

  _camera = Camera(100,400,1,0)

  Gamestate.registerEvents()
  Gamestate.switch(_states.main)

  _gameEngine = GameEngine()
  _gameEngine:testMinions()
end

function love.update(dt)
  Timer.update(dt)
  Gamestate.updateInput(dt)

  --[[
  _gameEngine:print()
  io.read()
  _gameEngine:battle()
  ]]--
end

function love.draw()

end
