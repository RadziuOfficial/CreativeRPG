addCommandHandler("derby", function(el,md)
	if getElementData(el, "duty") == 4 or getElementData(el, "duty") == 3 or getElementData(el, "duty") == 2 then local gracz = el
    if isPedInVehicle(el) then gracz = getPedOccupiedVehicle(el) end
    setElementPosition(gracz, -3657.45,471.10,54.40)
	setElementInterior(gracz,0)
	setElementDimension(gracz,0)
    outputChatBox("[#FF0000Admin-TP#FFFFFF] Witamy na mapie Derbowej.", el, 255, 255, 255, true)
end
end)