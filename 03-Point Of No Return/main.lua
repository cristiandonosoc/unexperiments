-- WE IMPORT THE HELPER LIBRARIES
Vector = require "lib.hump.vector"
Camera = require "lib.hump.camera"
Timer = require "lib.hump.timer"
Class = require "lib.hump.class"
Gamestate = require "lib.hump.gamestate"
Shapes = require "lib.hardon_collider.shapes"
SpatialHash = require "lib.hardon_collider.spatialhash"
Collider = require "lib.hardon_collider"
ATL = {}
ATL.Loader = require "lib.advanced_tile_loader.Loader"
ATL.Loader.path = "maps/"
Grid = require "lib.advanced_tile_loader.Grid"
require "lib.vardump"

-- EXTENSIONS
require "lib.custom.Grid"
require "lib.custom.helper"

-- WE LOAD THE GAME STATES
townState = require("states/townState")
caveState = require("states/caveState")

-- GENERAL INPUT
require "input"

-- CUSTOM CLASSES
require "classes.miner"
require "classes.player"
Gamegrid = require "lib.custom.Gamegrid"


function love.load()
  _camera = Camera(0,0,1,0)

  --SPRITES
  _minerSprite = love.graphics.newImage("images/miner.png")
  _warriorSprite = love.graphics.newImage("images/warrior.png")
  _medicSprite = love.graphics.newImage("images/medic.png")

  Gamestate.registerEvents()
  Gamestate.switch(caveState)
end

function love.update(dt)
  Timer.update(dt)
  Gamestate.updateInput(dt)

end

function love.draw()

end
