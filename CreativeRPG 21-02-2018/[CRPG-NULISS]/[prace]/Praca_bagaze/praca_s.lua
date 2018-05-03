--[[
Autor: Nuliss
]]

local samolot = createVehicle(519, 1693.51, 1580.34, 11.30, 359.8, 360.0, 41.1)
setVehicleLocked(samolot, true)
setElementFrozen(samolot, true)

local marker = createMarker(1715.07, 1616.19, 10.09-1, "cylinder", 1.2, 0, 94, 254, 100)

local napisy = createElement("text")
setElementData(napisy, "text", "Praca dorywcza\nDostarczanie bagażów na lotnisku")
setElementPosition(napisy, 1715.07, 1616.19, 10.09-0.5)

local pojazd = {}

addEventHandler("onMarkerHit", marker, function(hit)
	if getElementType(hit) ~= "player" then return end
	if isPlayerInVehicle(hit) then return end
	pojazd[hit] = createVehicle(485, 1688.26, 1640.31, 10.50, 0.0, 0.0, 180.0)
	exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Udaj się załadować bagaże!", hit)		
	warpPedIntoVehicle(hit, pojazd[hit])
	setVehicleHandling(pojazd[hit], "maxVelocity", 40)
	triggerClientEvent(hit, "startJob:bagaze", resourceRoot)
	attachTrailerToVehicle(pojazd[hit], bagaz[hit])
end)

function removeAll(player)
	if pojazd[player] and isElement(pojazd[player]) then
		destroyElement(pojazd[player])
	end
	triggerClientEvent(player, "stopJob:bagaze", resourceRoot)
    exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Zakończyłeś pracę!", player)		
end

addEventHandler("onVehicleExit", resourceRoot, function(player, seat)
	if seat ~= 0 then return end
	removeAll(player)
end)

addEventHandler("onPlayerWasted", root, function()
	removeAll(source)
end)

addEventHandler("onPlayerQuit", root, function()
	removeAll(source)
end)