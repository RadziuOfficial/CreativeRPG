--[[
Autor: Nuliss
]]

local pkt = {
	{1625.59, 1644.67, 10.82},
	{1597.32, 1644.73, 10.82},
	{1661.76, 1643.77, 10.82},
}

createBlip(1715.05, 1616.30, 10.08,46,2,255,0,0,255,0,100)		
local marker = false
local blip = false
function createBlips()
	local rnd = math.random(1, #pkt)
	marker = createMarker(pkt[rnd][1], pkt[rnd][2], pkt[rnd][3]-1, "checkpoint", 3, 0, 0, 255, 75)
	blip = createBlipAttachedTo(marker, 41)
end

function createBlips1()
	marker2 = createMarker(1694.03, 1589.50, 10.82-1, "cylinder", 5, 255, 0, 0, 75)
	blip2 = createBlipAttachedTo(marker2, 41)
end

function destroyBlips()
	if marker and isElement(marker) then
		destroyElement(marker)
	end
	if blip and isElement(blip) then
		destroyElement(blip)
	end
	if blip2 and isElement(blip2) then
		destroyElement(blip2)
	end
	if marker2 and isElement(marker2) then
		destroyElement(marker2)
	end
end

addEvent("startJob:bagaze", true)
addEventHandler("startJob:bagaze", root, createBlips1)

addEvent("stopJob:bagaze", true)
addEventHandler("stopJob:bagaze", root, destroyBlips)

addEventHandler("onClientMarkerHit", resourceRoot, function(hit)
	if hit ~= localPlayer then return end
	if source ~= marker2 then return end
	local veh = getPedOccupiedVehicle(hit)
	if not veh then return end
	destroyBlips()
	exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Udaj się dostarczyć załadowany bagaż!", hit)		
	createBlips()
end)

addEventHandler("onClientMarkerHit", resourceRoot, function(hit)
	if hit ~= localPlayer then return end
	if source ~= marker then return end
	local veh = getPedOccupiedVehicle(hit)
	if not veh then return end
	local kasa = math.random(35,40)
	if getElementData(hit, "premium") then
		kasa = math.random(35,40)
	end
	local hajs = getElementData(hit, "pieniadze")
	setElementData(hit, "pieniadze", hajs+kasa)
	exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Twoje wynagrodzenie które otrzymujesz to "..kasa.." PLN.", hit)		
	destroyBlips()
	createBlips1()
end)