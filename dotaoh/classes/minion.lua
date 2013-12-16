local function calculateDamage(party, damage)
  local average = damage / table.length(party.minions)
  return math.ceil(average)
end

Minion = Class{
  init = function(self, damage, hp, name)
    self.hp = hp
    self.damage = damage
    self.name = name
  end
}

function Minion:setField(field)
  self.field = field
end

function Minion:attack(enemyParty)
  local final_damage = calculateDamage(enemyParty, self.damage)
  self.field:receiveAttack(final_damage, enemyParty)
end

function Minion:receiveAttack(damage)
  self.hp = self.hp - damage

  print(self.name .. ": RECEIVES " .. damage .. " DAMAGE.")
end

function Minion:print()
  print(self.name .. " - DAMAGE: " .. self.damage .. " HP: " .. self.hp)
end
