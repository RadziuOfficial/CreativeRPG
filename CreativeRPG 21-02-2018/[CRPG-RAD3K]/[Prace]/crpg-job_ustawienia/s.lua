--[[
Autor: Asper
Nie masz prawa użyć tego kodu bez mojej zgody
]]

addEvent("onPlayerStartJob", true)
addEvent("onPlayerResign", true)
addEvent("onPlayerPayday", true)

function resign(gracz, cmd)
	playerResign(gracz)
end
addCommandHandler("resign", resign)

function playerResign(gracz, window)
	if window then
		triggerClientEvent(gracz, "destroyJobsWindow", gracz)
	end
	local praca = getElementData(gracz, "praca")
	if isPedInVehicle(gracz) then
		exports["crpg_powiadomienia"]:noti("Najpierw musisz opuścić swój pojazd.", gracz)
		return
	end
	if not praca or praca == 0 then
		exports["crpg_powiadomienia"]:noti("Nie możesz się zwolnić, kiedy nigdzie nie pracujesz.", gracz)
		return
	end
	triggerEvent("onPlayerResign", getRootElement(), gracz, praca)
	triggerClientEvent(gracz, "onPlayerResign", gracz, praca)
	setElementData(gracz, "praca", false)
	setElementData(gracz, "pracamoney", 0)
	exports["crpg_powiadomienia"]:noti("Rezygnujesz ze swojej pracy.", gracz)
end
addEvent("playerResign", true)
addEventHandler("playerResign", getRootElement(), playerResign)