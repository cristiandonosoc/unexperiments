function table.length(t)
  local count = 0
  for i in pairs(t) do count = count + 1 end
  return count
end

function table.removeByKey(t, k)
  local element = t[k]
  t[k] = nil
  return element
end

Colors = {
  black = {0,0,0,255},
  white = {255,255,255,255},
  red = {255,0,0,255},
  green = {0,255,0,255},
  blue = {0,0,255,255}
}
