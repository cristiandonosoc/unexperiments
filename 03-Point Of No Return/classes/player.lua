
Player = Class{
  init = function(self)
    self.pos = Vector(0, 0)
    self.tiles = {}
    self.sprite = _minerSprite
    self.offset = Vector(self.sprite:getWidth() / 2, self.sprite:getHeight() / 2)
    self.posTransform = Vector(0, 0)
    self.moveSpeed = 200
    self.shape = _gameGrid.collider:addCircle(self.pos.x, self.pos.y, self.offset.x)
    self.view = 3
   end
}

function Player:setPos(pos)
  self.pos = pos
  self.shape:moveTo(pos:unpack())
  return self
end

function Player:setPosByGrid(x, y)
  self.pos = Vector(
    math.floor(x*_map.tileWidth),
    math.floor(y*_map.tileHeight))
  self.shape:moveTo(self.pos:unpack())
  return self
end

function Player:update(dt)
  self.pos = self.pos + self.posTransform
  self.shape:move(self.posTransform:unpack())
end

function Player:updateInput(dt)
  self.posTransform = Vector(0, 0)
  if love.keyboard.isDown("w") then self.posTransform.y = self.posTransform.y - self.moveSpeed*dt end
  if love.keyboard.isDown("a") then self.posTransform.x = self.posTransform.x - self.moveSpeed*dt end
  if love.keyboard.isDown("s") then self.posTransform.y = self.posTransform.y + self.moveSpeed*dt end
  if love.keyboard.isDown("d") then self.posTransform.x = self.posTransform.x + self.moveSpeed*dt end
end

function Player:draw()
  love.graphics.draw(
    self.sprite,
    self.pos.x - self.sprite:getWidth() / 2, self.pos.y - self.sprite:getHeight() / 2)
end

function Player:print()
  local count = 0
  for i, tile in pairs(self.tiles) do
    love.graphics.print(tile.x.." "..tile.y,
      10, 100+20*count)
    count = count + 1
  end
end

function Player.callbackColide(dt, shape_one, shape_two, dx, dy)
  local cell
  if shape_one == _player.shape then 
    cell = shape_two
  else
    cell = shape_one
  end
  local x = cell.position.x
  local y = cell.position.y

  if cell.tile.wall then
    _player:setPos(_player.pos + Vector(dx, dy))
  else
    local t = _player.tiles
    local index = x + 100000*y
    if not t[index] then
      t[index] = {x =  x, y = y}
      for _x, _y, tile in _gameGrid:bfs(x, y, _player.view, false, "viewable") do
        if tile.viewable == true then
          tile.visible = true
        end
      end
      _gameGrid.changed = true
    end
  end

end

function Player.callbackStop(dt, shape_one, shape_two)
  local cell
  if shape_one == _player.shape then
    cell = shape_two
  else
    cell = shape_one
  end
  local x = cell.position.x
  local y = cell.position.y
  local t = _player.tiles
  local index = x + 100000*y
  t[index] = nil
  for _x, _y, tile in _gameGrid:bfs(x, y, _player.view) do
    tile.visible = false
  end
  for i, p in  pairs(t) do
    for _x, _y, tile in _gameGrid:bfs(p.x, p.y, _player.view, false, "viewable") do
      if tile.viewable == true then
        tile.visible = true
      end
    end
  end
  _gameGrid.changed = true
end
