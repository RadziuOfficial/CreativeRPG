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

local rozpoczecie = createMarker(-2444.06, 3786.76, 300.57-0.9, "cylinder", 1.2, 0, 255, 255, 75)
local napisy = createElement("text")
setElementData(napisy, "text", "Służba")
setElementPosition(napisy, -2444.06, 3786.76, 300.57)

local liderPanel = createMarker(-2474.83, 3784.78, 300.57-0.9, "cylinder", 1, 0, 255, 255, 75)
local napisy2 = createElement("text")
setElementData(napisy2, "text", "Panel lidera")
setElementPosition(napisy2, -2474.83, 3784.78, 300.57)

addEventHandler("onMarkerHit", rozpoczecie, function(player)
local result = exports.mysql:wykonaj("SELECT * FROM frakcje WHERE uid=? AND frakcja=?", getElementData(player, "dbid"), "SAPD")
if #result > 0 then
if getElementData(player, "frakcja") then
zatrzymajnaliczanie(player)
setElementData(player, "frakcja", false)
setElementData(player, "frakcjarank", false)
takeWeapon(player, 31)
takeWeapon(player, 3)
takeWeapon(player, 23)
toggleControl(player, "fire", false)
toggleControl(player, "aim_weapon", false)
setElementModel(player, getElementData(player, "user:lastskin"))
outputChatBox("Zakończyłeś służbę w frakcji San Andreas Police Departament.", player)
else
rozpocznijnaliczanie(player)
setElementData(player, "frakcja", "SAPD")
setElementData(player, "frakcjarank", result[1].rank)
giveWeapon(player, 31, 9999)
giveWeapon(player, 3, 9999)
giveWeapon(player, 23, 9999)
toggleControl(player, "fire", true)
toggleControl(player, "aim_weapon", true)
setElementData(player, "user:lastskin", getElementModel(player))
outputChatBox("Rozpocząłeś służbę w frakcji San Andreas Police Departament.", player)
end
else
outputChatBox("Nie jesteś zatrudniony w frakcji San Andreas Police Departament.", player)
end
end)

addEventHandler("onMarkerHit", liderPanel, function(player)
if not getElementData(player, "frakcja") == "SAPD" then return end
local result = exports.mysql:wykonaj("SELECT * FROM frakcje WHERE uid=? AND frakcja=?", getElementData(player, "dbid"), "SAPD")
if result[1].rank == 4 or result[1].rank == 3 then
outputChatBox("Komendy: /dodaj <id gracza>, <wyrzuc> <id gracza>, /edytuj <id gracza> <nowa ranga 1-3>", player)
setElementData(player, "liderpanel:on:SAPD", true)
else
outputChatBox("Nie jesteś w frakcji San Andreas Police Departament lub nie masz uprawnień do panelu.", player)
end
end)

addEventHandler("onMarkerLeave", liderPanel, function(player)
if not getElementData(player, "frakcja") == "SAPD" then return end
local result = exports.mysql:wykonaj("SELECT * FROM frakcje WHERE uid=? AND frakcja=?", getElementData(player, "dbid"), "SAPD")
if result[1].rank == 4 or result[1].rank == 3 then
setElementData(player, "liderpanel:on:SAPD", false)
end
end)

addCommandHandler("dodaj", function(plr, cmd, kto)
if getElementData(plr, "liderpanel:on:SAPD") then
if not kto then
outputChatBox("Użyj /dodaj <id gracza>", plr, 0, 255, 0)
return
end
local target = findPlayer(plr, kto)
if not target then return end
local result = exports.mysql:wykonaj("SELECT * FROM frakcje WHERE uid=? AND frakcja=?", getElementData(target, "dbid"), "SAPD")
if #result < 0 then
outputChatBox(""..getPlayerName(target).." znajduje się w tej frakcji.", plr)
return
end
outputChatBox("Dodano gracza "..getPlayerName(target).." do frakcji na rangę 1.", plr)
exports.mysql:wykonaj("INSERT INTO frakcje SET uid=?, frakcja=?, rank=?", getElementData(target, "dbid"), "SAPD", "1")
end
end)

