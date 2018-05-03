 --[[
	Autor: Asper
	Dla servera: .newMode
	Skrypt: Prawo jazdy
]]

addEvent("zdalEgzamin", true)
addEventHandler("zdalEgzamin", root, function(p)
	exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Gratulacje zdałeś egzamin!", p) 
	zEgz(p)
	local pojazd = getPedOccupiedVehicle(p)
	destroyElement(pojazd)
	setElementData(p, "pegz", false)
	setTimer(function()
		setElementPosition(p, -2024.68, -114.22, 1035.17)
		setElementInterior(p, 3)
	end, 50, 1)
end)

local pegz = false
local cuboid = createColSphere(2310.09, 1795.87, 10.82, 4)
addEvent("rozpocznijKurs", true)
addEventHandler("rozpocznijKurs", root, function(p, c)
	local vehicles = getElementsWithinColShape(cuboid, "vehicle")
	for _, veh in ipairs(vehicles) do  
		if not getVehicleController(veh) then
			if getElementData(veh, "id") then
				exports.mysql:wykonaj("UPDATE pojazdy SET przechowalnia=1 WHERE id=?", getElementData(veh, "id"))
			end
			destroyElement(veh)
		end
	end
	if #getElementsWithinColShape(cuboid, "vehicle") > 0 then 
		exports["nm-noti"]:noti("Spawn pojazdu prawa jazdy jest zastawiony, spróbuj później.", p)
		return
	end
	if c == "Kategoria A" then
		if getElementData(p, "prawko_a") == 1 then 	exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Posiadasz już zdane prawo jazdy kat. A!", p)  return end
		pegz = createVehicle(581, 2310.13, 1794.41, 10.53, 359.9, 0.0, 179.0)
		setElementData(pegz, "nametag", "Prawo jazdy\n<KAT. A>")
		setVehicleHandling(pegz, "maxVelocity", 50)
		setElementData(p, "pegz", pegz)
		setVehicleColor(pegz, 255, 255, 255)
		warpPedIntoVehicle(p, pegz)
		setElementData(p, "prawko", "A")
		setElementInterior(p, 0)
		setElementInterior(pegz, 0)
		setElementData(p, "zdaje", 200)
		setElementData(pegz, "przebieg", math.random(2500,50000))			
        setVehiclePlateText(pegz, "KAT A")		
	elseif c == "Kategoria B" then
		if getElementData(p, "prawko_b") == 1 then exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Posiadasz już zdane prawo jazdy kat. B!", p) return end
		pegz = createVehicle(436, 2310.13, 1794.41, 10.53, 359.9, 0.0, 179.0)
		setElementData(pegz, "nametag", "Prawo jazdy\n<KAT. B>")
		setElementData(p, "pegz", pegz)
		setVehicleColor(pegz, 255, 255, 255)
		warpPedIntoVehicle(p, pegz)
		setElementData(p, "prawko", "B")
		setVehicleHandling(pegz, "maxVelocity", 75)
		setElementInterior(pegz, 0)
		setElementInterior(p, 0)		
		setElementData(p, "zdaje", 200)
		setElementData(pegz, "przebieg", math.random(2500,50000))			
        setVehiclePlateText(pegz, "KAT B")			
	elseif c == "Kategoria C" then
		if getElementData(p, "prawko_c") == 1 then exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Posiadasz już zdane prawo jazdy kat. C!", p) return end
		pegz = createVehicle(403, 2310.13, 1794.41, 10.53, 359.9, 0.0, 179.0)
		setElementData(pegz, "nametag", "Prawo jazdy\n<KAT. C>")
		setElementData(p, "pegz", pegz)
		setVehicleColor(pegz, 255, 255, 255)
		warpPedIntoVehicle(p, pegz)
		setElementData(p, "prawko", "C")
		setElementData(p, "zdaje", 200)
		setElementData(pegz, "przebieg", math.random(2500,50000))		
		setElementInterior(p, 0)
		setElementInterior(pegz, 0)
		setVehicleHandling(pegz, "maxVelocity", 75)
        setVehiclePlateText(pegz, "KAT C")			
	end
end)

function zEgz(p)
	local c = getElementData(p, "prawko")
	if not c then return end
	if c == "A" then co = "a"
	elseif c == "B" then co = "b"
	elseif c == "C" then co = "c"
	end
	setElementData(p, "prawko_"..co, 1)
	exports.mysql:wykonaj("UPDATE konta SET prawko_"..co.."=1 WHERE dbid=?", getElementData(p, "dbid"))
end

addEvent("zakaczylEgzamin", true)
addEventHandler("zakaczylEgzamin", root, function()
	local pa = getElementData(source, "pegz")
	if pa then
		destroyElement(pa)
		setElementData(source, "pegz", false)
	end
end)

addEventHandler("onVehicleExit", resourceRoot, function(g, s) 
		if s ~= 0 then return end 
		destroyElement(source) 
		setElementData(g, "zdaje", false)
		exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Opuściłeś pojazd, nie zdajesz egzaminu!", g) 
		setElementData(g, "pegz", false)
		setTimer(function()
		setElementPosition(g, -2024.68, -114.22, 1035.17)
		setElementInterior(g, 3)
		end, 1000, 1)
end)

addEventHandler("onPlayerQuit", root, function()
	local pa = getElementData(source, "pegz") 
	if pa and isElement(pa) then 
		destroyElement(pa) 
	end 
end)

addEventHandler("onVehicleDamage", resourceRoot, function()
	local gracz = getVehicleController(source)
	if not gracz then return end
	destroyElement(source)
    exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Uszkodziłeś pojazd, nie zdajesz egzaminu!", gracz) 	
	setElementData(gracz, "zdaje", false)
	setElementData(gracz, "pegz", false)
		setTimer(function()
		setElementPosition(gracz, -2024.68, -114.22, 1035.17)
		setElementInterior(gracz, 3)
		end, 1000, 1)
end)

local marker = createMarker(-2032.67, -117.34, 1035.17-1, "cylinder", 1.2, 0, 94, 254, 75)
setElementInterior(marker, 3)

addEventHandler("onMarkerHit", marker, function(hit)
	triggerClientEvent(hit, "oknoEgz", root)
end)

addEventHandler("onMarkerLeave", marker, function(hit)
	triggerClientEvent(hit, "oknoEgzC", root)
end)
