-- SYSTEM INTERIOR WYKONANY PRZEZ RAD3K
-- ZAKAZ USUWANIA AUTORA!

-- BLIPY
createBlip(2127.53, 2380.12, 10.82,39,2,255,0,0,255,0,100)

-- SYSTEM INTERIOR
wejscie_marker = createMarker (2127.53, 2380.12, 10.82+0.8, "arrow", 1.2, 0, 94, 254, 150)
wyjscie_marker = createMarker (2283.08, -1543.27, 2189.04+0.8, "arrow", 1.2, 0, 94, 254, 150)
setElementInterior(wyjscie_marker, 1)

addEventHandler("onMarkerHit", wejscie_marker, function(el, md)
	if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    fadeCamera(el ,false)
	setElementFrozen(el, true)
	setTimer(function ()
    exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Witamy w przebieralni!", el)
    setElementInterior(el, 1)		
    setElementPosition(el, 2280.04, -1544.78, 2189.04)
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
    setElementPosition(el, 2127.42, 2374.58, 10.82)
	setElementFrozen(el, false)
	fadeCamera(el, true)
	end, 1500, 1)
end)