--[[
Acá están los funcionamientos generales de input, 
los cuales deben funcionar siempre independiente del estado
donde se esté.
--]]

function love.keypressed(key)
  beetle.key(key)
	if key == "escape" then
		love.event.quit()
	end

  if key == "p" then
    debug.debug()
  end

end

function love.mousereleased(x, y, button)

end

