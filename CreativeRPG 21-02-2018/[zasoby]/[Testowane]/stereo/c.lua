--[[
Autor: Asperek
]]

local sound = {}

addEvent("playStereoMusic", true)
addEventHandler("playStereoMusic", root, function(url,veh)
	if sound[veh] then
		stopSound(sound[veh])
		sound[veh] = false
		return
	end
	sound[veh] = playSound3D(url, 0,0,0)
	setSoundMaxDistance(sound[veh], 150)
	attachElements(sound[veh], veh)
end)

addEventHandler("onClientElementDestroy", root, function()
	if getElementType(source) == "vehicle" and sound[source] then
		stopSound(sound[source])
		sound[source] = false
	end
end)