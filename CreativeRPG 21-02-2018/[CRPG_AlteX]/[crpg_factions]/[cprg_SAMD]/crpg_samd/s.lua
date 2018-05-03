--[[
Autor: Malentas
]]
function findPlayer(plr, cel)
	local target = nil
	if (tonumber(cel) ~= nil) then
		target = getElementByID("p"..cel)
	else
		for _,thePlayer in ipairs(getElementsByType("player")) do
			if string.find(string.gsub(getPlayerName(thePlayer):lower(),"#%x%x%x%x%x%x", ""), cel:lower(), 1, true) then
				if (target) then
					outputChatBox("Znaleziono wiecej niz jednego gracza o pasujacym nicku, podaj wiecej liter.", plr)
					return nil
				end
				target=thePlayer
			end
		end
	end
	return target
end

local licz = {}

local rozpoczecie = createMarker(-2640.12, 649.36, 14.54-0.9, "cylinder", 1.2, 0, 255, 255, 75)
local napisy = createElement("text")
setElementData(napisy, "text", "Punkt odbicia\n karty pracownika")
setElementPosition(napisy, -2640.12, 649.36, 14.54)

local liderPanel = createMarker(-2656.54, 672.39, 14.54-0.9, "cylinder", 1.2, 0, 255, 255, 75)
local napisy = createElement("text")
setElementData(napisy, "text", "Monitor Lidera\n Frakcji")
setElementPosition(napisy, -2656.54, 672.39, 14.54)

addEventHandler("onMarkerHit", rozpoczecie, function(player)
local result = exports.mysql:wykonaj("SELECT * FROM frakcje WHERE uid=? AND frakcja=?", getElementData(player, "dbid"), "SAMD")
if #result > 0 then
if getElementData(player, "frakcja") then
zatrzymajnaliczanie(player)
setElementData(player, "frakcja", false)
setElementData(player, "frakcjarank", false)
takeWeapon(player, 41)
toggleControl(player, "fire", false)
toggleControl(player, "aim_weapon", false)
setElementModel(player, getElementData(player, "user:lastskin"))
outputChatBox("Zakończyłeś służbę w frakcji Pogotowie Ratunkowe.", player)
else
rozpocznijnaliczanie(player)
setElementData(player, "frakcja", "SAMD")
setElementData(player, "frakcjarank", result[1].rank)
giveWeapon(player, 41, 99999)
toggleControl(player, "fire", true)
toggleControl(player, "aim_weapon", true)
setElementData(player, "user:lastskin", getElementModel(player))
outputChatBox("Rozpocząłeś służbę w frakcji Pogotowie Ratunkowe.", player)
end
else
outputChatBox("Nie jesteś zatrudniony w frakcji Pogotowie Ratunkowe.", player)
end
end)

addEventHandler("onMarkerHit", liderPanel, function(player)
if not getElementData(player, "frakcja") == "SAMD" then return end
local result = exports.mysql:wykonaj("SELECT * FROM frakcje WHERE uid=? AND frakcja=?", getElementData(player, "dbid"), "SAMD")
if result[1].rank == 4 or result[1].rank == 3 then
outputChatBox("Komendy: /dodaj <id gracza>, <wyrzuc> <id gracza>, /edytuj <id gracza> <nowa ranga 1-3>", player)
setElementData(player, "liderpanel:on:SAMD", true)
else
outputChatBox("Nie jesteś w frakcji Pogotowie Ratunkowe lub nie masz uSAMDawnień do panelu.", player)
end
end)

addEventHandler("onMarkerLeave", liderPanel, function(player)
if not getElementData(player, "frakcja") == "SAMD" then return end
local result = exports.mysql:wykonaj("SELECT * FROM frakcje WHERE uid=? AND frakcja=?", getElementData(player, "dbid"), "SAMD")
if result[1].rank == 4 or result[1].rank == 3 then
setElementData(player, "liderpanel:on:SAMD", false)
end
end)

addCommandHandler("dodaj", function(plr, cmd, kto)
if getElementData(plr, "liderpanel:on:SAMD") then
if not kto then
outputChatBox("Użyj /dodaj <id gracza>", plr, 0, 255, 0)
return
end
local target = findPlayer(plr, kto)
if not target then return end
local result = exports.mysql:wykonaj("SELECT * FROM frakcje WHERE uid=? AND frakcja=?", getElementData(target, "dbid"), "SAMD")
if #result < 0 then
outputChatBox(""..getPlayerName(target).." znajduje się w tej frakcji.", plr)
return
end
outputChatBox("Dodano gracza "..getPlayerName(target).." do frakcji na rangę 1.", plr)
exports.mysql:wykonaj("INSERT INTO frakcje SET uid=?, frakcja=?, rank=?", getElementData(target, "dbid"), "SAMD", "1")
end
end)

