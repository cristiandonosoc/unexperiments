Party = Class{
  init = function(self, field, isSouth)
    self.minions = {}
    self.count = 0
    self.field = field
    self.renderer = PartyRenderer(field.renderer.pos, isSouth)
  end
}

function Party:addMinion(minion)
  self.count = self.count + 1
  self.minions[minion.id] = minion
  minion.party = self
  minion.renderer:setPos(self.renderer:getMinionPos(self.count))
end

function Party:removeMinion(minion)
  table.removeByKey(self.minions, minion.id)
  self.count = self.count - 1
end

function Party:receiveAttack(damage)
  for i, minion in pairs(self.minions) do
    minion:receiveAttack(damage)
  end
end

function Party:gameFunction(funcName, attr)
  if self[funcName] then
    self[funcName](self, attr)
  end
  for i, minion in pairs(self.minions) do
    minion:gameFunction(funcName, attr)
  end
end

function Party:update(dt)
  for i, minion in pairs(self.minions) do
    minion:update(dt)
  end
end

function Party:draw()
  for i, minion in pairs(self.minions) do
    minion:draw()
  end
end

-----------------------------------------------------------------------
-- RENDERER
-----------------------------------------------------------------------

PartyRenderer = Class{
  init = function(self, pos, isSouth)
    self.pos = pos
    self.offset = PartyRenderer.offsetSize
    if isSouth then 
      self.offset = (FieldRenderer.height - MinionRenderer.height - PartyRenderer.offsetSize) 
    end
  end
}

-- GLOBAL ATTR
PartyRenderer.offsetSize = 5

function PartyRenderer:setPos(pos)
  self.pos = pos
  return self
end

function PartyRenderer:getMinionPos(count)
  local offset = PartyRenderer.offsetSize
  local pos = Vector(
    offset + (count - 1)*(PartyRenderer.offsetSize + MinionRenderer.width),
    self.pos.y + self.offset)
  return pos
end

function PartyRenderer:draw()
  -- EMPTY BLOCK
end
