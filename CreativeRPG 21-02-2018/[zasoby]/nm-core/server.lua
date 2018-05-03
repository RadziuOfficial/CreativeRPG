--[[
	Autor: Asper
	Dla servera: .newMode
	Skrypt: Gamemode
]]

createBlip(-1705.29, 116.63, 3.55, 9,2,255,0,0,255,0,100)

local marker = createMarker(-1705.29, 116.63, 3.55-1.2, "cylinder", 1.5, 255, 0, 0, 125)
local text = createElement("text")
setElementData(text, "text", "Wyławiarka\nPojazdów")
setElementPosition(text, -1705.29, 116.63, 3.55-0.5)

addEventHandler("onMarkerHit", marker, function(hit)
	for i,v in ipairs(getElementsByType("vehicle")) do
		if getElementData(v, "wlasciciel") and getElementData(v, "wlasciciel") == getElementData(hit, "dbid") then
		 	if v and isElementInWater(v) then
				outputChatBox("Pojazdy w wodzie:", hit)
				outputChatBox("=================", hit)
				outputChatBox("Model: "..getVehicleName(v).." | ID: "..getElementData(v, "id"), hit)
				outputChatBox("=================", hit)
				outputChatBox("Aby wyjąć auta, wpisz /wyjmij [ id ]", hit)
			end
		end
	end
end)

addCommandHandler("wyjmij", function(player, _, id)
	if not isElementWithinMarker(player, marker) then return end
	for i,v in ipairs(getElementsByType("vehicle")) do
		if getElementData(v, "id") and getElementData(v, "id") == tonumber(id) and getElementData(v, "wlasciciel") and getElementData(v, "wlasciciel") == getElementData(player, "dbid") then
			outputChatBox("Auto o id: "..id.." zostało wyjęte z wody i zrespione obok ciebie.", player)
			setElementPosition(v, -1719.31, 104.58, 4.88)
		end
	end
end)

addEventHandler("onVehicleStartEnter", root, function(g, s)
	if s ~= 0 then return end
	if getVehicleController(source) and getVehicleController(source) ~= g then
		cancelEvent()
	end
end)

addEventHandler("onPlayerCommand", root, function(c)
	if not getElementData(source, "zalogowany") then
		if c == "Toggle" then return end
		cancelEvent()
	end
end)

local commandSpam = {}

addEventHandler("onPlayerCommand", root, function()
	if (not commandSpam[source]) then
		commandSpam[source] = 1
	elseif (commandSpam[source] == 10) then
	    cancelEvent()
        kickPlayer(source, "Console", "Spam komendami")
	else
		commandSpam[source] = commandSpam[source] + 1
	end
end)
setTimer(function() commandSpam = {} end, 1000, 0)

antiSpam = {}
function antiChatSpam()
if getElementData(source, "user:mute") then return end
	if isTimer(antiSpam[source]) then
		cancelEvent()
		setElementData(source, "user:mute",true)
		setTimer ( autoUnmute, 750, 1, source)
	else
		antiSpam[source] = setTimer(function(source) antiSpam[source] = nil end, 1000, 1, source)
	end
end
addEventHandler("onPlayerChat", root, antiChatSpam)

function autoUnmute ( player,plr,... )
	if getElementData(player, "user:mute") then
		setElementData(player, "user:mute",false)
	end
end

addEventHandler("onResourceStart", resourceRoot, function()
	setGameType("RPG - CreativeRPG")
	setRuleValue("gamemode", "CreativeRPG")
	setRuleValue("author", "RAD3K and AlteX")
	local time = getRealTime()
	setTime(time.hour, time.minute)
	setMinuteDuration(60000)
end)

addEventHandler("onPlayerWasted", root, function()
        if not getElementData(source,"strefadm") then
	local skin = getElementData(source, "skin")
	spawnPlayer(source, -2673.58, 631.34, 14.45, 0, skin, 0, 0)
     end
end)

function idRanga(g)
	local duty = getElementData(g, "duty")
	if duty and duty == 4 then
		return "#950000"
	elseif duty and duty == 3 then
		return "#FF0000"
	elseif duty and duty == 2 then
		return "#27DB0F"
	elseif duty and duty == 1 then
		return "#00FFFF"
	elseif getElementData(g, "premium") then
		return "#FFFF00"
	else
		return "#005EFE"
	end
end


