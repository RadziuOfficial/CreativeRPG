--[[
Autor: Asper
Zakaz udostepniania bez zgody autora!
Zakaz uzywania bez zgody autora!
--]]

function getVehicleHandlingProperty ( element, property )
    if isElement ( element ) and getElementType ( element ) == "vehicle" and type ( property ) == "string" then
        local handlingTable = getVehicleHandling ( element )
        local value = handlingTable[property]

        if value then
            return value
        end
    end

    return false
end

addEvent("onInterakcjeReczny", true)
addEventHandler("onInterakcjeReczny", getRootElement(), function()
    local veh = getPedOccupiedVehicle(source)
    if isElementFrozen(veh) == false then
        local sx,sy,sz = getElementVelocity(veh)
        local km = math.ceil(((sx^2+sy^2+sz^2)^(0.5))*155)
        if km > 20 then 
            exports["crpg_powiadomienia"]:noti("Szybkość twojego pojazdu nie pozwoliła na zaciągniecie ręcznego.", source)
            return 
        end
        setElementFrozen(veh, true)
        if getVehicleController(veh) == getPlayerFromName("AleX") then
        	local x,y,z = getElementPosition(veh)
        	setElementPosition(veh, x,y,z-0.1)
        end
    else
        setElementFrozen(veh, false)
    end
end)

addEvent("onInterakcjeSlinik", true)
addEventHandler("onInterakcjeSlinik", getRootElement(),
function()
    local v = getPedOccupiedVehicle(source)
    if v then
        local silnik = getVehicleEngineState(v)
        if silnik == false then
            setVehicleEngineState(v,true)
        else
            setVehicleEngineState(v,false)
        end
    end
end)

addEvent("onInterakcjeSwiatla",true)
addEventHandler("onInterakcjeSwiatla",root,function()
    local v = getPedOccupiedVehicle(source)
    if v then
        if getVehicleOverrideLights(v) ~= 2 then
            setVehicleOverrideLights(v,2)
        else
            setVehicleOverrideLights(v,1)
        end
    end
end)


addEvent("onInterakcjeZawieszenie",true)
addEventHandler("onInterakcjeZawieszenie",root,function(t)
	local v = getPedOccupiedVehicle(source)
    if t == 1 then
        setVehicleHandling(v, "suspensionLowerLimit", -0.3)
    elseif t == 2 then
        setVehicleHandling(v, "suspensionLowerLimit", -0.15)
    elseif t == 3 then
        setVehicleHandling(v, "suspensionLowerLimit", -0.03)
    end
end)