addCommandHandler("wyrzuc", function(plr, cmd, kto)
if getElementData(plr, "liderpanel:on:SAMD") then
if not kto then
outputChatBox("Użyj /wyrzuc <id gracza>", plr, 0, 255, 0)
return
end
local target = findPlayer(plr, kto)
if not target then return end
local result = exports.mysql:wykonaj("SELECT * FROM frakcje WHERE uid=? AND frakcja=?", getElementData(target, "dbid"), "SAMD")
if #result < 0 then
outputChatBox(""..getPlayerName(target).." znajduje nie się w tej frakcji.", plr)
return
end
outputChatBox("Usunięto gracza "..getPlayerName(target).." z frakcji.", plr)
exports.mysql:wykonaj("DELETE FROM frakcje WHERE frakcja=? AND uid=?", "SAMD", getElementData(target, "dbid"))
end
end)

addCommandHandler("edytuj", function(plr, cmd, kto, ranga)
if getElementData(plr, "liderpanel:on:SAMD") then
if not kto then
outputChatBox("Użyj /edytuj <id gracza>", plr, 0, 255, 0)
return
end
local target = findPlayer(plr, kto)
if not target then return end
local result = exports.mysql:wykonaj("SELECT * FROM frakcje WHERE uid=? AND frakcja=?", getElementData(target, "dbid"), "SAMD")
if #result < 0 then
outputChatBox(""..getPlayerName(target).." nie znajduje się w tej frakcji.", plr)
return
end
outputChatBox("Edytowano gracza "..getPlayerName(target)..".", plr)
exports.mysql:wykonaj("UPDATE frakcje SET rank=? WHERE uid=?", ranga, getElementData(target, "dbid"))
end
end)

local pojazdy = {
--Karetki
{416,2642.22, -2350.88, 13.87, 180.2,"Los Santos Fire Departament\n301[LS]21"},
--FBI Rancher
{490,-2543.12, 587.24, 14.58, 89.8},
{490,-2543.10, 593.01, 14.58, 89.8},
--Rancher
{489,-2542.71, 599.01, 14.60, 89.8},
--Yosemite
{554,-2542.96, 604.79, 14.54, 89.8,"Pojazd Szkoleniowców\nSAMD"},
--Huntley
{579,-2542.71, 611.20, 14.39, 89.8,"Transport Krwi\nSAMD"},
--Zarząd
{560,-2544.70, 622.13, 14.16, 89.8,"Zarząd\nSAMD"},
{560,-2544.57, 627.23, 14.16, 89.8,"Główny Zarząd\nSAMD"},
--Karetki
{416,-2589.28, 622.38, 14.61, -89.8,"P'1\nSAMD"},
{416, -2589.27, 627.49, 14.61, -89.8,"P'2\nSAMD"},
{416, -2589.24, 632.71, 14.60, -89.8,"P'3\nSAMD"},
{416, -2589.22, 637.86, 14.60, -89.8,"P'4\nSAMD"},
--karetki S
{416, -2589.13, 647.71, 14.60, -89.8,"S'1\nSAMD"},
{416, -2589.09, 652.85, 14.60, -89.8,"S'2\nSAMD"},
{416, -2589.14, 658.09, 14.60, -89.8,"S'3\nSAMD"},

}

local SAMD = createBlip(-2609.94, 611.25, 14.45, 22)

