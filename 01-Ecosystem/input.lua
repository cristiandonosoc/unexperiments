--[[
Acá están los funcionamientos generales de input, 
los cuales deben funcionar siempre independiente del estado
donde se esté.
--]]

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end

end

function love.mousereleased(x, y, button)

end

