_colors = {
  white = {255, 255, 255},
  red = {255, 0, 0},
  green = {0, 255, 0},
  blue = {0, 0, 255}
}

function Vector.zero()
  return Vector(0, 0)
end

_constants = {}

local helper = {}

--[[ 
  Retorna el indice del planeta clickeado,
  Si no hace click en un planeta, retorna nulo.
--]]
function helper.planetColision(x, y)
  clickCoord = Vector(cam:worldCoords(x, y))
  for i = 1, planetNumber do
    planet = _planets[i]

    if clickCoord:dist(planet.pos) < planet.radius then
      return i
    end
  end
  return nil
end

function helper.HSVtoRGB(h, s, v)
    if s <= 0 then return v,v,v end
    h, s, v = h/255*6, s/255, v/255
    local c = v*s
    local x = (1-math.abs((h%2)-1))*c
    local m,r,g,b = (v-c), 0,0,0
    if h < 1     then r,g,b = c,x,0
    elseif h < 2 then r,g,b = x,c,0
    elseif h < 3 then r,g,b = 0,c,x
    elseif h < 4 then r,g,b = 0,x,c
    elseif h < 5 then r,g,b = x,0,c
    else              r,g,b = c,0,x
    end return (r+m)*255,(g+m)*255,(b+m)*255
end

return helper