-- SYSTEM INTERIOR WYKONANY PRZEZ RAD3K
-- ZAKAZ USUWANIA AUTORA!

-- BLIPY
createBlip(1712.95, 912.77, 10.82, 46,2,255,0,0,255,0,100)

-- SYSTEM INTERIOR
wejscie_marker = createMarker (1712.95, 912.77, 10.82+0.8, "arrow", 1.2, 0, 94, 254, 150)
wyjscie_marker = createMarker (2574.91, -1651.69, 114.19+0.8, "arrow", 1.2, 0, 94, 254, 150)
setElementInterior(wyjscie_marker, 1)

addEventHandler("onMarkerHit", wejscie_marker, function(el, md)
	if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    fadeCamera(el ,false)
	setElementFrozen(el, true)
	setTimer(function ()
    exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Witamy w magazynie!", el)	
    setElementInterior(el, 1)	
    setElementPosition(el, 2569.31, -1652.21, 114.19)
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
    setElementPosition(el, 1713.10, 916.15, 10.82)
	setElementFrozen(el, false)
	fadeCamera(el, true)
	end, 1500, 1)
end)