addEventHandler("onPlayerChat", root, function(wiadomosc, typ)
	if typ == 0 then
		cancelEvent()
		local x, y, z = getElementPosition(source)
		local cuboid = createColSphere(x, y, z, 20)
		local wCuboid = getElementsWithinColShape(cuboid, "player")
		destroyElement(cuboid)
		for _, p in ipairs(wCuboid) do
			local nick = getPlayerName(source)
			local id = getElementData(source, "id") or 0
			local kolor = idRanga(source)
			wiadomosc = string.gsub(wiadomosc, "#%x%x%x%x%x%x", "")
			local info = "#ffffff["..kolor..""..id.."#ffffff] "..nick..": "..wiadomosc
			outputChatBox(info, p, 255, 255, 255, true)
			triggerClientEvent(source, "dLogi", source, getPlayerName(source)..": "..wiadomosc, "chat")
		end
	elseif typ == 1 then
		cancelEvent()
		local x, y, z = getElementPosition(source)
		local cuboid = createColSphere(x, y, z, 20)
		local wCuboid = getElementsWithinColShape(cuboid, "player")
		destroyElement(cuboid)
		for _, p in ipairs(wCuboid) do
			local nick = getPlayerName(source)
			wiadomosc = string.gsub(wiadomosc, "#%x%x%x%x%x%x", "")
			local info = "#4343ff*"..nick.."*#939393 "..wiadomosc
			outputChatBox(info, p, 255, 255, 255, true)
			triggerClientEvent(source, "dLogi", source, wiadomosc.."("..getPlayerName(source)..")", "chat")
		end
	end
end)


--[[addEventHandler("onPlayerChat", root, function(wiadomosc, typ)
	if typ == 0 then
		cancelEvent()
		if getElementData(source, "user:mute") then return end
		local x, y, z = getElementPosition(source)
		local cuboid = createColSphere(x, y, z, 20)
		local wCuboid = getElementsWithinColShape(cuboid, "player")
		destroyElement(cuboid)
		for _, p in ipairs(wCuboid) do
			local nick = getPlayerName(source)
			local id = getElementData(source, "id") or 0
			local kolor = idRanga(source)
			wiadomosc = string.gsub(wiadomosc, "#%x%x%x%x%x%x", "")
			local info = ""..kolor.."("..id..")""#ffffff "..nick..": "..wiadomosc
			outputChatBox(info, p, 255, 255, 255, true)
		end
		triggerClientEvent("dLogi", root, getPlayerName(source)..": "..wiadomosc)
	elseif typ == 1 then
		cancelEvent()
		local x, y, z = getElementPosition(source)
		local cuboid = createColSphere(x, y, z, 20)
		local wCuboid = getElementsWithinColShape(cuboid, "player")
		destroyElement(cuboid)
		for _, p in ipairs(wCuboid) do
			local nick = getPlayerName(source)
			wiadomosc = string.gsub(wiadomosc, "#%x%x%x%x%x%x", "")
			local info = "#4343ff*"..nick.."*#939393 "..wiadomosc
			outputChatBox(info, p, 255, 255, 255, true)
		end
	end
end)]]

addCommandHandler("do", function(g, _, ...)
	if not ... then return end
	local wiadomosc = table.concat({...}, " ")
	local x, y, z = getElementPosition(g)
	local cuboid = createColSphere(x, y, z, 20)
	local wCuboid = getElementsWithinColShape(cuboid, "player")		
	destroyElement(cuboid)
	for _, p in ipairs(wCuboid) do
		local nick = getPlayerName(g)
		wiadomosc = string.gsub(wiadomosc, "#%x%x%x%x%x%x", "")
		local info = "#939393*"..wiadomosc.."*#4343ff ("..nick..")"
		outputChatBox(info, p, 255, 255, 255, true)
		triggerClientEvent(source, "dodajLogi", g, getPlayerName(g)..": "..wiadomosc, "chat")
	end
end)

function findPlayer(p, ph)
	for i,v in ipairs(getElementsByType("player")) do
		if tonumber(ph) then
			if getElementData(v, "id") == tonumber(ph) then
				return getPlayerFromName(getPlayerName(v))
			end
		else
			if string.find(string.gsub(getPlayerName(v):lower(),"#%x%x%x%x%x%x", ""), ph:lower(), 1, true) then
				return getPlayerFromName(getPlayerName(v))
			end
		end
	end
end

