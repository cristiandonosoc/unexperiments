Field = Class{
  init = function(self)
    self.parties = {}
    northParty = {
      minions = {}
    }
    southParty = {
      minions = {}
    }
    northParty.enemyParty = southParty
    southParty.enemyParty = northParty

    self.parties[_northId] = northParty
    self.parties[_southId] = southParty
  end
}

function Field:battle()
  -- NORTH ATTACKS
  for i, minion in pairs(self.parties[_northId].minions) do
    minion:attack(self.parties[_northId].enemyParty)
  end

  -- SOUTH ATTACKS
  for i, minion in pairs(self.parties[_southId].minions) do
    minion:attack(self.parties[_southId].enemyParty)
  end
end

function Field:addMinion(minion, party)
  table.insert(party.minions, minion)
  minion.field = self
end

function Field:removeMinion(minion, party)
  table.remove(party.minions, minion)
end

function Field:receiveAttack(damage, party)
  for i, minion in pairs(party.minions) do
    minion:receiveAttack(damage)
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