for _,v in ipairs(pojazdy)do
local vehicle = createVehicle(v[1], v[2], v[3], v[4], 0, 0, v[5])
local acceleration = getVehicleHandling(vehicle).engineAcceleration
local velocity = getVehicleHandling(vehicle).maxVelocity
local mass = getVehicleHandling(vehicle).mass
local turnmass = getVehicleHandling(vehicle).turnMass
local mutlipiler = getVehicleHandling(vehicle).tractionMultiplier
local coef = getVehicleHandling(vehicle).dragCoeff
if v[1] == 416 then
setVehicleHandling(vehicle, "engineAcceleration", acceleration+4)
setVehicleHandling(vehicle, "maxVelocity", velocity+30)
setVehicleHandling(vehicle, "steeringLock", 40)
setVehicleHandling(vehicle, "driveType", "awd")
removeVehicleSirens(vehicle)
addVehicleSirens(vehicle, 8, 2, true, false, true, true )
addVehicleSirens(vehicle, 6, 2, true, false, true, true )
elseif v[1] == 490 then
setVehicleHandling(vehicle, "engineAcceleration", acceleration+3)
setVehicleHandling(vehicle, "maxVelocity", velocity+30)
setVehicleHandling(vehicle, "steeringLock", 40)
setVehicleHandling(vehicle, "driveType", "awd")
setVehicleColor(vehicle,255,255,255,255,0,0)
removeVehicleSirens(vehicle)
addVehicleSirens(vehicle, 8, 2, true, false, true, true )
addVehicleSirens(vehicle, 6, 2, true, false, true, true )
elseif v[1] == 579 then
setVehicleHandling(vehicle, "engineAcceleration", acceleration+3)
setVehicleHandling(vehicle, "maxVelocity", velocity+30)
setVehicleHandling(vehicle, "steeringLock", 40)
setVehicleHandling(vehicle, "driveType", "awd")
setVehicleColor(vehicle,255,255,255,255,255,255)
removeVehicleSirens(vehicle)
addVehicleSirens(vehicle, 8, 2, true, false, true, true )
addVehicleSirens(vehicle, 6, 2, true, false, true, true )
setVehicleSirens(vehicle, 1, -0.800, 4.000, -0.200, 255, 255, 255, 255, 255 )
setVehicleSirens(vehicle, 2, 0.800, 4.000, -0.200, 255, 255, 255, 255, 255 )
setVehicleSirens(vehicle, 3, -0.900, -3.550, 0.100, 255, 0, 0, 255, 255 )
setVehicleSirens(vehicle, 4, 0.900, -3.550, 0.100, 255, 0, 0, 255, 255 )
setVehicleSirens(vehicle, 5, -0.600, 3.200, 1.270, 255, 0, 0, 255, 255 )
setVehicleSirens(vehicle, 6, 0.600, 3.200, 1.270, 0, 0, 255, 255, 255 )
elseif v[1] == 489 then
setVehicleHandling(vehicle, "engineAcceleration", acceleration+1.5)
setVehicleHandling(vehicle, "maxVelocity", velocity+30)
setVehicleHandling(vehicle, "steeringLock", 40)
setVehicleHandling(vehicle, "driveType", "awd")
setVehicleColor(vehicle,255,255,255,255,255,255)
removeVehicleSirens(vehicle)
addVehicleSirens(vehicle, 8, 2, true, false, true, true )
addVehicleSirens(vehicle, 6, 2, true, false, true, true )
setVehicleSirens(vehicle, 1, -0.800, 4.000, -0.200, 255, 255, 255, 255, 255 )
setVehicleSirens(vehicle, 2, 0.800, 4.000, -0.200, 255, 255, 255, 255, 255 )
setVehicleSirens(vehicle, 3, -0.900, -3.550, 0.100, 255, 0, 0, 255, 255 )
setVehicleSirens(vehicle, 4, 0.900, -3.550, 0.100, 255, 0, 0, 255, 255 )
elseif v[1] == 554 then
setVehicleHandling(vehicle, "engineAcceleration", acceleration+4)
setVehicleHandling(vehicle, "maxVelocity", velocity+20)
setVehicleHandling(vehicle, "steeringLock", 40)
setVehicleHandling(vehicle, "driveType", "awd")
setVehicleColor(vehicle,255,0,0,255,255,255)
removeVehicleSirens(vehicle)
addVehicleSirens(vehicle, 8, 2, true, false, true, true )
addVehicleSirens(vehicle, 6, 2, true, false, true, true )
elseif v[1] == 560 then
addVehicleUpgrade(vehicle, 1025)
setVehicleHandling(vehicle, "engineAcceleration", acceleration+8)
setVehicleHandling(vehicle, "maxVelocity", velocity+150)
setVehicleHandling(vehicle, "steeringLock", 45)
setVehicleHandling(vehicle, "driveType", "awd")
setVehicleColor(vehicle, 255, 255, 255, 255, 255, 255)
removeVehicleSirens(vehicle)
addVehicleSirens(vehicle, 6, 2, true, false, true, true)
setVehicleSirens(vehicle, 1, -0.7, 2.5, -0.3, 0, 127.5, 255, 198.9, 198.9)
setVehicleSirens(vehicle, 2, 0.8, 2.5, -0.3, 255, 0, 0, 198.9, 198.9)
setVehicleSirens(vehicle, 3, 0.2, 0.4, 0.6, 0, 127.5, 255, 255, 255)
setVehicleSirens(vehicle, 4, -0.1, 0.4, 0.6, 255, 0, 0, 198.9, 198.9)
setVehicleSirens(vehicle, 5, 0.8, -2.3, 0.2, 255, 0, 0, 200, 200)
setVehicleSirens(vehicle, 6, -0.7, -2.3, 0.2, 255, 0, 0, 200, 200)
setElementData(vehicle,"zawieszenie",2)
setElementData(vehicle,"veh:samd", true)
addVehicleUpgrade(vehicle, 1147)
addVehicleUpgrade(vehicle, 1031)
addVehicleUpgrade(vehicle, 1033)
addVehicleUpgrade(vehicle, 1010)
addVehicleUpgrade(vehicle, 1098)
addVehicleUpgrade(vehicle, 1029)
addVehicleUpgrade(vehicle, 1070)
addVehicleUpgrade(vehicle, 1141)
elseif v[1] == 552 then
removeVehicleSirens(vehicle)
addVehicleSirens(vehicle, 5, 2, true, false, true, true)
setVehicleSirens(vehicle, 1, -0.3, 3.3, 0.4, 0, 127.5, 255, 255, 255)
setVehicleSirens(vehicle, 2, 0.4, 3.3, 0.4, 0, 127.5, 255, 255, 255)
setVehicleSirens(vehicle, 3, -0.5, 0.8, 1.3, 0, 132.6, 255, 198.9, 198.9)
setVehicleSirens(vehicle, 4, -0.9, -3, 0.8, 255, 0, 0, 255, 255)
setVehicleSirens(vehicle, 5, 1.1, -2.8, 0.8, 255, 0, 0, 255, 255)
elseif v[1] == 426 then
removeVehicleSirens(vehicle)
addVehicleSirens(vehicle, 8, 2, true, false, true, true )
addVehicleSirens(vehicle, 6, 2, true, false, true, true )
setVehicleSirens(vehicle, 1, -0.800, 2.400, 0.000, 255, 255, 255, 255, 255 )
setVehicleSirens(vehicle, 2, 0.800, 2.400, 0.000, 255, 255, 255, 255, 255 )
setVehicleSirens(vehicle, 3, -0.900, -2.100, 0.000, 255, 0, 0, 255, 255 )
setVehicleSirens(vehicle, 4, 0.900, -2.100, 0.000, 255, 0, 0, 255, 255 )
end
setElementData(vehicle, "nametag", v[6])
setElementFrozen(vehicle, true)
setElementData(vehicle,"vehicle:SAMD", true)
addVehicleUpgrade(vehicle, 1025)
end