addCommandHandler("wyrzuc", function(plr, cmd, kto)
if getElementData(plr, "liderpanel:on:SAPD") then
if not kto then
outputChatBox("Użyj /wyrzuc <id gracza>", plr, 0, 255, 0)
return
end
local target = findPlayer(plr, kto)
if not target then return end
local result = exports.mysql:wykonaj("SELECT * FROM frakcje WHERE uid=? AND frakcja=?", getElementData(target, "dbid"), "SAPD")
if #result < 0 then
outputChatBox(""..getPlayerName(target).." znajduje nie się w tej frakcji.", plr)
return
end
outputChatBox("Usunięto gracza "..getPlayerName(target).." z frakcji.", plr)
exports.mysql:wykonaj("DELETE FROM frakcje WHERE frakcja=? AND uid=?", "SAPD", getElementData(target, "dbid"))
end
end)

addCommandHandler("edytuj", function(plr, cmd, kto, ranga)
if getElementData(plr, "liderpanel:on:SAPD") then
if not kto then
outputChatBox("Użyj /edytuj <id gracza>", plr, 0, 255, 0)
return
end
local target = findPlayer(plr, kto)
if not target then return end
local result = exports.mysql:wykonaj("SELECT * FROM frakcje WHERE uid=? AND frakcja=?", getElementData(target, "dbid"), "SAPD")
if #result < 0 then
outputChatBox(""..getPlayerName(target).." nie znajduje się w tej frakcji.", plr)
return
end
outputChatBox("Edytowano gracza "..getPlayerName(target)..".", plr)
exports.mysql:wykonaj("UPDATE frakcje SET rank=? WHERE uid=?", ranga, getElementData(target, "dbid"))
end
end)

local pojazdy = {
{596,-1572.45, 742.57, -5.52, 89.0,"SAPD[SA]001"}, --LSPD car
{596,-1572.40, 738.71, -5.52, 89.0,"SAPD[SA]002"},
{596,-1572.43, 734.68, -5.52, 89.0,"SAPD[SA]003"},
{596,-1572.51, 730.80, -5.52, 89.0,"SAPD[SA]004"},
{596,-1572.48, 726.35, -5.52, 89.0,"SAPD[SA]005"},
{596,-1572.67, 722.44, -5.52, 89.0,"SAPD[SA]005"},
{596,-1572.73, 718.13, -5.52, 89.0,"SAPD[SA]005"},
{596,-1572.57, 713.98, -5.52, 89.0,"SAPD[SA]005"},
{596,-1572.72, 710.17, -5.52, 89.0,"SAPD[SA]005"},
{596,-1572.68, 706.09, -5.52, 89.0,"SAPD[SA]005"},


{597,1544.76, -1662.98, 5.66, 90.7,"SAPD[Akademia]001"},
{597,1544.76, -1658.98, 5.66, 90.7,"SAPD[Akademia]002"},
{597,1544.76, -1654.98, 5.66, 90.7,"SAPD[Akademia]003"},
{597,1544.76, -1650.98, 5.66, 90.7,"SAPD[Akademia]004"},
{426,1539.00, -1644.63, 5.63, 180.7,""},
{426,1534.84, -1644.63, 5.63, 180.7,""},
{421,1530.30, -1644.63, 5.63, 180.7,""},
{421,1526.30, -1644.63, 5.63, 180.7,""},
{560,-1639.71, 686.34, -5.54, 272.3,""},
{560,-1639.50, 682.07, -5.54, 272.3,""},
{560,-1639.36, 677.65, -5.54, 272.3,""},
{525,1581.78, -1606.16, 13.60, 180.0,"SAPD[Holownik]001"},
{525,1585.10, -1606.25, 13.59, 180.0,"SAPD[Holownik]002"},
{525,1588.58, -1606.08, 13.60, 180.0,"SAPD[Holownik]002"},
{525,1591.94, -1606.38, 13.59, 180.0,"SAPD[Holownik]002"},
{427,1564.61, -1710.33, 6.02, 0.0,""},
{523,1534.48, -1694.68, 5.46, 180.0,"SAPD[SA]021"},
{523,1537.41, -1702.16, 5.46, 212.0,"SAPD[SA]022"},
{523,1540.88, -1707.07, 5.46, 218.0,"SAPD[SA]023"},
{431,1563.15, -1633.42, 13.57, 90.0,"SAPD[Autobus-Szkoleniowy]"},
{497,1548.66, -1609.61, 13.56, 270.1,"SAPD[SA]Jednostka Lotnicza"},
{402, 1558.41, -1712.18, 5.57, 0, ""},
{599, 1528.09, -1687.57, 6.14, 270, ""},
{599, 1527.87, -1683.35, 6.14, 270, ""},
{598,1583.36, -1710.41, 5.64, 359.6,"SAPD[POSCIG]001"},
{598,1587.38, -1710.20, 5.64, 359.6,"SAPD[POSCIG]002"},
{598,1591.55, -1710.47, 5.64, 359.6,"SAPD[POSCIG]003"},
{598,1595.54, -1710.05, 5.64, 359.6,"SAPD[POSCIG]004"},
{411,1570.24, -1694.54, 5.62, 0.0, "SAPD[ZARZAD]001"},
{428,1562.45, -1694.39, 6.02, 0.3, "SAPD[TRANSPORTER]001"},
}

