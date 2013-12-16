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
  init = function(self, hp, damage, name)
    self.hp = hp
    self.damage = damage
    self.name = name
    self.id = generateMinionId()
    self.renderer = MinionRenderer(self)
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
  local hg = _spriteSheets.ice_blast
  self.renderer.hit_damage = damage
  self.renderer.hit_animation = Anim8.newAnimation(hg.grid('1-5',1,'1-5',2), 0.1,
    function() self.renderer:removeHitAnimation(damage) end)

  print(self.name .. ": RECEIVES " .. damage .. " DAMAGE.")
end

function Minion:receiveDamage(damage)
  self.hp = self.hp - damage
end

function Minion:checkLife()
  if(self.hp <= 0) then
    self.party:removeMinion(self)
    print(self.name .. " DIES!")
  end
end

function Minion:update(dt)
  self.renderer:update(dt)
end

function Minion:draw()
  self.renderer:draw()
end

-----------------------------------------------------------------------
-- RENDERER
-----------------------------------------------------------------------

MinionRenderer = Class{
  init = function(self, minion, pos)
    self.minion = minion
    self.pos = pos
  end
}

-- GLOBAL ATTR
MinionRenderer.width = 40
MinionRenderer.height = 40
MinionRenderer.circleWidth = 15
MinionRenderer.circleHeight = 15
MinionRenderer.circleOffset = Vector(3, 12)

function MinionRenderer:setPos(pos)
  self.pos = pos
  return self
end

function MinionRenderer:update(dt)
  if self.hit_animation then
    self.hit_animation:update(dt)
  end
end

function MinionRenderer:draw()
  local s = _sprites.warrior
  local yc = _sprites.yellow_circle
  love.graphics.draw(s,
    self.pos.x, self.pos.y, 0,
    MinionRenderer.width / s:getWidth(), MinionRenderer.height / s:getHeight())
  local ycWidth = MinionRenderer.circleWidth
  local ycHeigth = MinionRenderer.circleHeight
  local cOffset = MinionRenderer.circleOffset

  -- HP CIRCLE
  love.graphics.draw(yc,
    self.pos.x - cOffset.x,
    self.pos.y + MinionRenderer.height - cOffset.y,
    0, ycWidth / yc:getWidth(), ycHeigth / yc:getHeight())

  -- DAMAGE CIRCLE
  love.graphics.draw(yc,
    self.pos.x + MinionRenderer.width - ycWidth,
    self.pos.y + MinionRenderer.height - cOffset.y,
    0, ycWidth / yc:getWidth(), ycHeigth / yc:getHeight())

  love.graphics.setColor(Colors.black)
  love.graphics.print(self.minion.hp,
    self.pos.x,
    self.pos.y + MinionRenderer.height - cOffset.y)

  love.graphics.print(self.minion.damage,
    self.pos.x + MinionRenderer.width - ycWidth + cOffset.x,
    self.pos.y + MinionRenderer.height - cOffset.y)

  love.graphics.setColor(Colors.white)
  if self.hit_animation then
    local hg = _spriteSheets.ice_blast
    self.hit_animation:draw(hg.image, 
      self.pos.x, self.pos.y, 0,
      MinionRenderer.width / 200, MinionRenderer.height / 200)
    if self.hit_animation.position > 3 then
      love.graphics.setColor(Colors.red)
      love.graphics.print(self.hit_damage,
        self.pos.x + MinionRenderer.width / 4,
        self.pos.y + MinionRenderer.height / 4,
        0, 2, 2)
      love.graphics.setColor(Colors.white)
    end
  end
end

function MinionRenderer:removeHitAnimation(damage)
  self.hit_animation = nil
  self.hit_damage = nil
  self.minion:receiveDamage(damage)
end
