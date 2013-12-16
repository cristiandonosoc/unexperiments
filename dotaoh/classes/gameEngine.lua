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

  self.lane.fields[2]:addMinion(Minion(4, 2, "NORTEÑO"), _northId)
  self.lane.fields[2]:addMinion(Minion(4, 2, "NORTEÑO"), _northId)
  self.lane.fields[2]:addMinion(Minion(7, 3, "SUREÑO"), _southId)
end

function GameEngine:fieldFunction(funcName)
  self.lane:fieldFunction(funcName)
end

function GameEngine:update(dt)
  self.lane:update(dt)
end

function GameEngine:draw()
  self.lane:draw()
end