local SAPD = createBlip(-1572.45, 742.57, -5.52, 30)

for _,v in ipairs(pojazdy)do
local vehicle = createVehicle(v[1], v[2], v[3], v[4], 0, 0, v[5])
local acceleration = getVehicleHandling(vehicle).engineAcceleration
local velocity = getVehicleHandling(vehicle).maxVelocity
local mass = getVehicleHandling(vehicle).mass
local turnmass = getVehicleHandling(vehicle).turnMass
local mutlipiler = getVehicleHandling(vehicle).tractionMultiplier
local coef = getVehicleHandling(vehicle).dragCoeff
if v[1] == 598 then
addVehicleUpgrade(vehicle, 1025)
setVehicleHandling(vehicle, "maxVelocity", 215)
setVehicleHandling(vehicle, "engineAcceleration", acceleration+9.50)
setVehicleHandling(vehicle, "steeringLock", 85)
setVehicleHandling(vehicle, "brakeDeceleration", 115)
setVehicleHandling(vehicle, "driveType", "awd")
setVehicleColor(vehicle, 255, 255,255, 0, 5,40)
setElementData(vehicle,"zawieszenie",1)
removeVehicleSirens(vehicle)
addVehicleSirens(vehicle, 3, 2, true, false, true, true)
setVehicleSirens(vehicle, 1, 0, -0.3, 0.9, 255, 255, 255, 198.9, 198.9)
setVehicleSirens(vehicle, 2, -0.5, -0.3, 0.9, 255, 0, 0, 200, 200)
setVehicleSirens(vehicle, 3, 0.6, -0.3, 0.9, 0, 0, 255, 200, 200)
elseif v[1] == 411 then
addVehicleUpgrade(vehicle, 1025)
setVehicleColor(vehicle, 0, 0, 0)
setElementData(vehicle,"veh:sapd",true)
removeVehicleSirens(vehicle)
addVehicleSirens(vehicle, 3, 2, true, false, true, true)
setVehicleSirens(vehicle, 1, -0.7, 2.7, -0.3, 255, 255, 255, 198.9, 198.9)
setVehicleSirens(vehicle, 2, 0.8, 2.7, -0.3, 255, 255, 255, 200, 200)
setVehicleSirens(vehicle, 3, -0.1, 0.6, 0.6, 0, 127.5, 255, 200, 200)
elseif v[1] == 428 then
addVehicleUpgrade(vehicle, 1025)
setVehicleColor(vehicle, 0,0,255,255,255,255)
setElementData(vehicle,"veh:sapd",true)
elseif v[1] == 596 then
addVehicleUpgrade(vehicle, 1025)
setVehicleHandling(vehicle, "engineAcceleration", acceleration+4)
setVehicleHandling(vehicle, "maxVelocity", velocity+50)
setVehicleHandling(vehicle, "steeringLock", 40)
setVehicleHandling(vehicle, "driveType", "awd")
setVehicleColor(vehicle, 0, 0, 80, 255, 255, 255)
removeVehicleSirens(vehicle)
addVehicleSirens(vehicle, 8, 2, true, false, true, true )
addVehicleSirens(vehicle, 6, 2, true, false, true, true )
setVehicleSirens(vehicle, 1, -0.800, 2.400, 0.000, 255, 255, 255, 255, 255 )
setVehicleSirens(vehicle, 2, 0.800, 2.400, 0.000, 255, 255, 255, 255, 255 )
setVehicleSirens(vehicle, 3, -0.900, -2.700, 0.000, 255, 0, 0, 255, 255 )
setVehicleSirens(vehicle, 4, 0.900, -2.700, 0.000, 255, 0, 0, 255, 255 )
setVehicleSirens(vehicle, 5, -0.600, -0.350, 0.930, 255, 0, 0, 255, 255 )
setVehicleSirens(vehicle, 6, 0.600, -0.350, 0.930, 0, 0, 255, 255, 255 )
elseif v[1] == 599 then
setVehicleHandling(vehicle, "engineAcceleration", acceleration+12)
setVehicleHandling(vehicle, "maxVelocity", 300)
setVehicleHandling(vehicle, "steeringLock", 40)
setVehicleHandling(vehicle, "driveType", "awd")
setElementData(vehicle,"veh:sapd", true)
elseif v[1] == 402 then
setVehicleColor(vehicle, 0, 0, 0, 255, 255, 255)
addVehicleUpgrade(vehicle, 1077)
setElementData(vehicle,"zawieszenie", 2)
setVehicleHandling(vehicle, "engineAcceleration", acceleration+10)
setVehicleHandling(vehicle, "maxVelocity", velocity+150)
setVehicleHandling(vehicle, "steeringLock", 40)
setVehicleHandling(vehicle, "driveType", "awd")
elseif v[1] == 597 then
addVehicleUpgrade(vehicle, 1025)
setVehicleColor(vehicle, 0, 50, 0, 255, 255, 255)
removeVehicleSirens(vehicle)
addVehicleSirens(vehicle, 8, 2, true, false, true, true )
addVehicleSirens(vehicle, 6, 2, true, false, true, true )
setVehicleSirens(vehicle, 1, -0.800, 2.400, 0.000, 255, 255, 255, 255, 255 )
setVehicleSirens(vehicle, 2, 0.800, 2.400, 0.000, 255, 255, 255, 255, 255 )
setVehicleSirens(vehicle, 3, -0.900, -2.700, 0.000, 255, 0, 0, 255, 255 )
setVehicleSirens(vehicle, 4, 0.900, -2.700, 0.000, 255, 0, 0, 255, 255 )
setVehicleSirens(vehicle, 5, -0.600, -0.350, 0.930, 255, 0, 0, 255, 255 )
setVehicleSirens(vehicle, 6, 0.600, -0.350, 0.930, 0, 0, 255, 255, 255 )
elseif v[1] == 560 then
addVehicleUpgrade(vehicle, 1025)
setVehicleHandling(vehicle, "engineAcceleration", acceleration+8)
setVehicleHandling(vehicle, "maxVelocity", velocity+150)
setVehicleHandling(vehicle, "steeringLock", 45)
setVehicleHandling(vehicle, "driveType", "awd")
setVehicleColor(vehicle, 0, 0, 0, 255, 255, 255)
removeVehicleSirens(vehicle)
addVehicleSirens(vehicle, 6, 2, true, false, true, true)
setVehicleSirens(vehicle, 1, -0.7, 2.5, -0.3, 0, 127.5, 255, 198.9, 198.9)
setVehicleSirens(vehicle, 2, 0.8, 2.5, -0.3, 255, 0, 0, 198.9, 198.9)
setVehicleSirens(vehicle, 3, 0.2, 0.4, 0.6, 0, 127.5, 255, 255, 255)
setVehicleSirens(vehicle, 4, -0.1, 0.4, 0.6, 255, 0, 0, 198.9, 198.9)
setVehicleSirens(vehicle, 5, 0.8, -2.3, 0.2, 255, 0, 0, 200, 200)
setVehicleSirens(vehicle, 6, -0.7, -2.3, 0.2, 255, 0, 0, 200, 200)
setElementData(vehicle,"zawieszenie",2)
setElementData(vehicle,"veh:sapd", true)
addVehicleUpgrade(vehicle, 1147)
addVehicleUpgrade(vehicle, 1031)
addVehicleUpgrade(vehicle, 1033)
addVehicleUpgrade(vehicle, 1010)
addVehicleUpgrade(vehicle, 1098)
addVehicleUpgrade(vehicle, 1029)
addVehicleUpgrade(vehicle, 1070)
addVehicleUpgrade(vehicle, 1141)
elseif v[1] == 426 then
addVehicleUpgrade(vehicle, 1025)
setVehicleHandling(vehicle, "engineAcceleration", acceleration+8)
setVehicleHandling(vehicle, "maxVelocity", velocity+150)
setVehicleHandling(vehicle, "steeringLock", 45)
setVehicleHandling(vehicle, "driveType", "awd")
setVehicleColor(vehicle, 50, 50, 50, 255, 255, 255)
removeVehicleSirens(vehicle)
addVehicleSirens(vehicle, 6, 2, true, false, true, true)
setVehicleSirens(vehicle, 1, -0.3, 2.5, 0, 0, 127.5, 255, 198.9, 198.9)
setVehicleSirens(vehicle, 2, 0.2, 2.5, 0, 0, 127.5, 255, 200, 200)
setVehicleSirens(vehicle, 3, 0, 0.4, 0.6, 0, 127.5, 255, 255, 255)
setVehicleSirens(vehicle, 4, 0, -1.7, 0.4, 0, 117.3, 255, 198.9, 198.9)
setVehicleSirens(vehicle, 5, 0.8, -2.8, 0, 255, 0, 0, 200, 200)
setVehicleSirens(vehicle, 6, -0.7, -2.8, 0, 255, 0, 0, 200, 200)
setElementData(vehicle,"veh:sapd", true)
elseif v[1] == 421 then
addVehicleUpgrade(vehicle, 1025)
setVehicleHandling(vehicle, "engineAcceleration", acceleration+8)
setVehicleHandling(vehicle, "maxVelocity", velocity+150)
setVehicleHandling(vehicle, "steeringLock", 45)
setVehicleHandling(vehicle, "driveType", "awd")
setVehicleColor(vehicle, 50, 50, 50, 255, 255, 255)
removeVehicleSirens(vehicle)
addVehicleSirens(vehicle, 6, 2, true, false, true, true)
setVehicleSirens(vehicle, 1, -0.7, 2.5, -0.1, 255, 255, 255, 198.9, 198.9)
setVehicleSirens(vehicle, 2, 0.6, 2.5, -0.1, 255, 255, 255, 198.9, 198.9)
setVehicleSirens(vehicle, 3, 0.2, 0.4, 0.6, 0, 127.5, 255, 255, 255)
setVehicleSirens(vehicle, 4, -0.1, 0.4, 0.6, 0, 117.3, 255, 198.9, 198.9)
setVehicleSirens(vehicle, 5, 0.8, -2.8, -0.1, 255, 0, 0, 200, 200)
setVehicleSirens(vehicle, 6, -0.9, -2.8, -0.1, 255, 0, 0, 200, 200)
setElementData(vehicle,"veh:sapd", true)
elseif v[1] == 427 then
addVehicleUpgrade(vehicle, 1025)
removeVehicleSirens(vehicle)
addVehicleSirens(vehicle, 6, 2, true, false, true, true)
setVehicleSirens(vehicle, 1, -0.9, 3.3, -0.1, 255, 255, 255, 198.9, 198.9)
setVehicleSirens(vehicle, 2, 0.8, 3.3, -0.1, 255, 255, 255, 198.9, 198.9)
setVehicleSirens(vehicle, 3, 0.4, 1.1, 1.5, 255, 0, 0, 255, 255)
setVehicleSirens(vehicle, 4, -0.3, 1.1, 1.5, 255, 0, 0, 198.9, 198.9)
setVehicleSirens(vehicle, 5, 0.8, -3.9, 1.3, 0, 140.3, 255, 255, 255)
setVehicleSirens(vehicle, 6, -1, -3.9, 1.3, 255, 0, 0, 198.9, 198.9)
elseif v[1] == 525 then
addVehicleUpgrade(vehicle, 1025)
removeVehicleSirens(vehicle)
addVehicleSirens(vehicle, 5, 2, true, false, true, true)
setVehicleSirens(vehicle, 1, -0.9, 3.1, 0.4, 255, 255, 255, 198.9, 198.9)
setVehicleSirens(vehicle, 2, 0.8, 3.1, 0.4, 255, 255, 255, 198.9, 198.9)
setVehicleSirens(vehicle, 3, 0.6, -0.5, 1.5, 255, 0, 0, 255, 255)
setVehicleSirens(vehicle, 4, -0.5, -0.5, 1.5, 255, 0, 0, 198.9, 198.9)
setVehicleSirens(vehicle, 5, 0, -0.5, 1.5, 255, 117.3, 0, 255, 255)
end
setElementData(vehicle, "nametag", v[6])
setElementFrozen(vehicle, true)
end

