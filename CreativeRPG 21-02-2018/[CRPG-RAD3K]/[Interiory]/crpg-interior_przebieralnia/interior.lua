-- SYSTEM INTERIOR WYKONANY PRZEZ RAD3K
-- ZAKAZ USUWANIA AUTORA!

-- BLIPY
createBlip(2101.89, 2257.44, 11.02,45,2,255,0,0,255,0,100)

-- SYSTEM INTERIOR
wejscie_marker = createMarker (2101.89, 2257.44, 11.02+0.8, "arrow", 1.2, 0, 94, 254, 150)
wyjscie_marker = createMarker (203.79, -50.66, 1001.80+0.8, "arrow", 1.2, 0, 94, 254, 150)
setElementInterior(wyjscie_marker, 1)

addEventHandler("onMarkerHit", wejscie_marker, function(el, md)
	if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    fadeCamera(el ,false)
	setElementFrozen(el, true)
	setTimer(function ()
    exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Witamy w przebieralni!", el)
    setElementInterior(el, 1)		
    setElementPosition(el, 203.58, -47.52, 1001.80)
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
    setElementPosition(el, 2104.79, 2257.83, 11.02)
	setElementFrozen(el, false)
	fadeCamera(el, true)
	end, 1500, 1)
end)