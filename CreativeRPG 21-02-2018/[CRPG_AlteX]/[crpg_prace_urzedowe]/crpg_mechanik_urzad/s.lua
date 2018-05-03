--[[
  Autor: Asper
  Skrypt: Naprawa pojazdow
  Zakaz udostepniania bez zgody autora!
  Zakaz uzywania bez zgody autora!
]]

local miejsca = {
{1944.76, 2157.39, 10.82, 1942.32, 2157.07, 10.82},
{-2050.85, 167.76, 28.84, -2051.14, 170.46, 29.44},	
}

local texty = {
{-2056.04, 170.45, 30.14},
{-2056.31, 178.52, 30.14},
}

for i,v in ipairs(miejsca) do
	local marker = createMarker(v[1], v[2], v[3]-1, "cylinder", 1.5, 15, 15, 15, 125)
	local cuboid = createColCuboid(v[4], v[5], v[6]-1, 6.15, 6.6, 4)
	setElementData(marker, "cuboid", cuboid)
	setElementData(marker,'typ', 'wrench')
end

for i,v in ipairs(texty) do
	local text = createElement("text")
	setElementData(text, "text", "Stanowisko naprawcze #"..i)
	setElementPosition(text, v[1], v[2], v[3]+1.7)
end

addEvent("napraw:czesc", true)
addEventHandler("napraw:czesc", root, function(veh, czesc)
	if czesc == 1 then 
		setElementHealth(veh, 10000) 
	end
	if czesc == 2 then 
		setVehicleDoorState(veh, 0, 0) 
	end
	if czesc == 3 then 
		setVehicleDoorState(veh, 1, 0) 
	end
	if czesc == 4 then 
		setVehicleDoorState(veh, 2, 0) 
	end
	if czesc == 5 then 
		setVehicleDoorState(veh, 3, 0)
	end
	if czesc == 6 then 
		setVehicleDoorState(veh, 4, 0) 
	end
	if czesc == 7 then 
		setVehicleDoorState(veh, 5, 0) 
	end
	if czesc == 8 then 
		setVehiclePanelState(veh, 4, 0) 
	end
	if czesc == 9 then 
		setVehiclePanelState(veh, 5, 0) 
	end
	if czesc == 10 then 
		setVehiclePanelState(veh, 6, 0) 
	end
	if czesc == 11 then 
		setVehicleLightState(veh, 0, 0) 
	end
	if czesc == 12 then 
		setVehicleLightState(veh, 1, 0) 
	end
	if czesc == 13 then 
		setVehicleLightState(veh, 2, 0) 
	end
	if czesc == 14 then 
		setVehicleLightState(veh, 3, 0) 
	end
end)