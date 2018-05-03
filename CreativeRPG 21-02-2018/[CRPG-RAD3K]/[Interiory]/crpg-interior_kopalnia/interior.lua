-- SYSTEM INTERIOR WYKONANY PRZEZ RAD3K
-- ZAKAZ USUWANIA AUTORA!

-- BLIPY
createBlip(-2004.54, -1547.51, 85.99, 46,2,255,0,0,255,0,100)

-- SYSTEM INTERIOR
wejscie_marker = createMarker (-2004.54, -1547.51, 85.99+0.8, "arrow", 1.2, 0, 94, 254, 150)
wyjscie_marker = createMarker (-2091.76, -1524.03, 77.80+0.8, "arrow", 1.2, 0, 94, 254, 150)

addEventHandler("onMarkerHit", wejscie_marker, function(el, md)
	if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    fadeCamera(el ,false)
	setElementFrozen(el, true)
	setTimer(function ()
    exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Witamy w kopalni!", el)	
    setElementPosition(el, -2091.47, -1526.49, 77.80)
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
    setElementPosition(el, -2000.29, -1544.75, 84.59)
	setElementFrozen(el, false)
	fadeCamera(el, true)
	end, 1500, 1)
end)