addEventHandler("onVehicleStartEnter", resourceRoot, function(plr, seat, jacked)
if seat ~= 0 then return end
if getElementData(plr, "frakcja") == "SAMD" then
else
cancelEvent()
outputChatBox("Nie SAMDacujesz w Pogotowiu Ratunkowym", plr)
end
end)




function rozpocznijnaliczanie(plr)
if isTimer(licz[plr]) then
killTimer(licz[plr])
licz[plr] = nil
end
licz[plr] = setTimer(naliczanie,60000,0,plr)
end

function zatrzymajnaliczanie(plr)
if isTimer(licz[plr]) then
killTimer(licz[plr])
licz[plr] = nil
end
end

addEventHandler("onPlayerWasted",root,function()
if isTimer(licz[source]) then
killTimer(licz[source])
licz[source] = nil
end
end)

function naliczanie(plr)
if isElement(plr) then
local wyplatka = getElementData(plr, "wyplata") or 0
setElementData(plr, "wyplata", wyplatka+1)
else
if isTimer(licz[plr]) then
killTimer(licz[plr])
licz[plr] = nil
end
end
end

--triggery

addEvent("dajskinSAMD1", true)
addEventHandler("dajskinSAMD1", root, function()
setElementModel(source, 272)
end)

addEvent("dajskinSAMD2", true)
addEventHandler("dajskinSAMD2", root, function()
setElementModel(source, 274)
end)

addEvent("dajskinSAMD3", true)
addEventHandler("dajskinSAMD3", root, function()
setElementModel(source, 275)
end)

addEvent("dajskinSAMD4", true)
addEventHandler("dajskinSAMD4", root, function()
setElementModel(source, 70)
end)





-------------------------------------[[              BRAMY           ]]-------------------