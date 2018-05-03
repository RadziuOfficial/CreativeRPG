local marker=createMarker(1022.36829, -1121.42444, 23.87+0.50, "arrow", 1, 255, 255, 0) --wejście
local marker2=createMarker(1022.50214, -1107.84045, 4179.45+0.50, "arrow", 1, 255, 255, 0) --wyjście



addEventHandler("onMarkerHit", marker, function(el,md)
	setElementInterior(el,0)
	setElementDimension(el,0)
	setElementPosition(el,1022.43005, -1104.57019, 4179.45) --tp wejście
end)

addEventHandler("onMarkerHit", marker2, function(el,md)
	setElementInterior(el,0)
	setElementDimension(el,0)
	setElementPosition(el,1019.64526, -1121.00769, 23.87) --tp wyjście
end)

