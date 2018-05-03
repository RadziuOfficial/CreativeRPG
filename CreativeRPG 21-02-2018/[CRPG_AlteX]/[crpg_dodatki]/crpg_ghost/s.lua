--[[
	autor: Asper & Payro
	for: Own World
	All rights reserved!
]]

local cuboids = {
--x, y, z, rozmiar
{-2434.71, -681.57, 132.64, 70},
{-770.13360595703, 1486.7152099609, 24.3896484375, 10},
}

for i,v in ipairs(cuboids) do
	local cs = createColSphere(v[1], v[2], v[3], v[4])
	setElementData(cs, "vehicle", true)
end

addEventHandler("onColShapeHit", resourceRoot, function(hit)
	if hit and getElementType(hit) ~= "vehicle" then return end
	if not getElementData(source, "vehicle") then return end
	triggerClientEvent(root, "ghost:cuboids", resourceRoot, source, hit, "vehicle", "Hit")
end)

addEventHandler("onColShapeLeave", resourceRoot, function(hit)
	if hit and getElementType(hit) ~= "vehicle" then return end
	if not getElementData(source, "vehicle") then return end
	triggerClientEvent(root, "ghost:cuboids", resourceRoot, source, hit, "vehicle", "Leave")
end)