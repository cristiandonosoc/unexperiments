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
require "lib.vardump"
Anim8 = require "lib.anim8"

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
_spriteSheets = {}
_states = {}

local function loadSprites()
  -- SPRITES
  _sprites.field = love.graphics.newImage("images/field.jpg")
  _sprites.warrior = love.graphics.newImage("images/warrior.png")
  _sprites.yellow_circle = love.graphics.newImage("images/yellow_circle.png")
  -- SPRITESHEETS
  local ibh = love.graphics.newImage("images/spritesheets/ice_blaster_hit.png")
  _spriteSheets.ice_blast = {
    image = ibh,
    grid = Anim8.newGrid(200, 200, ibh:getWidth(), ibh:getHeight())
  }

end

local function loadStates()
  _states.main = require("states/mainState")
end

function love.load()
  loadStates()
  loadSprites()

  _camera = Camera(100,400,2,0)

  Gamestate.registerEvents()
  Gamestate.switch(_states.main)

  _gameEngine = GameEngine()
  _gameEngine:testMinions()
end

function love.update(dt)
  Timer.update(dt)
  Gamestate.updateInput(dt)
  _gameEngine:update(dt)

  --[[
  io.read()
  _gameEngine:battle()
  ]]--
end

function love.draw()

end
