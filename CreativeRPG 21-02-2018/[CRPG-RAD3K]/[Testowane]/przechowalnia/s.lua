--[[
Autor: Asperek
]]

-- przechowalnia
--[[local napisy = createElement("text")
setElementData(napisy, "text", "Panel Odbioru Pojazdu ")
setElementPosition(napisy, -2089.11, 84.23, 35.31)

local napisy2 = createElement("text")
setElementData(napisy2, "text", "Miejsce Pozostawiania Pojazdu ")
setElementPosition(napisy2,  -2091.85, 94.81, 36.32)]]

local odbieranie = {
{1957.05, 2166.62, 10.82},
}

local moddwanie = false
local modbieranie = false

addEventHandler("onResourceStart", resourceRoot, function()
	for _, m in ipairs(odbieranie) do
		modbieranie = createMarker(m[1], m[2], m[3]-1, "cylinder", 1.2, 0, 94, 254, 50)
	end
end)

local oCuboid = createMarker(1964.33, 2154.14, 10.82-2, "cylinder", 5, 255, 0, 0, 50)
local wCuboid = createColSphere(1962.95, 2162.54, 10.82, 3.5)
createBlip(1957.05, 2166.62, 10.82, 35,2,0,0,0,0,0,250)

addEventHandler("onMarkerHit", oCuboid, function(hit)
	if not hit or not isElement(hit) then return end
	if getElementType(hit) ~= "player" then return end
	if not isPedInVehicle(hit) then return end
	local veh = getPedOccupiedVehicle(hit)
	local wyk = exports.mysql:wykonaj("UPDATE pojazdy SET przechowalnia=1 WHERE id=?", getElementData(veh, "id"))
        if getElementData(veh,"id") then
	if wyk then
		outputChatBox("Pojazd został zaparkowany na parkingu.", hit, 255, 255, 255)
		exports["nm-pojazdy"]:zapiszPojazdy(veh)
		destroyElement(veh)
	else
		outputChatBox("Blad przechowalni zglos sie do Administratora.", g, 255, 255, 255)
	end
    end
end)

function sprawdzPrzechowalnie(gracz)
	if getElementData(gracz, "organizacja") then
		return exports.mysql:wykonaj("SELECT * FROM pojazdy WHERE (wlasciciel=? OR organizacja=?) AND przechowalnia=1", getElementData(gracz, "dbid"), getElementData(gracz, "organizacja"))
	else
		return exports.mysql:wykonaj("SELECT * FROM pojazdy WHERE wlasciciel=? AND przechowalnia=1", getElementData(gracz, "dbid"))
	end
end

addEventHandler("onMarkerHit", resourceRoot, function(hit)
	if source == modbieranie then
	if getElementType(hit) ~= "player" then return end
	local spr = sprawdzPrzechowalnie(hit)
		if #spr < 1 then
			outputChatBox("Nie posiadasz pojazdów w przechowalni.", hit, 255, 0, 0)
			return
		end
		triggerClientEvent(hit, "pojazdy", hit, spr)
	end
end)

addEventHandler("onMarkerLeave", resourceRoot, function(hit)
	if source == modbieranie then
	if getElementType(hit) ~= "player" then return end
		triggerClientEvent(hit, "oknoPrzecho", hit)
	end
end)

addEvent("wyjmij", true)
addEventHandler("wyjmij", root, function(gracz, id)
	local vehicles = getElementsWithinColShape(wCuboid, "vehicle")
	for _, veh in ipairs(vehicles) do  
		if not getVehicleController(veh) then
			if getElementData(veh, "id") then
				exports.mysql:wykonaj("UPDATE pojazdy SET przechowalnia=1 WHERE id=?", getElementData(veh, "id"))
			end
			destroyElement(veh)
		end
	end
	if #getElementsWithinColShape(wCuboid, "vehicle") > 0 then 
		exports["crpg_powiadomienia"]:noti("Wyjazd z parkingu jest zastawiony, spróbuj później.", gracz)
		return
	end
 	local sprx = exports.mysql:wykonaj("SELECT * FROM prawka WHERE serial=?", getPlayerSerial(gracz))
	if #sprx > 0 then
		exports["crpg_powiadomienia"]:noti("Posiadasz zawieszone prawo jazdy kat. A,B,C do "..sprx[1].data.." zabrane przez "..sprx[1].admin, gracz)
		return
	end
	if getElementData(gracz, "prawko_b") ~= 1 then
		exports["crpg_powiadomienia"]:noti("Nie posiadasz prawa jazdy.", gracz)
		return
	end
	local q = exports.mysql:wykonaj("select * from pojazdy where id=?", id)
	exports.mysql:wykonaj("update pojazdy set przechowalnia=0 where id=?", id)
	local pojazd = exports["nm-pojazdy"]:stworzPojazdy(q[1], 1963.02, 2162.39, 10.52, 359.9, 360.0, 90.6)
	if pojazd then
		warpPedIntoVehicle(gracz, pojazd)
	end
end)