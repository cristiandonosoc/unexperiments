_northId = "north"
_southId = "south"

GameEngine = Class{
  init = function(self)
    self.field = Field()


    self.players = {}
    self.players[_northId] = Player()
    self.players[_southId] = Player()

    self.southField = Field():setName("SOUTH BASE")
    self.northField = Field():setName("NORTH BASE")
    self.lane = Lane(self.southField, self.northField)
  end
}

function GameEngine:testMinions()

  self.lane.fields[2]:addMinion(Minion(2, 4, "NORTEÑO"), _northId)
  self.lane.fields[2]:addMinion(Minion(1, 7, "SUREÑO"), _southId)
end

function GameEngine:print()
  print("--------------------------------")
  print("*** STATUS ***")
  self.field:print()
end

function GameEngine:battle()
  print("*** FASE DE ATAQUE ***")
  self.field:battle()
  self.field:postBattle()
end

function GameEngine:draw()
  self.lane:draw()
end
