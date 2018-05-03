--[[
  Autor: Asper
  Skrypt: Suszarka administracji
  Zakaz uzywania skryptu bez zgody autora!
  Zakaz udostepniania skryptu bez zgody autora!
]]

addEvent("suszarka:opcja", true)
addEventHandler("suszarka:opcja", root, function(vehicle, opcja)
	if opcja == 1 then
		fixVehicle(vehicle)
	elseif opcja == 2 then
		local rx,ry,rz = getElementRotation(vehicle)
		setElementRotation(vehicle, 0, 0, rz)
	elseif opcja == 3 then
		if getElementData(vehicle, "id") then
			exports.mysql:wykonaj("UPDATE pojazdy SET przechowalnia=1 WHERE id=?", getElementData(vehicle, "id"))
			exports["nm-pojazdy"]:zapiszPojazdy(vehicle, true)
			destroyElement(vehicle)
		else
			destroyElement(vehicle)
		end
	elseif opcja == 4 then
		local bak = getElementData(vehicle, "bak")
		setElementData(vehicle, "paliwo", (bak or 100))
	elseif opcja == 5 then
		if isElementFrozen(vehicle) == true then
			setElementFrozen(vehicle, false)
		else
			setElementFrozen(vehicle, true)
		end
	end
end)