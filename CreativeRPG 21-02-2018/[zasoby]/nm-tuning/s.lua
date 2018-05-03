--[[
Autor: Asper
Dla: .newMode
Skrypt: Tuning pojazdów
Typ: Server
]]

local marker = createMarker(-2174.70, 636.83, 49.44-6.95, "cylinder", 6, 255, 255, 255)

addEvent("dTuning", true)
addEventHandler("dTuning", root, function(v, i)
	if not v and not i then return end
	addVehicleUpgrade(v, i)
	local tune = getVehicleUpgrades(v)
	if not tune then
		tune = {}
	end
	tune = table.concat(tune, ",")
	exports.mysql:wykonaj("UPDATE pojazdy SET tuning=? WHERE id=?", tune, getElementData(v, "id"))
end)

addEvent("uTuning", true)
addEventHandler("uTuning", root, function(v, i)
	if not v and not i then return end
	removeVehicleUpgrade(v, i)
	local tune = getVehicleUpgrades(v)
	if not tune then
		tune = {}
	end
	tune = table.concat(tune, ",")
	exports.mysql:wykonaj("UPDATE pojazdy SET tuning=? WHERE id=?", tune, getElementData(v, "id"))
end)