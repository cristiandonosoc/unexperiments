_northId = "north"
_southId = "south"

GameEngine = Class{
  init = function(self)
    self.field = Field()
  end
}

function GameEngine:testMinions()

  self.field:addMinion(Minion(2, 4, "NORTEÑO"), self.field.parties[_northId]) 
  self.field:addMinion(Minion(1, 7, "SUREÑO"), self.field.parties[_southId])
end

function GameEngine:print()
  print("--------------------------------")
  print("*** STATUS ***")
  self.field:print()
end

function GameEngine:battle()
  print("*** FASE DE ATAQUE ***")
  self.field:battle()
end