function przelej(gracz, _, kgracz, ilosc)
    if not gracz or not kgracz or not ilosc then
    	exports["nm-noti"]:noti("Poprawne użycie: /przelej <id nick> <kwota>", gracz)
	    return
	end
	kgracz = findPlayer(gracz, kgracz)
	if not kgracz then
    	exports["nm-noti"]:noti("Nie znaleziono podanego gracza.", gracz)
	    return
	end
	if kgracz == gracz then
    	exports["nm-noti"]:noti("Nie możesz przelać sobie pieniędzy.", gracz)
		return
	end
	if getElementData(gracz, "dbid") == getElementData(kgracz, "dbid") then
    	exports["nm-noti"]:noti("Nie możesz przelać sobie pieniędzy.", gracz)
		return
	end
 	if not tonumber(ilosc) then
   		exports["nm-noti"]:noti("Wprowadzana wartość nie jest liczbą.",gracz)
   		return
  	end
	local ile = tonumber(ilosc)
	if ile == 0 or ile < 0 then
		exports["nm-noti"]:noti("Wpisana wartość musi być większa od 0",gracz)
		return
	end
  	ilosc = math.abs(ilosc)
  	ilosc = tonumber(ilosc)
	local hajs = getElementData(gracz, "pieniadze")
	local kasa = getElementData(kgracz, "pieniadze")
	if hajs > ilosc then
		setElementData(gracz, "pieniadze", hajs-ilosc)
		setElementData(kgracz, "pieniadze", kasa+ilosc)
                local ilosc2 = string.format("%1d", ilosc)
		outputChatBox("#FFFFFFPrzelewasz #05FF00"..ilosc2.." #FFFFFFPLN graczu #05FF00"..getPlayerName(kgracz), gracz, 255, 255, 255, true)
		outputChatBox("#FFFFFFGracz #05FF00"..getPlayerName(gracz).." #FFFFFFprzelewa ci #05FF00"..ilosc2.."#FFFFFF PLN.", kgracz, 255, 255, 255, true)
		triggerClientEvent("dLogi", root, getPlayerName(gracz).." > "..getPlayerName(kgracz)..": "..ilosc2.." PLN")
	else
		exports["nm-noti"]:noti("Nie posiadasz wystarczających funduszy.", gracz)
	end
end
addCommandHandler("dajkase", przelej)
addCommandHandler("przelej", przelej)
addCommandHandler("zaplac", przelej)

function pm(gracz, _, graczhere, ...)
	if graczhere and ... then
		local tresc = table.concat({...}, " ")
		graczhere = findPlayer(gracz, graczhere)
		if not graczhere then
            exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Nie znaleziono podanego gracza.", gracz)		
			return
		end
		if getElementData(graczhere, "poff") then
            exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Podana osoba posiada wyłączone prywatne wiadomości z powodu "..getElementData(graczhere, "poff"), gracz)			
			return
		end
		local idh = getElementData(graczhere, "id")
		local id = getElementData(gracz, "id")
		outputChatBox("#005EFE>>#ffffff "..getPlayerName(graczhere).."#005EFE(#ffffff"..idh.."#005EFE)#ffffff: "..tresc, gracz, 255, 255, 255, true)
		outputChatBox("#005EFE<<#ffffff "..getPlayerName(gracz).."#005EFE(#ffffff"..id.."#005EFE)#ffffff: "..tresc, graczhere, 255, 255, 255, true)
		triggerClientEvent("dLogi", root, getPlayerName(gracz).." > "..getPlayerName(graczhere)..": "..tresc)
	end
end
addCommandHandler("pm", pm)

function pmoff(gracz, _, ...)
	if not getElementData(gracz, "poff") then
		local powod = table.concat({...}, " ")
		if not ... then 
			powod = "brak powodu"
		end
        exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Wyłączyłeś prywatne wiadomości z powodu "..powod, gracz)			
		setElementData(gracz, "poff", powod)
	end
end
addCommandHandler("pmoff", pmoff)

function pmon(gracz, _)
	if getElementData(gracz, "poff") then
        exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Włączyłeś prywatne wiadomości", gracz)	
		setElementData(gracz, "poff", false)
	end
end
addCommandHandler("pmon", pmon)


--[[
	System ID graczy
	@author Lukasz Biegaj <wielebny@bestplay.pl>
	Nie masz prawa użyć tego kodu bez mojej zgody
]]

local function findFreeValue(tablica_id)
	table.sort(tablica_id)
	local wolne_id=1
	for i,v in ipairs(tablica_id) do
		if (v==wolne_id) then wolne_id=wolne_id+1 end
		if (v>wolne_id) then return wolne_id end
	end
	return wolne_id
end

function assignPlayerID(plr)
	local gracze=getElementsByType("player")
	local tablica_id = {}
	for i,v in ipairs(gracze) do
		local lid=getElementData(v, "id")
		if (lid) then
			table.insert(tablica_id, tonumber(lid))
		end
	end
	local free_id=findFreeValue(tablica_id)

	setElementData(plr,"id", free_id)
	setElementID(plr, "p" .. free_id)
	return free_id
