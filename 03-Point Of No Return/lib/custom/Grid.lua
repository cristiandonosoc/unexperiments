

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


