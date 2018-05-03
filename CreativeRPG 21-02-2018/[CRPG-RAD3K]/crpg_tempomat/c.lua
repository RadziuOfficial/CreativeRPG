--[[
	autor: Asper & Payro
	for: Own World
	All rights reserved!
]]

local vmax = 0
local og = false

bindKey("mouse1", "down", function()
	if isChatBoxInputActive() or isConsoleActive() or isMainMenuActive () or isTransferBoxActive () then return end
	if isCursorShowing() then return end
	local veh = getPedOccupiedVehicle(localPlayer)
	if not veh then return end
	if not getVehicleController(veh) or getVehicleController(veh) ~= localPlayer then return end
	if getElementSpeed(veh) < 1 then return end
	if og ~= true then
		og = true
		vmax = getElementSpeed(veh)
		exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Ogracznik prędkości ustawiony na "..vmax.."km/h", el)	
	else
		og = false
		exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Ogranicznik prędkości wyłączony.", el)			
	end
end)

addEventHandler("onClientRender", root, function()
	local veh = getPedOccupiedVehicle(localPlayer)
	if veh and og then
		local vx,vy,vz = getElementVelocity(veh)
		local actualspeed = math.ceil(((vx^2+vy^2+vz^2)^(0.5))*165)
		if actualspeed > vmax then
			setElementVelocity(veh, vx*0.9,vy*0.9,vz*0.9)
		end
	end
end)

addEventHandler("onClientVehicleExit", root, function()
	og = false
end)

function getElementSpeed(veh)
	local h = getVehicleHandling(veh)
	local sx,sy,sz = getElementVelocity(veh)
	local rspeed = math.ceil(((sx^2+sy^2+sz^2)^(0.5))*165)
	return math.floor(rspeed)
end