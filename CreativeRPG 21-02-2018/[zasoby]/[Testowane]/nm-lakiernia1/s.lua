--[[
Autor: Asper
Dla: .newMode
Skrypt: Lakiernia
Typ: Server
]]

local marker = createMarker(2064.08, -1831.74, 13.55-1, "cylinder", 4, 255, 255, 255, 0)
createMarker(2064.08, -1831.74, 13.55-4.95, "cylinder", 4, 255, 255, 255)

addEventHandler("onMarkerHit", marker, function(hit)
	if getElementType(hit) ~= "player" then return end
	if not isPedInVehicle(hit) then return end
	local pojazd = getPedOccupiedVehicle(hit)
	local wlasciciel = getElementData(pojazd, "wlasciciel")
	local dbid = getElementData(hit, "dbid")
	if wlasciciel and wlasciciel == dbid then
		triggerClientEvent(hit, "openLakiernia", hit)
	end
end)

addEventHandler("onMarkerLeave", marker, function(hit)
	if getElementType(hit) ~= "player" then return end
	if not isPedInVehicle(hit) then return end
	local pojazd = getPedOccupiedVehicle(hit)
	local wlasciciel = getElementData(pojazd, "wlasciciel")
	local dbid = getElementData(hit, "dbid")
	if wlasciciel and wlasciciel == dbid then
		triggerClientEvent(hit, "closeLakiernia", hit)
	end
end)

addEvent("mPojazd", true)
addEventHandler("mPojazd", root, function(p, r, g, b)
	if not p and not r and not g and not b then return end
	local r1, g1, b1, r2, g2, b2 = getVehicleColor(p, true)
	setVehicleColor(p, r, g, b, r2, g2, b2)
end)

addEvent("mFelgi", true)
addEventHandler("mFelgi", root, function(p, r, g, b)
	if not p and not r and not g and not b then return end
	local r1, g1, b1, r2, g2, b2 = getVehicleColor(p, true)
	setVehicleColor(p, r1, g1, b1, r, g, b)
end)

addEvent("mSwiatla", true)
addEventHandler("mSwiatla", root, function(p, r, g, b)
	if not p and not r and not g and not b then return end
	setVehicleHeadLightColor(p, r, g, b)
end)