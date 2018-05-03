--[[
Autor: Malentas
Edit: AlteX
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

local rozpoczecie = createMarker(21.70, 1553.24, 18.64-0.9, "cylinder", 1.2, 0, 255, 255, 75)
local napisy = createElement("text")
setElementData(napisy, "text", "Rozpoczęcie Służby")
setElementPosition(napisy, 21.70, 1553.24, 18.64)

local liderPanel = createMarker(18.10, 1530.51, 18.64-0.9, "cylinder", 1.2, 0, 255, 255, 75)
local napisy = createElement("text")
setElementData(napisy, "text", "Panel Zarządu")
setElementPosition(napisy, 18.10, 1530.51, 18.64)

addEventHandler("onMarkerHit", rozpoczecie, function(player)
local result = exports.mysql:wykonaj("SELECT * FROM frakcje WHERE uid=? AND frakcja=?", getElementData(player, "dbid"), "LSFD")
if #result > 0 then
if getElementData(player, "frakcja") then
zatrzymajnaliczanie(player)
setElementData(player, "frakcja", false)
setElementData(player, "frakcjarank", false)
takeWeapon(player, 9)
takeWeapon(player, 42)
toggleControl(player, "fire", false)
toggleControl(player, "aim_weapon", false)
setElementModel(player, getElementData(player, "user:lastskin"))
outputChatBox("Zakończyłeś służbę w frakcji LSFD.", player)
else
rozpocznijnaliczanie(player)
setElementData(player, "frakcja", "LSFD")
setElementData(player, "frakcjarank", result[1].rank)
giveWeapon(player, 9, 9999)
giveWeapon(player, 42, 9999)
toggleControl(player, "fire", true)
toggleControl(player, "aim_weapon", true)
setElementData(player, "user:lastskin", getElementModel(player))
outputChatBox("Rozpocząłeś służbę w frakcji LSFD.", player)
end
else
outputChatBox("Nie jesteś zatrudniony w frakcji LSFD.", player)
end
end)

addEventHandler("onMarkerHit", liderPanel, function(player)
if not getElementData(player, "frakcja") == "LSFD" then return end
local result = exports.mysql:wykonaj("SELECT * FROM frakcje WHERE uid=? AND frakcja=?", getElementData(player, "dbid"), "LSFD")
if result[1].rank == 4 or result[1].rank == 3 then
outputChatBox("Komendy: /dodaj <id gracza>, <wyrzuc> <id gracza>, /edytuj <id gracza> <nowa ranga 1-3>", player)
setElementData(player, "liderpanel:on:LSFD", true)
else
outputChatBox("Nie jesteś w frakcji LSFD lub nie masz uprawnień do panelu.", player)
end
end)

addEventHandler("onMarkerLeave", liderPanel, function(player)
if not getElementData(player, "frakcja") == "LSFD" then return end
local result = exports.mysql:wykonaj("SELECT * FROM frakcje WHERE uid=? AND frakcja=?", getElementData(player, "dbid"), "LSFD")
if result[1].rank == 4 or result[1].rank == 3 then
setElementData(player, "liderpanel:on:LSFD", false)
end
end)

addCommandHandler("dodaj", function(plr, cmd, kto)
if getElementData(plr, "liderpanel:on:LSFD") then
if not kto then
outputChatBox("Użyj /dodaj <id gracza>", plr, 0, 255, 0)
return
end
local target = findPlayer(plr, kto)
if not target then return end
local result = exports.mysql:wykonaj("SELECT * FROM frakcje WHERE uid=? AND frakcja=?", getElementData(target, "dbid"), "LSFD")
if #result < 0 then
outputChatBox(""..getPlayerName(target).." znajduje się w tej frakcji.", plr)
return
end
outputChatBox("Dodano gracza "..getPlayerName(target).." do frakcji na rangę 1.", plr)
exports.mysql:wykonaj("INSERT INTO frakcje SET uid=?, frakcja=?, rank=?", getElementData(target, "dbid"), "LSFD", "1")
end
end)

addCommandHandler("wyrzuc", function(plr, cmd, kto)
if getElementData(plr, "liderpanel:on:LSFD") then
if not kto then
outputChatBox("Użyj /wyrzuc <id gracza>", plr, 0, 255, 0)
return
end
local target = findPlayer(plr, kto)
if not target then return end
local result = exports.mysql:wykonaj("SELECT * FROM frakcje WHERE uid=? AND frakcja=?", getElementData(target, "dbid"), "LSFD")
if #result < 0 then
outputChatBox(""..getPlayerName(target).." znajduje nie się w tej frakcji.", plr)
return
end
outputChatBox("Usunięto gracza "..getPlayerName(target).." z frakcji.", plr)
exports.mysql:wykonaj("DELETE FROM frakcje WHERE frakcja=? AND uid=?", "LSFD", getElementData(target, "dbid"))
end
end)

addCommandHandler("edytuj", function(plr, cmd, kto, ranga)
if getElementData(plr, "liderpanel:on:LSFD") then
if not kto then
outputChatBox("Użyj /edytuj <id gracza>", plr, 0, 255, 0)
return
end
local target = findPlayer(plr, kto)
if not target then return end
local result = exports.mysql:wykonaj("SELECT * FROM frakcje WHERE uid=? AND frakcja=?", getElementData(target, "dbid"), "LSFD")
if #result < 0 then
outputChatBox(""..getPlayerName(target).." nie znajduje się w tej frakcji.", plr)
return
end
outputChatBox("Edytowano gracza "..getPlayerName(target)..".", plr)
exports.mysql:wykonaj("UPDATE frakcje SET rank=? WHERE uid=?", ranga, getElementData(target, "dbid"))
end
end)

local pojazdy = {
{407,2642.22, -2350.88, 13.87, 180.2,"Los Santos Fire Departament\n301[LS]21"},
{407,2641.99, -2361.48, 13.87, 180.2,"Los Santos Fire Departament\n301[LS]22"},
{407,2650.62, -2351.18, 13.87, 180.2,"Los Santos Fire Departament\n301[LS]25"},
{407,2650.70, -2361.21, 13.87, 180.2,"Los Santos Fire Departament\n301[LS]51"},
{552,2684.74, -2364.31, 13.33, 180.2,"Los Santos Fire Departament\n301[LS]43"},
{552,2681.14, -2364.24, 13.33, 180.2,"Los Santos Fire Departament\n301[LS]43"},
{611,2685.42, -2351.29, 13.33, 180.2,"Los Santos Fire Departament"},
{611,2681.37, -2351.44, 13.33, 180.2,"Los Santos Fire Departament"},
{544,2658.97, -2354.12, 13.87, 180.2,"Los Santos Fire Departament\n301[LS]91"},
{544,2658.82, -2365.28, 13.87, 180.2,"Los Santos Fire Departament\n301[LS]61"},
{500,2676.16, -2351.14, 13.74, 180.2,"Los Santos Fire Departament\n302[LS]90"},
--{560,2673.12, -2358.91, 13.34, 180.2,"Los Santos Fire Departament\n301[LS]94"},
--{554,1709.21, -1099.65, 24.10, 90.7,"Los Santos Fire Departament\n301[LS]71"},
--{489,1719.18, -1103.05, 24.15, 90.7,"Los Santos Fire Departament\n301[LS]98"},
--{471,1720.29, -1099.38, 23.76, 90.7,"Los Santos Fire Departament\n301[LS]72"},
--{468,1716.09, -1099.47, 23.75, 90.7,"Los Santos Fire Departament\n301[LS]73"},
{560, 16.77, 1547.17, 13.26, 180.0,"Los Santos Fire Departament\n301[LS]74"},
{560, 20.28, 1547.23, 13.26, 180.0,"San Andreas Fire Departament\n301[LS]75"},
{413, 20.28, 1554.29, 13.68, 180.0,"San Andreas Fire Departament\n301[LS]55"},
{413, 16.67, 1554.30, 13.68, 180.0,"San Andreas Fire Departament \n301[LS]55"},
}

local LSFD = createBlip(2662.05, -2380.02, 13.63, 20)

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
setVehicleSirens(vehicle, 1, -0.800, 2.900, 0.000, 255, 255, 255, 255, 255 )
setVehicleSirens(vehicle, 2, 0.800, 2.900, 0.000, 255, 255, 255, 255, 255 )
setVehicleSirens(vehicle, 3, -0.900, -3.700, -0.500, 255, 0, 0, 255, 255 )
setVehicleSirens(vehicle, 4, 0.900, -3.700, -0.500, 255, 0, 0, 255, 255 )
setVehicleSirens(vehicle, 5, -0.250, 1.000, 1.300, 255, 0, 0, 255, 255 )
setVehicleSirens(vehicle, 6, 0.250, 1.000, 1.300, 0, 0, 255, 255, 255 )
elseif v[1] == 407 then
ekwipunek = createMarker(0,0,0,"cylinder", 1, 255,0,0,0)
attachElements(ekwipunek, vehicle, -1.5,0,-0.5)
addEventHandler("onMarkerHit", ekwipunek, function(player)
if getElementData(player,"frakcja") == "LSFD" then
triggerClientEvent(player,"oknoEkwipunku", source)
end
end)
setVehicleHandling(vehicle, "engineAcceleration", acceleration+3)
setVehicleHandling(vehicle, "maxVelocity", velocity+30)
setVehicleHandling(vehicle, "steeringLock", 40)
setVehicleHandling(vehicle, "driveType", "awd")
removeVehicleSirens(vehicle)
addVehicleSirens(vehicle, 8, 2, true, false, true, true )
addVehicleSirens(vehicle, 6, 2, true, false, true, true )
setVehicleSirens(vehicle, 1, -0.800, 4.000, -0.200, 255, 255, 255, 255, 255 )
setVehicleSirens(vehicle, 2, 0.800, 4.000, -0.200, 255, 255, 255, 255, 255 )
setVehicleSirens(vehicle, 3, -0.900, -3.550, 0.100, 255, 0, 0, 255, 255 )
setVehicleSirens(vehicle, 4, 0.900, -3.550, 0.100, 255, 0, 0, 255, 255 )
setVehicleSirens(vehicle, 5, -0.600, 3.200, 1.270, 255, 0, 0, 255, 255 )
setVehicleSirens(vehicle, 6, 0.600, 3.200, 1.270, 0, 0, 255, 255, 255 )
elseif v[1] == 544 then
setVehicleHandling(vehicle, "engineAcceleration", acceleration+1.5)
setVehicleHandling(vehicle, "maxVelocity", velocity+30)
setVehicleHandling(vehicle, "steeringLock", 40)
setVehicleHandling(vehicle, "driveType", "awd")
removeVehicleSirens(vehicle)
addVehicleSirens(vehicle, 8, 2, true, false, true, true )
addVehicleSirens(vehicle, 6, 2, true, false, true, true )
setVehicleSirens(vehicle, 1, -0.800, 4.000, -0.200, 255, 255, 255, 255, 255 )
setVehicleSirens(vehicle, 2, 0.800, 4.000, -0.200, 255, 255, 255, 255, 255 )
setVehicleSirens(vehicle, 3, -0.900, -3.550, 0.100, 255, 0, 0, 255, 255 )
setVehicleSirens(vehicle, 4, 0.900, -3.550, 0.100, 255, 0, 0, 255, 255 )
elseif v[1] == 413 then
setVehicleHandling(vehicle, "engineAcceleration", acceleration+1.5)
setVehicleHandling(vehicle, "maxVelocity", velocity+30)
setVehicleHandling(vehicle, "steeringLock", 40)
setVehicleHandling(vehicle, "driveType", "awd")
removeVehicleSirens(vehicle)
addVehicleSirens(vehicle, 8, 2, true, false, true, true )
addVehicleSirens(vehicle, 6, 2, true, false, true, true )
setVehicleSirens(vehicle, 1, -0.800, 3.000, 0.000, 255, 255, 255, 255, 255 )
setVehicleSirens(vehicle, 2, 0.800, 3.000, 0.000, 255, 255, 255, 255, 255 )
setVehicleSirens(vehicle, 3, -1.050, -3.200, 0.100, 255, 0, 0, 255, 255 )
setVehicleSirens(vehicle, 4, 1.050, -3.200, 0.100, 255, 0, 0, 255, 255 )
elseif v[1] == 560 then
setVehicleHandling(vehicle, "engineAcceleration", acceleration+4)
setVehicleHandling(vehicle, "maxVelocity", velocity+20)
setVehicleHandling(vehicle, "steeringLock", 40)
setVehicleHandling(vehicle, "driveType", "awd")
removeVehicleSirens(vehicle)
addVehicleSirens(vehicle, 8, 2, true, false, true, true )
addVehicleSirens(vehicle, 6, 2, true, false, true, true )
setVehicleSirens(vehicle, 1, -0.800, 2.400, 0.000, 255, 255, 255, 255, 255 )
setVehicleSirens(vehicle, 2, 0.800, 2.400, 0.000, 255, 255, 255, 255, 255 )
setVehicleSirens(vehicle, 3, -0.900, -2.100, 0.000, 255, 0, 0, 255, 255 )
setVehicleSirens(vehicle, 4, 0.900, -2.100, 0.000, 255, 0, 0, 255, 255 )
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
setVehicleColor(vehicle,255,0,0,255,255,255)
setElementData(vehicle,"vehicle:LSFD", true)
--addVehicleUpgrade(vehicle, 1025)
end

addEventHandler("onVehicleStartEnter", resourceRoot, function(plr, seat, jacked)
if seat ~= 0 then return end
if getElementData(plr, "frakcja") == "LSFD" then
else
cancelEvent()
outputChatBox("Nie pracujesz w LSFD", plr)
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

addEvent("dajskinLSFD1", true)
addEventHandler("dajskinLSFD1", root, function()
setElementModel(source, 277)
end)

addEvent("dajskinLSFD2", true)
addEventHandler("dajskinLSFD2", root, function()
setElementModel(source, 278)
end)

addEvent("dajskinLSFD3", true)
addEventHandler("dajskinLSFD3", root, function()
setElementModel(source, 201)
end)

addEvent("dajskinLSFD4", true)
addEventHandler("dajskinLSFD4", root, function()
setElementModel(source, 272)
end)

addEvent("dajGasnice", true)
addEventHandler("dajGaśnice", root, function()
giveWeapon(source, 42, 9999)
end)

addEvent("dajPile", true)
addEventHandler("dajPile", root, function()
giveWeapon(source, 9, 9999)
end)

addEvent("dajR1", true)
addEventHandler("dajR1", root, function()
if not getElementData(source,"ONr1") == 1 then
setElementData(source, "ONr1", 1)
case = createObject(1210,0,0,0)
exports.bone_attach:attachElementToBone(case, source, 12,0,0.05,0.27,0,180,0)
else
setElementData(source, "ONr1", false)
destroyElement( case )
setElementData(source, "ONr1", false)
end
end)

local cases = {}

addEvent("torbaR1", true)
addEventHandler("torbaR1", root, function()
	if getElementData(source, "torba") ~= 1 then
		setElementData(source, "torba", 1)
		local case = createObject(1210,0,0,0)
		exports.bone_attach:attachElementToBone(case, source, 12,0,0.05,0.27,0,180,0)
		cases[source] = case
	elseif getElementData(source, "torba") == 1 then
		setElementData(source, "torba", false)
		exports.bone_attach:detachElementFromBone(cases[source])
		destroyElement(cases[source])
	end
end)


-------------------------------------[[              BRAMY           ]]-------------------

function isPlayerInFactionx(plr)
	local uid=getElementData(plr,'dbid')
	if not uid then return end

	local result=exports.mysql:wykonaj('SELECT 1 FROM frakcje WHERE frakcja=? AND uid=? LIMIT 1;', "PSP", uid)
	if result[1] then
		return true
	else
		return false
	end
end

local gatex = createObject(2909, 1698.70, -1148.82, 24.10, 0, 0, 90)
local markerx = createMarker(1698.35, -1147.30, 23.93-1,"cylinder",15,0,0,255,0)

function otworzx(plr)
if isPlayerInFactionx(plr) then
moveObject(gatex,2000,1707.28, -1148.87, 23.89)
setTimer(function()
moveObject(gatex,2000,1698.70, -1148.82, 24.10)
end, 8000, 1)
end
end
addEventHandler("onMarkerHit",markerx,otworzx)

function isPlayerInFactionx(plr)
	local uid=getElementData(plr,'dbid')
	if not uid then return end

	local result=exports.mysql:wykonaj('SELECT 1 FROM frakcje WHERE frakcja=? AND uid=? LIMIT 1;', "PSP", uid)
	if result[1] then
		return true
	else
		return false
	end
end

local gatex = createObject(10575, 1797.98, -1095.74, 25.08, 0, 0, 90)
local markerx = createMarker(1797.83, -1095.59, 24.08-1,"cylinder",7,0,0,255,0)

function otworzx(plr)
if isPlayerInFactionx(plr) then
moveObject(gatex,2000,1797.98, -1095.74, 19.08)
setTimer(function()
moveObject(gatex,2000,1797.98, -1095.74, 25.08)
end, 5000, 1)
end
end
addEventHandler("onMarkerHit",markerx,otworzx)


function isPlayerInFactionx(plr)
	local uid=getElementData(plr,'dbid')
	if not uid then return end

	local result=exports.mysql:wykonaj('SELECT 1 FROM frakcje WHERE frakcja=? AND uid=? LIMIT 1;', "PSP", uid)
	if result[1] then
		return true
	else
		return false
	end
end

local gatex = createObject(10575, 1780.92, -1095.78, 25.08, 0, 0, 90)
local markerx = createMarker(1780.92, -1095.78, 24.08-1,"cylinder",7,0,0,255,0)

function otworzx(plr)
if isPlayerInFactionx(plr) then
moveObject(gatex,2000,1780.92, -1095.78, 19.08)
setTimer(function()
moveObject(gatex,2000,1780.92, -1095.78, 25.08)
end, 5000, 1)
end
end
addEventHandler("onMarkerHit",markerx,otworzx)


function isPlayerInFactionx(plr)
	local uid=getElementData(plr,'dbid')
	if not uid then return end

	local result=exports.mysql:wykonaj('SELECT 1 FROM frakcje WHERE frakcja=? AND uid=? LIMIT 1;', "PSP", uid)
	if result[1] then
		return true
	else
		return false
	end
end

local gatex = createObject(10575, 1763.65, -1095.50, 25.09, 0, 0, 90)
local markerx = createMarker(1763.57, -1095.95, 24.09-1,"cylinder",7,0,0,255,0)

function otworzx(plr)
if isPlayerInFactionx(plr) then
moveObject(gatex,2000,1763.65, -1095.80, 19.09)
setTimer(function()
moveObject(gatex,2000,1763.65, -1095.80, 25.09)
end, 5000, 1)
end
end
addEventHandler("onMarkerHit",markerx,otworzx)

function isPlayerInFactionx(plr)
	local uid=getElementData(plr,'dbid')
	if not uid then return end

	local result=exports.mysql:wykonaj('SELECT 1 FROM frakcje WHERE frakcja=? AND uid=? LIMIT 1;', "PSP", uid)
	if result[1] then
		return true
	else
		return false
	end
end

local gatex = createObject(10575, 1746.74, -1095.63, 25.08, 0, 0, 90)
local markerx = createMarker(1746.74, -1095.63, 24.08-1,"cylinder",7,0,0,255,0)

function otworzx(plr)
if isPlayerInFactionx(plr) then
moveObject(gatex,2000,1746.74, -1095.63, 19.08)
setTimer(function()
moveObject(gatex,2000,1746.74, -1095.63, 25.08)
end, 5000, 1)
end
end
addEventHandler("onMarkerHit",markerx,otworzx)

function isPlayerInFactionx(plr)
	local uid=getElementData(plr,'dbid')
	if not uid then return end

	local result=exports.mysql:wykonaj('SELECT 1 FROM frakcje WHERE frakcja=? AND uid=? LIMIT 1;', "PSP", uid)
	if result[1] then
		return true
	else
		return false
	end
end

local gatex = createObject(10575, 1732.40, -1095.60, 25.09, 0, 0, 90)
local markerx = createMarker(1732.76, -1095.49, 24.09-1,"cylinder",7,0,0,255,0)

function otworzx(plr)
if isPlayerInFactionx(plr) then
moveObject(gatex,2000,1732.40, -1095.30, 19.09)
setTimer(function()
moveObject(gatex,2000,1732.40, -1095.30, 25.09)
end, 5000, 1)
end
end
addEventHandler("onMarkerHit",markerx,otworzx)

function isPlayerInFactionx(plr)
	local uid=getElementData(plr,'dbid')
	if not uid then return end

	local result=exports.mysql:wykonaj('SELECT 1 FROM frakcje WHERE frakcja=? AND uid=? LIMIT 1;', "PSP", uid)
	if result[1] then
		return true
	else
		return false
	end
end

local gatex = createObject(10575, 1704.18, -1101.50, 25.08, 0, 0, 0)
local markerx = createMarker(1704.18, -1101.79, 24.08-1,"cylinder",7,0,0,255,0)

function otworzx(plr)
if isPlayerInFactionx(plr) then
moveObject(gatex,2000,1704.18, -1101.50, 19.08)
setTimer(function()
moveObject(gatex,2000,1704.18, -1101.50, 25.08)
end, 5000, 1)
end
end
addEventHandler("onMarkerHit",markerx,otworzx)


function isPlayerInFactionx(plr)
	local uid=getElementData(plr,'dbid')
	if not uid then return end

	local result=exports.mysql:wykonaj('SELECT 1 FROM frakcje WHERE frakcja=? AND uid=? LIMIT 1;', "PSP", uid)
	if result[1] then
		return true
	else
		return false
	end
end

local gatex = createObject(3089, 1729.12, -1141.17, 24.40, 0, 0, 0)
local markerx = createMarker(1730.51, -1141.37, 24.09-1,"cylinder",7,0,0,255,0)

function otworzx(plr)
if isPlayerInFactionx(plr) then
moveObject(gatex,2000,1727.12, -1141.17, 24.40)
setTimer(function()
moveObject(gatex,2000,1729.12, -1141.17, 24.40)
end, 5000, 1)
end
end
addEventHandler("onMarkerHit",markerx,otworzx)

function isPlayerInFactionx(plr)
	local uid=getElementData(plr,'dbid')
	if not uid then return end

	local result=exports.mysql:wykonaj('SELECT 1 FROM frakcje WHERE frakcja=? AND uid=? LIMIT 1;', "PSP", uid)
	if result[1] then
		return true
	else
		return false
	end
end

local gatex = createObject(3089, 1732.10, -1141.17, 24.40, 0, 0, 180)
local markerx = createMarker(1730.51, -1141.37, 24.09-1,"cylinder",7,0,0,255,0)

function otworzx(plr)
if isPlayerInFactionx(plr) then
moveObject(gatex,2000,1734.10, -1141.17, 24.40)
setTimer(function()
moveObject(gatex,2000,1732.10, -1141.17, 24.40)
end, 5000, 1)
end
end
addEventHandler("onMarkerHit",markerx,otworzx)

addCommandHandler("zabierzpily", function()
takeWeapon(root, 9)
takeWeapon(root, 42)
end)