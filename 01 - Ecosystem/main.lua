
Vector = require "lib.hump.vector"
Camera = require "lib.hump.camera"
Timer = require "lib.hump.timer"
Class = require "lib.hump.class"
Gamestate = require "lib.hump.gamestate"
Shapes = require "lib.hardon_Collider.shapes"

require "input"
Helper = require "helper"

-- CLASES
require "classes.blob"
require "classes.planet"

travelState = require "states.travelState"
planetState = require "states.planetState"
fullState = require "states.fullState"


-- GAME CONSTANTS
--CONSTANTS
_sunScale = 1
_worldScale = 0.10
worldTranslate = Vector(1600, 1200)
planetNumber = 3

-- HELPER

_window = {
  width = 800,
  height = 600
}

--ORBITS
_oas = {10, 20, 30}
_or = {1000, 1500, 1900}
--PLANET
_planets = {}
_pr = {150, 60, 180}
_b = {100, 330, 220}

function love.load()
  love.graphics.setLineStyle("smooth")
	_sunSprite = love.graphics.newImage("images/sun.png")
  _blobSprite = love.graphics.newImage("images/blob.png")
  _arrowSprite = love.graphics.newImage("images/arrow.png")
  _arrowScale = 0.2

  cam = Camera(0, 0, _worldScale, 0)

  Gamestate.registerEvents()
  Gamestate.switch(travelState, Vector(100,100), 90, 400)
  --Gamestate.switch(planetState, 1, 100)
  --Gamestate.switch(fullState)

  _backgrounds = {
    love.graphics.newImage("images/background0.png")
  }

  -- CREATE PLANETS
  for i = 1, planetNumber do
    _planets[i] = Planet(Vector(0, 0), _pr[i], _or[i], _oas[i], _b[i], i)
  end
end

function love.update(dt)
  Timer.update(dt)
  Gamestate.updateInput(dt)

  -- UPDATE PLANETS
  for i = 1, planetNumber do
    _planets[i]:update(dt)
  end

  x = love.mouse.getX()
  y = love.mouse.getY()
  newX = x/_worldScale-worldTranslate.x
  newY = y/_worldScale-worldTranslate.y
end

function love.draw()
  --DEBUG
  love.graphics.print(x.."  "..y, 10, 10)
  love.graphics.print(newX.."  "..newY, 10, 20)
  love.graphics.draw(_backgrounds[1], -100, -100, 0.09, 1.1, 1.3)

  --cam:attach()
  print(Gamestate.current().camera.scale)
  Gamestate.current().camera:attach()

  -- DRAW PLANETS
  for i = 1, planetNumber do
    _planets[i]:draw()
  end
  love.graphics.draw(_sunSprite, 0, 0, 0, _sunScale, _sunScale, _sunSprite:getWidth()/2, _sunSprite:getHeight()/2)

  --cam:detach()
  Gamestate.current().camera:detach()
end