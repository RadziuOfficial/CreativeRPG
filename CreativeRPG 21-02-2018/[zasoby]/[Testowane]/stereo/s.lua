--[[
Autor: Asperek
]]

addCommandHandler("stereo", function(player, _, url)
	if not url then
		exports["nm-noti"]:noti("Poprawne użycie: /stereo [link url]", player)
		return
	end
	local veh = getPedOccupiedVehicle(player)
	if not veh then return end
	local upgrades = getVehicleUpgrades(veh)
	for i,v in ipairs(upgrades) do
		if v == 1086 then
			triggerClientEvent(root, "playStereoMusic", root, url, veh)
		end
	end
end)