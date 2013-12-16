local function calculateDamage(party, damage)
  local average = damage / table.length(party.minions)
  return math.ceil(average)
end

-- GLOBAL FUNCTION
_minionSeed = 300000
function generateMinionId()
  _minionSeed = _minionSeed + 1
  return _minionSeed
end

Minion = Class{
  init = function(self, damage, hp, name)
    self.hp = hp
    self.damage = damage
    self.name = name
    self.id = generateMinionId()
    self.renderer = MinionRenderer()
  end
}


function Minion:setParty(party)
  self.party = party
end

function Minion:attack()
  local enemyParty = self.party.enemyParty
  local final_damage = calculateDamage(enemyParty, self.damage)
  enemyParty:receiveAttack(final_damage)
end

function Minion:receiveAttack(damage)
  self.hp = self.hp - damage

  print(self.name .. ": RECEIVES " .. damage .. " DAMAGE.")
end

function Minion:checkLife()
  if(self.hp <= 0) then
    self.party:removeMinion(self)
    print(self.name .. "DIES!")
  end
end

function Minion:print()
  print(self.name .. " - DAMAGE: " .. self.damage .. " HP: " .. self.hp)
end

function Minion:draw()
  self.renderer:draw()
end

-----------------------------------------------------------------------
-- RENDERER
-----------------------------------------------------------------------

MinionRenderer = Class{
  init = function(self, pos)
    self.pos = pos
  end
}

-- GLOBAL ATTR
MinionRenderer.width = 40
MinionRenderer.height = 40

function MinionRenderer:setPos(pos)
  self.pos = pos
  return self
end

function MinionRenderer:draw()
  local s = _sprites.warrior
  love.graphics.draw(s,
    self.pos.x, self.pos.y,
    MinionRenderer.width / s:getWidth(), MinionRenderer.height / s:getHeight())
end
