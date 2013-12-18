local function newDir()
  math.random(0, 3)
end

local _timeCount = 0
local _threshold = 1.5
local _miningDamage = 10

Miner = Class{
  init = function(self, pos, gameGrid)
    self.grid_pos = pos
    self.tile_pos = Vector(0, 0)
    self.gameGrid = gameGrid
    self.sprite = _minerSprite
  end
}

function Miner:update(dt)
  _timeCount = _timeCount + dt
  if _timeCount > _threshold then
    _timeCount = 0
    for x, y, tile in self.gameGrid:neighbours(self.grid_pos.x, self.grid_pos.y) do
      if not tile.empty then
        tile.properties.hp = tile.properties.hp - _miningDamage
        if tile.properties.hp <= 0 then
          self.gameGrid:set(x, y, _tiles["empty"])
          _map("cave"):set(x, y, _tiles["empty"])
          _map:updateTiles()
        end

        break
      end
    end
  end
end

function Miner:draw()
  love.graphics.draw(
    self.sprite,
    self.grid_pos.x*_map.tileWidth,
    self.grid_pos.y*_map.tileHeight)
end
