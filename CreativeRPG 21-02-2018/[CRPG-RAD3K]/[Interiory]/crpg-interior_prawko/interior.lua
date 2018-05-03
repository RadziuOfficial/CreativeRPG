-- SYSTEM INTERIOR WYKONANY PRZEZ RAD3K
-- ZAKAZ USUWANIA AUTORA!

-- BLIPY
createBlip(2101.89, 2257.44, 11.02,45,2,255,0,0,255,0,100)

-- SYSTEM INTERIOR
wejscie_marker = createMarker (2315.94, 1801.82, 10.82+0.8, "arrow", 1.2, 0, 94, 254, 150)
wyjscie_marker = createMarker (-2026.90, -103.60, 1035.18+0.8, "arrow", 1.2, 0, 94, 254, 150)
setElementInterior(wyjscie_marker, 3)

addEventHandler("onMarkerHit", wejscie_marker, function(el, md)
	if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    fadeCamera(el ,false)
	setElementFrozen(el, true)
	setTimer(function ()
    exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Witamy w OSK!", el)	
    setElementInterior(el, 3)	
    setElementPosition(el, -2029.78, -106.96, 1035.17)
	setElementFrozen(el, false)
	fadeCamera(el, true)
	end, 1500, 1)
end)

addEventHandler("onMarkerHit", wyjscie_marker, function(el, md)
	if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    fadeCamera(el ,false)
	setElementFrozen(el, true)
	setTimer(function ()
    exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Zapraszamy ponownie!", el)	
	setElementInterior(el, 0)		
    setElementPosition(el, 2315.88, 1796.62, 10.82)
	setElementFrozen(el, false)
	fadeCamera(el, true)
	end, 1500, 1)
end)