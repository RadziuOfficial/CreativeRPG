-- SYSTEM INTERIOR WYKONANY PRZEZ RAD3K
-- ZAKAZ USUWANIA AUTORA!

-- BLIPY
createBlip(2019.31, 1007.63, 10.82, 43,2,255,0,0,255,0,100)

-- SYSTEM INTERIOR
wejscie_marker = createMarker (2019.31, 1007.63, 10.82+0.8, "arrow", 1.2, 0, 94, 254, 150)
wyjscie_marker = createMarker (1133.09, -15.83, 1000.68+0.8, "arrow", 1.2, 0, 94, 254, 150)
setElementInterior(wyjscie_marker, 12)

addEventHandler("onMarkerHit", wejscie_marker, function(el, md)
	if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    fadeCamera(el ,false)
	setElementFrozen(el, true)
	setTimer(function ()
    exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Witamy w kasynie!", el)	
    setElementInterior(el, 12)	
    setElementPosition(el, 1132.95, -11.03, 1000.68)
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
    setElementPosition(el, 2029.13, 1008.91, 10.82)
	setElementFrozen(el, false)
	fadeCamera(el, true)
	end, 1500, 1)
end)