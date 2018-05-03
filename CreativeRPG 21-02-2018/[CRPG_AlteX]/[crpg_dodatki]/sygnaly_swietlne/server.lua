--[[
@Autor: krampsi
@Zakaz zmiany autora
@Zakaz wykożystywania kodu bez zgody autora.
--]]


function onPlayerRequestEmerlight(value)
	triggerClientEvent(getRootElement(), "setEmerlights", getRootElement(), getPlayerName(source), value)
end
addEvent("requestEmerlightChangeState", true)
addEventHandler("requestEmerlightChangeState", getRootElement(), onPlayerRequestEmerlight)

--> NotBad <--