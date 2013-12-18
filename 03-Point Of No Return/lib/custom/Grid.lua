

---------------------------------------------------------------------------------------------------
-- Iterates over neigbours
function Grid:neighbours(x, y, includeNil)
  local i = -1
  return function()
    i = i + 1
    if i == 0 then
      _x = x-1
      _y = y
      if self(_x, _y) ~= nil or includeNil then return _x, _y, self(_x, _y) end
    end
    if i == 1 then
      _x = x
      _y = y+1
      if self(_x, _y) ~= nil or includeNil then return _x, _y, self(_x, _y) end
    end
    if i == 2 then
      _x = x+1
      _y = y
      if self(_x, _y) ~= nil or includeNil then return _x, _y, self(_x, _y) end
    end
    if i == 3 then
      _x = x
      _y = y-1
      if self(_x, _y) ~= nil or includeNil then return _x, _y, self(_x, _y) end
    end

    return nil
  end
end

-- RETURNS THE FIRST NOT FOUND FUCKER
function Grid:internalBFS(x, y, r, includeNil, viewed, dir)
  -- We see if this node has been entered
  if not viewed[x] then -- The row has not been accesed
    viewed[x] = {}
    viewed[x][y] = true
    if self(x, y) then return x, y, self(x, y) end
    if not self(x, y) and includeNil then
      return x, y, self(x, y)
    end
  end
  if not viewed[x][y] then -- The row has been accesed, but not this tile
    viewed[x][y] = true
    if self(x, y) then return x, y, self(x, y) end
    if not self(x, y) and includeNil then
      return x, y, self(x, y)
    end
  end

  -- We see if we have to iterate
  if r > 0 then
    local newR = r - 1
    local X, Y, TILE

    local _x = x - 1
    local _y = y
    X, Y, TILE = self:internalBFS(_x, _y, newR, includeNil, viewed)
    if X then return X, Y, TILE end

    _x = x
    _y = y + 1
    X, Y, TILE = self:internalBFS(_x, _y, newR, includeNil, viewed)
    if X then return X, Y, TILE end

    _x = x + 1
    _y = y
    X, Y, TILE = self:internalBFS(_x, _y, newR, includeNil, viewed)
    if X then return X, Y, TILE end

    _x = x
    _y = y - 1
    local X, Y, TILE = self:internalBFS(_x, _y, newR, includeNil, viewed)
    if X then return X, Y, TILE end
  end
  return nil
end

function Grid:bfs(x, y, r, includeNil)
  local viewed = {}
  local function bfsFunction()
    local X, Y, TILE = self:internalBFS(x, y, r, includeNil, viewed)
    if X then return X, Y, TILE end
    return nil
  end
  return bfsFunction
end