addEventHandler("onVehicleStartEnter", resourceRoot, function(plr, seat, jacked)
if seat ~= 0 then return end
if getElementData(plr, "frakcja") == "SAPD" then
else
cancelEvent()
outputChatBox("Nie pracujesz w SAPD", plr)
end
end)


function mandat(plr, cmd, kto, ile)
	if getElementData(plr, "frakcja") ~= "SAPD" then return end
	if not kto or not ile then
		outputChatBox("#4343ffUżyj: #eeeeee/"..cmd.." [ID/Nazwa gracza] [ilosc]", plr, 255, 255, 255, true)
		return
	end
	local target = findPlayer(plr, kto)
	if not target then return end
	local kasa2 = getElementData(target, "pieniadze")
	local ile = tonumber(ile)
	if kasa2 < ile then
	outputChatBox("Gracza nie stać na mandat.", plr, 255, 0, 0)
	return
	end
	if plr == target then
		outputChatBox("Nie możesz wystawić mandatu samemu sobie!", plr, 255, 0, 0)
		return
	end
	if ile < 1 then
		outputChatBox("Błąd", plr, 255, 0, 0)
		return
	end
	if ile > 10000 then
		outputChatBox("Błąd (max 10k)", plr, 255, 0, 0)
		return
	end
	local kasa = getElementData(plr, "pieniadze")
	local target_name = getPlayerName(target)
	local player_name = getPlayerName(plr)
	outputChatBox("Wystawiłeś mandat dla gracza "..target_name.." w cenie "..ile, plr, 255, 255, 255, true)
	setElementData(target, "pieniadze", kasa2-ile)
	setElementData(plr, "pieniadze", kasa+ile/2)
	outputChatBox("Gracz "..player_name.." wystawił ci mandat w cenie "..ile, target, 255, 255, 255, true)
