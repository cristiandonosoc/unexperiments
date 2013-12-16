Field = Class{
  init = function(self, southField, northField)
    self.renderer = FieldRenderer()
    self.players = {}
    self.parties = {}
    northParty = Party(self, false)
    southParty = Party(self, true)
    northParty.enemyParty = southParty
    southParty.enemyParty = northParty

    self.parties[_northId] = northParty
    self.parties[_southId] = southParty

    self.northField = northField
    self.southField = southField

  end
}

function Field:addPlayer(player, partyId)
  self.players[partyId] = player
  return self
end

function Field:setNorthField(field)
  self.northField = field
  return self
end

function Field:setSouthField(field)
  self.southField = field
  return self
end

function Field:setName(name)
  self.name = name
  return self
end

function Field:battle()
  -- NORTH ATTACKS
  for i, minion in pairs(self.parties[_northId].minions) do
    minion:attack()
  end

  -- SOUTH ATTACKS
  for i, minion in pairs(self.parties[_southId].minions) do
    minion:attack()
  end
end

function Field:postBattle()
  -- NORTH ATTACKS
  for i, minion in pairs(self.parties[_northId].minions) do
    minion:checkLife()
  end

  -- SOUTH ATTACKS
  for i, minion in pairs(self.parties[_southId].minions) do
    minion:checkLife()
  end
end

function Field:addMinion(minion, partyId)
  local party = self.parties[partyId]
  party:addMinion(minion)
end

-- ALL THE MINIONS IN THE FIELD RECEIVE DAMAGE
function Field:receiveAttack(damage)
  for i, party in pairs(self.parties) do
    party:receiveDamage(damage)
  end
end

function Field:print()
  print("PARTY NORTE:")
  for i, minion in pairs(self.parties[_northId].minions) do
    minion:print()
  end
  print("PARTY SUR:")
  for i, minion in pairs(self.parties[_southId].minions) do
    minion:print()
  end
end

function Field:draw()
  self.renderer:draw()
  for i, party in pairs(self.parties) do
    party:draw()
  end
end

-----------------------------------------------------------------------
-- RENDERER
-----------------------------------------------------------------------

FieldRenderer = Class{
  init = function(self, pos)
    self.pos = pos
    self.partyRenderers = {}
  end
}

-- GLOBAL ATTR
FieldRenderer.width = 200
FieldRenderer.height = 120

function FieldRenderer:addPartyRenderer(partyRenderer)
  table.insert(self.partyRenderers, partyRenderer)
end

function FieldRenderer:setPos(pos)
  self.pos = pos
  for i, partyRenderer in pairs(self.partyRenderers) do
    partyRenderer.setPos(pos)
  end
  return self
end

function FieldRenderer:draw()
  local s = _sprites.field
  love.graphics.draw(s,
    self.pos.x, self.pos.y, 0,
    FieldRenderer.width / s:getWidth(), FieldRenderer.height / s:getHeight())
end

