--[[
Autor: Asper
Dla: .newMode
Skrypt: Anty AFK system
Typ: Server
]]

setTimer(function()
	for i,v in ipairs(getElementsByType("player")) do
		if (getPlayerIdleTime(v) > 300000) then
			triggerClientEvent(v, "afk", v)
		if (getPlayerIdleTime(v) > 600000) then
			triggerClientEvent(v, "afk", v)
		if (getPlayerIdleTime(v) > 900000) then
			kickPlayer(v, "Zostałeś wykopany za AFK.")
		end
		end
		end
	end
end, 30000, 0) 
