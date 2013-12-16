Lane = Class{
  init = function(self, southField, northField)
    self.northField = northField
    self.southField = southField


    -- DESIGNATING SOUTH FIELD
    f = {}
    table.insert(f, Field(self.southField):setName("FIELD 1"))
    table.insert(f, Field(f[1]):setName("FIELD 2"))
    table.insert(f, Field(f[2]):setName("FIELD 3"))

    -- DESIGNATING NORTH FIELDS
    f[1]:setNorthField(f[2]).renderer:setPos(Vector(0, 500))
    f[2]:setNorthField(f[3]).renderer:setPos(Vector(0, 350))
    f[3]:setNorthField(self.northField).renderer:setPos(Vector(0, 200))

    self.fields = f
  end
}

function Lane:gameFunction(funcName, attr)
  if self[funcName] then
    self[funcName](self, attr)
  end
  for i, field in pairs(self.fields) do
    field:gameFunction(funcName, attr)
  end
end

function Lane:update(dt)
  for i, field in pairs(self.fields) do
    field:update(dt)
  end
end

function Lane:draw()
  for i, field in pairs(self.fields) do
    field:draw()
  end
end
