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
