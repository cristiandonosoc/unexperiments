--[[
Beetle Debug Library V 0.0.2
License : Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported
http://creativecommons.org/licenses/by-nc-sa/3.0/
Programmed by substitute541
]]--

beetle = {}

function beetle.load()
	dbg = {}
	dbg.x = 5
	dbg.y = 5
	dbg.names = {}
	dbg.value = {}
	dbg.font = love.graphics.newFont(14)
	dbg.color = {255, 255, 255, 255}
	dbg.show = false
	dbg.key = "d"
end

function beetle.key(key)
	if key == dbg.key and dbg.show then
		beetle.hide()
	elseif key == dbg.key and dbg.show == false then
		beetle.show()
	end
end

function beetle.setKey(key)
	dbg.key = key
end

function beetle.show()
	dbg.show = true
end

function beetle.hide()
	dbg.show = false
end

function beetle.getState()
	return dbg.show
end

function beetle.add(name, contents)
  dbg.names[name] = tostring(name) .. " : "
	dbg.value[name] = tostring(contents)
end

function beetle.remove(name)
	table.removeByKey(dbg.name, name)
	table.removeByKey(dbg.value, name)
end

function beetle.update(name, value)
	dbg.value[name] = tostring(value)
end

function beetle.draw()
	if dbg.show then
		love.graphics.setFont(dbg.font)
		love.graphics.setColor(dbg.color[3], dbg.color[2], dbg.color[1], 255)
		love.graphics.print("Beetle Debug Screen :", dbg.x, dbg.y)
		love.graphics.setColor(dbg.color)
		
    local i = 1
		for n, v in pairs(dbg.names) do
			love.graphics.print(v .. dbg.value[n], dbg.x, dbg.y+17*i)
      i = i + 1
		end
		love.graphics.setColor(255, 255, 255, 255)
	end
end