end

function getPlayerID(plr)
	if not plr then return "" end
	local id=getElementData(plr,"id")
	if (id) then
		return id
	else
		return assignPlayerID(plr)
	end

end

addEventHandler ("onPlayerJoin", getRootElement(), function()
	assignPlayerID(source)
end)

function pChat(g, _, ...)
	if not getElementData(g, "premium") then return end
	if not ... then
		if getElementData(g, "cpoff") then
			setElementData(g, "cpoff", false)
			exports["nm-noti"]:noti("Włączyłeś czat premium.", g)
		else
			setElementData(g, "cpoff", true)
			exports["nm-noti"]:noti("Wyłączyłeś czat premium.", g)
		end
	else
		if getElementData(g, "cpoff") then return end
		local t = table.concat({...}, " ")
		for i,v in ipairs(getElementsByType("player")) do
			if getElementData(v, "premium") and not getElementData(v, "cpoff") then
				outputChatBox("[Premium] #ffffff"..getPlayerName(g)..": "..t, v, 255, 255, 0, true)
			end
		end
	end
end
addCommandHandler("v", pChat)

---- BLOKADY FRAKCYJNE ------


local frakcje = {
["SAPD"] = true,
["SAFD"] = true,
["SAMC"] = true,
}

addCommandHandler("postaw",function(source, cmd, co)
if frakcje[getElementData(source, "frakcja")] then
local rbs = getElementData(source, "user:rbs") or {}
if not co then outputChatBox("/postaw [pacholek/barierka]", source, 255, 0, 0) return end
if co == "pacholek" then
local rotX,rotY,rotZ = getElementRotation(source)
local x,y,z = getElementPosition(source)
pacholek = createObject(1238, x, y, z-0.65,0,0, rotZ)
table.insert(rbs, pacholek)
setElementData(source, "user:rbs", rbs)
setElementPosition ( source, x, y, z+1 )
setElementFrozen(pacholek , true)
triggerClientEvent("niedozniszczenia",pacholek)
elseif co == "barierka" then
local x,y,z = getElementPosition(source)
local rotX,rotY,rotZ = getElementRotation(source)
barierka = createObject(1228, x, y, z-0.65,0,0, rotZ)
table.insert(rbs, barierka)
setElementData(source, "user:rbs", rbs)
setElementPosition ( source, x, y, z+1 )
setElementFrozen(barierka, true)
triggerClientEvent("niedozniszczenia",barierka)
end
end
end)

addCommandHandler("usun", function(plr)
if getElementData(plr, "user:rbs") then
for key, value in ipairs(getElementData(plr, "user:rbs")) do
if isElement(value) then
destroyElement(value)
end
end
removeElementData(plr, "user:rbs")
end
end)

function krotkofalowkachat(plr, cmd, ...)
local frakcja = getElementData(plr, "frakcja")
if not frakcja then return end
local msg = table.concat ( { ... }, " " )
for i,v in pairs(getElementsByType("player")) do
if getElementData(v, "frakcja") then
outputChatBox("[Krótkofalówka] "..getPlayerName(plr).." ["..getElementData(plr, "id").."] ["..frakcja.."]:#ffffff "..msg, v, 255, 0, 0, true)
end
end
end
addCommandHandler("krotkofalowka", krotkofalowkachat)

addEventHandler("onResourceStart", root, function()
local players = getElementsByType("player")
for _, p in pairs(players) do
bindKey(p, "u", "down", "chatbox", "krotkofalowka")
end
end)

addEventHandler( "onPlayerSpawn", getRootElement(), function()
bindKey(source, "u", "down", "chatbox", "krotkofalowka")
end)

function frakcjachat(plr, cmd, ...)
local frakcja = getElementData(plr, "frakcja")
if not frakcja then return end
local msg = table.concat ( { ... }, " " )
for i,v in pairs(getElementsByType("player")) do
local pfrakcja = getElementData(v, "frakcja")
if frakcja == pfrakcja then
outputChatBox("[Frakcja] "..getPlayerName(plr).." ["..getElementData(plr, "id").."]: "..msg, v, 255, 255, 255, true)
end
end
end
addCommandHandler("frakcja", frakcjachat)

addEventHandler("onResourceStart", root, function()
local players = getElementsByType("player")
for _, p in pairs(players) do
bindKey(p, "y", "down", "chatbox", "frakcja")
end
end)

addEventHandler( "onPlayerSpawn", getRootElement(), function()
bindKey(source, "y", "down", "chatbox", "frakcja")
end)