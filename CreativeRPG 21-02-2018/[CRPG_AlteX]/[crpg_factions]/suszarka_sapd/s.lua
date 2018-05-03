function isPedAiming(player)
    if isElement(player) then
        if getElementType(player) == "player" or getElementType(player) == "vehicle" then
            if getPedTask(player, "secondary", 0) == "TASK_SIMPLE_USE_GUN" then
                return true
            end
        end
    end
    return false
end

addEvent("onDryerAction2", true)
addEventHandler("onDryerAction2", root, function(typ,selected,el)
    if not el or not selected then return end
    if typ == "vehicle" then
		if not el then return end
        local kierowca = getVehicleController(el)
        if selected == 1 then
         local hajs = getElementData(kierowca,"pieniadze")
		 setElementData(kierowca,"pieniadze",hajs-250)
			outputChatBox("Wystawiłeś mandat za przekroczoną prędkość.", source, 255, 255, 255)
			outputChatBox("Dostałeś mandat za przekroczoną prędkosc.", kierowca, 255, 255, 255)
                        local dajkase = math.random(10,50)
        end
	end
end)