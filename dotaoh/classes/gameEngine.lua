_northId = "north"
_southId = "south"
function getOppositeSide(playerId)
  if playerId == _northId then return _southId end
  return _northId
end

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
  self.lane.fields[3]:addMinion(Minion(4, 2, "NORTEÑO"), _northId)

  self.lane.fields[1]:addMinion(Minion(7, 3, "SUREÑO"), _southId)
end

function GameEngine:gameFunction(funcName, attr)
  if self[funcName] then
    self[funcName](self, attr)
  end
  self.lane:gameFunction(funcName, attr)
end

function GameEngine:print()
  print("*********************")
end

function GameEngine:update(dt)
  self.lane:update(dt)
end

function GameEngine:draw()
  self.lane:draw()
end

function GameEngine:changeCurrentPlayer()
  self.current_player = getOppositeSide(self.current_player)
  beetle.update("player", self.current_player)

end
