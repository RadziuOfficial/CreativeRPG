--[[
Autor: Asper
Dla: .newMode
Skrypt: Pojazdy publiczne
]]

local pojazdy = {
-- SPAWN SF
{462, -2714.31, 138.56, 3.94, 359.5, 360.0, 286.2},
{462, -2714.31, 140.56, 3.94, 359.5, 360.0, 286.2},
{462, -2714.31, 142.56, 3.94, 359.5, 360.0, 286.2},
{462, -2714.31, 144.56, 3.94, 359.5, 360.0, 286.2},
{462, -2714.31, 146.56, 3.94, 359.5, 360.0, 286.2},
-- SPAWN LV
{462, 2125.12, 2367.54, 10.42, 359.5, 360.0, 180.7},
{462, 2123.12, 2367.54, 10.42, 359.5, 360.0, 180.7},
{462, 2121.12, 2367.54, 10.42, 359.5, 360.0, 180.7},
{462, 2119.12, 2367.54, 10.42, 359.5, 360.0, 180.7},
-- HOLOWNIK LV
{462, 1023.05, 2145.03, 10.42, 0.1, 360.0, 180.0},
{462, 1025.05, 2145.03, 10.42, 0.1, 360.0, 180.0},
{462, 1027.05, 2145.03, 10.42, 0.1, 360.0, 180.0},
{462, 1029.05, 2145.03, 10.42, 0.1, 360.0, 180.0},
{462, 1031.05, 2145.03, 10.42, 0.1, 360.0, 180.0},
{462, 1033.05, 2145.03, 10.42, 0.1, 360.0, 180.0},
-- CYGAN LV
{462, 2266.87, 2030.79, 10.42, 359.5, 360.0, 190.6},
{462, 2268.87, 2030.79, 10.42, 359.5, 360.0, 190.6},
{462, 2270.87, 2030.79, 10.42, 359.5, 360.0, 190.6},
{462, 2272.87, 2030.79, 10.42, 359.5, 360.0, 190.6},
-- PRAWKO LV
{462, 2248.06, 1781.25, 10.42, 359.6, 360.0, 182.4},
{462, 2250.06, 1781.25, 10.42, 359.6, 360.0, 182.4},
{462, 2252.06, 1781.25, 10.42, 359.6, 360.0, 182.4},
{462, 2254.06, 1781.25, 10.42, 359.6, 360.0, 182.4},
}

addEventHandler("onResourceStart", resourceRoot, function()
	for i,v in ipairs(pojazdy) do
 		local pojazd = createVehicle(v[1], v[2], v[3], v[4], v[5], v[6], v[7])
		setVehicleColor(pojazd,255,255,255,0,94,254)
 		setElementData(pojazd, "nametag", "Pojazd\nPubliczny")
        setVehicleHandling(pojazd, "maxVelocity", 40)			
 		setElementFrozen(pojazd, true)
 		toggleVehicleRespawn(pojazd, true)
 	end
end)

addEventHandler("onVehicleEnter", resourceRoot, function(g, s)
	if s ~= 0 then return end
	exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Wziąłeś pojazd publiczny, życzymy miłej jazdy!", g)
	setElementFrozen(source, false)
end)

addEventHandler("onVehicleExit", resourceRoot, function(g, s)
	if s ~= 0 then return end
	exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Pozostawiłeś pojazd publiczny zniknie on za 15 sekund.", g)
	local pojazd = source
	setTimer(function()
		if not getVehicleController(pojazd) then
			respawnVehicle(pojazd)
			setElementFrozen(pojazd, true)
		    setVehicleColor(pojazd,255,255,255,0,94,254)	
            setVehicleHandling(pojazd, "maxVelocity", 40)			
			setElementData(pojazd, "nametag", "Pojazd\nPubliczny")
		end
	end, 15000, 1)
end)