end
addCommandHandler("mandat", mandat)


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

addEvent("dajskinSAPD1", true)
addEventHandler("dajskinSAPD1", root, function()
setElementModel(source, 71)
end)

addEvent("dajskinSAPD2", true)
addEventHandler("dajskinSAPD2", root, function()
setElementModel(source, 280)
end)

addEvent("dajskinSAPD3", true)
addEventHandler("dajskinSAPD3", root, function()
setElementModel(source, 282)
end)

addEvent("dajskinSAPD4", true)
addEventHandler("dajskinSAPD4", root, function()
setElementModel(source, 283)
end)

addEvent("dajskinSAPD5", true)
addEventHandler("dajskinSAPD5", root, function()
setElementModel(source, 286)
end)

addEvent("dajskinSAPD6", true)
addEventHandler("dajskinSAPD6", root, function()
setElementModel(source, 288)
end)


-------------------------------------[[              BRAMY           ]]-------------------


function isPlayerInFactionx(plr)
	local uid=getElementData(plr,'dbid')
	if not uid then return end

	local result=exports.mysql:wykonaj('SELECT 1 FROM frakcje WHERE frakcja=? AND uid=? LIMIT 1;', "SAPD", uid)
	if result[1] then
		return true
	else
		return false
	end
end

local gatex = createObject(975, 1544.70, -1628.50, 13.20, 0, 0, 90)
local markerx = createMarker(1545.34, -1627.48, 13.38-1,"cylinder",8,0,0,255,0)

function otworzx(plr)
if isPlayerInFactionx(plr) then
moveObject(gatex,2000,1544.70, -1628.50, 10.20)
setTimer(function()
moveObject(gatex,2000,1544.70, -1628.50, 13.20 )
end, 5000, 1)
end
end
addEventHandler("onMarkerHit",markerx,otworzx)

function zajebauto(laweta) 
setElementFrozen(source, false) 
end 
addEventHandler("onTrailerAttach", getRootElement(), zajebauto)