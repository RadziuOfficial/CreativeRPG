--[[
  Autor: Asper
  Dla: .newMode
  Skrypt: Stacje paliw
]]

local cuboidy = {
{-2390.12, -104.72, 34.98, 8},
{-2026.70, 152.07, 28.80, 8},
{-2410.87, 975.25, 45.46, 8},
{-2272.91, 21.50, 35.32, 4},
{1381.46, 459.60, 20.35, 5},
{2202.25, 2473.16, 10.82, 5},
{2114.82, 920.23, 10.82, 5},
{2639.41, 1106.09, 10.82, 5},
{70.50, 1218.59, 18.81, 8},
}

for i,v in ipairs(cuboidy) do
	local c = createColSphere(v[1], v[2], v[3], v[4])
	createBlipAttachedTo(c, 40,2,255,0,0,255,0,100)
end

addEventHandler("onColShapeHit", resourceRoot, function(hit)
	if getElementType(hit) ~= "player" then return end
	local pojazd = getPedOccupiedVehicle(hit)
	if pojazd and getElementData(pojazd, "paliwo") then
		if getVehicleController(pojazd) ~= hit then return end
		triggerClientEvent(hit, "gStacja", hit)
	end
end)

addEventHandler("onColShapeLeave", resourceRoot, function(hit)
	if getElementType(hit) ~= "player" then return end
	local pojazd = getPedOccupiedVehicle(hit)
	if pojazd and getElementData(pojazd, "paliwo") then
		if getVehicleController(pojazd) ~= hit then return end
		triggerClientEvent(hit, "cgStacja", hit)
	end
end)