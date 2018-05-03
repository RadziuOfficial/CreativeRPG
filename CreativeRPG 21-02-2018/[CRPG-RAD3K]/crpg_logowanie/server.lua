--[[
	Autor: Asper
	Dla servera: .newMode
	Skrypt: Logowanie
]]

local zabezpieczeni = {
["Asper"] = "86866E7FEF366B70DFD6D5BC22324FA1",
["Sk!per"] = "0E189BBA46108F211BEEC72CAE7D0DB4",
["Gutek"] = "1F113001788B18C6FA19BFF23F263E44",
}

local haslo2 = false
local haslo3 = false

addEvent("zaloguj", true)
addEventHandler("zaloguj", root, function(login, haslo)
	haslo = escapeStrings(haslo)
	login = escapeStrings(login)
	haslo2 = haslo
	local haslo = md5(sha256(md5(sha256(haslo))))
	local spr = exports.mysql:wykonaj("SELECT * FROM konta WHERE login=? AND haslo=?", login, haslo)
	if #spr > 1 then
		triggerClientEvent(client, "zmienPowiadomienie", client, "Konto o kombinacji loginu i hasła nie istnieje.")
	return
	end
	if #spr < 1 then
		triggerClientEvent(client, "zmienPowiadomienie", client, "Podana kombinacja loginu i hasła jest błędna.")
	return
	end
	if spr[1].serial ~= getPlayerSerial(client) then
		exports["nm-noti"]:noti("Podane konto nie należy do ciebie.", client)
		return
	end
	for _, p in ipairs(getElementsByType("player")) do
	if getElementData(p, "dbid") == spr[1].dbid then
		triggerClientEvent(client, "zmienPowiadomienie", client, "Niestety ale ktoś jest zalogowany na podanym koncie.")
	return
	end
	end
	outputChatBox("Pomyślnie zalogowano na konto o loginie "..login.." życzymy miłej gry!", client, 0, 255, 0)
	local konto = getAccount(login, haslo2)
	if konto then
		logIn(client, konto, haslo2)
	end
	triggerClientEvent(client, "usunElementyLogowania", root)
	wczytajDane(client, login)
end)

addEvent("zarejestruj", true)
addEventHandler("zarejestruj", root, function(login, haslo)
	haslo = escapeStrings(haslo)
	login = escapeStrings(login)
	local sprxd = exports.mysql:wykonaj("SELECT * FROM konta WHERE serial=?", getPlayerSerial(client))
    if sprxd and #sprxd >= 1 then
       	triggerClientEvent(client, "zmienPowiadomienie", client, "Posiadasz już jedno konto na tym serialu.")
    	return 
	end
	haslo3 = haslo
	local haslo = md5(sha256(md5(sha256(haslo))))
	local spr = exports.mysql:wykonaj("SELECT * FROM konta WHERE login=?", login)
	if #spr > 0 then
		triggerClientEvent(client, "zmienPowiadomienie", client, "Konto o kombinacji loginu już istnieje.")
	return
	end
	local wyk = exports.mysql:wykonaj("INSERT INTO konta SET login=?, haslo=?, serial=?, rejestracja=NOW()", login, haslo, getPlayerSerial(client))
	if wyk then
		addAccount(login, haslo2)
		local konto = getAccount(login, haslo2)
		if konto then
			logIn(client, konto, haslo2)
		end
		outputChatBox("Pomyślnie założono konto o loginie "..login.." życzymy miłej gry!", client, 0, 255, 0)
		triggerClientEvent(client, "usunElementyLogowania", root)
		wczytajDane(client, login)
	end
end)

addEvent("spawn", true)
addEventHandler("spawn", root, function(l)
	if not l then return end
	if l == "przechowywalnia" then
		spawnPlayer(client, 1966.10, 2175.49, 10.82, 90, getElementData(client, "skin"), 0)
	elseif l == "mechanik" then
		spawnPlayer(client, -2039.80, 148.89, 28.80, 280, getElementData(client, "skin"), 0)
	elseif l == "ratusz" then
		spawnPlayer(client, 2127.51, 2366.96, 10.82, 180, getElementData(client, "skin"), 0)
	elseif l == "pos" then
		local spr = exports.mysql:wykonaj("SELECT * FROM konta WHERE dbid=?", getElementData(client, "dbid"))
		if spr[1].pos:len() > 1 then
			local pozycja = split(spr[1].pos, ",")
			local x, y, z = pozycja[1], pozycja[2], pozycja[3]
			spawnPlayer(client, 2127.51, 2366.96, 10.82, 0, getElementData(client, "skin"), 0)
		else
			spawnPlayer(client, 2127.51, 2366.96, 10.82, 180, getElementData(client, "skin"), 0)
		end
	end
	setElementData(client, "zalogowany", true)
	setCameraTarget(client, client)
	toggleControl(client, "fire", false)
	toggleControl(client, "aim_weapon", false)
end)

function wczytajDane(p, l)
	if not p and not l then return end
	local spr = exports.mysql:wykonaj("SELECT * FROM konta WHERE login=?", l)
	showPlayerHudComponent(p, "all", true)
	showPlayerHudComponent(p, "money", false)
	showPlayerHudComponent(p, "area_name", false)
	showPlayerHudComponent(p, "radar", true)
	showPlayerHudComponent(p, "ammo", false)
	showPlayerHudComponent(p, "armour", false)
	showPlayerHudComponent(p, "clock", false)
	showPlayerHudComponent(p, "health", false)
	showPlayerHudComponent(p, "radio", false)
	showPlayerHudComponent(p, "breath", false)
	showPlayerHudComponent(p, "weapon", false)
	setPlayerName(p, spr[1].login)
	setElementData(p, "dbid", spr[1].dbid)
	setElementData(p, "pieniadze", spr[1].kasa)
	setElementData(p, "punkty", spr[1].punkty)
	setElementData(p, "bkasa", spr[1].bkasa)
	setElementData(p, "online", spr[1].online)
	setElementData(p, "rejestracja", spr[1].rejestracja)
	setElementData(p, "prawko_a", spr[1].prawko_a)
	setElementData(p, "prawko_b", spr[1].prawko_b)
	setElementData(p, "prawko_c", spr[1].prawko_c)
	setElementData(p, "mlvl", spr[1].mlvl)
	setElementData(p, "mexp", spr[1].mexp)
	setElementData(p, "skin", spr[1].skin)
	local q = exports.mysql:wykonaj("SELECT * FROM organizacje WHERE id=?", spr[1].org)
	if #q > 0 then
		setElementData(p, "organizacja", q[1].nazwa)
		setElementData(p, "oranga", spr[1].oranga)
		setElementData(p, "org", spr[1].org)
	  else
		setElementData(p, "organizacja", false)
		setElementData(p, "oranga", false)
		setElementData(p, "org", false)
   	end
   	if spr[1].premium == "0000-00-00" then return end
   	if spr[1].premium > data() then
		setElementData(p, "premium", true)
		setPlayerNametagColor(p, 255, 255, 0)
	else
		setElementData(p, "premium", false)
		setPlayerNametagColor(p, 255, 255, 255)
		exports["nm-noti"]:noti("Twoje konto premium straciło ważnośc.", p)
		exports.mysql:wykonaj("UPDATE konta SET premium=? WHERE dbid=?", "0000-00-00", spr[1].dbid)
	end
end

addEventHandler("onPlayerQuit", root, function()
	if getElementData(source, "dbid") then
		local kasa = getElementData(source, "pieniadze")
		local online = tonumber(getElementData(source, "online"))
		local dbid = getElementData(source, "dbid")
		local pkt = getElementData(source, "punkty")
		local skin = getElementData(source, "skin")
		local x, y, z = getElementPosition(source)
		local pos = x..", "..y..", "..z
		local wyk = exports.mysql:wykonaj("UPDATE konta SET kasa=?, online=?, punkty=?, skin=?, pos=? WHERE dbid=?", kasa, online, pkt, skin, pos, dbid)
		if not wyk then
			outputDebugString("Nie udalo sie zapisac gracza o dbid "..dbid)
		end
	end
end)

function data()
	local t = getRealTime()
	local r = t.year
	local m = t.month
	local t = t.monthday
	r = r+1900
	m = m+1
	local time = getRealTime()
	local hours = time.hour
	local minutes = time.minute
	local c = hours..":"..minutes
	return r.."-"..m.."-"..t.." "..c
end

addEvent("sprawdzBana", true)
addEventHandler("sprawdzBana", root, function()
	local g = source
	local serial = getPlayerSerial(g)
	local spr = exports.mysql:wykonaj("SELECT * FROM bany WHERE serial=? AND data>NOW()", serial)
	if #spr > 0 then
		triggerClientEvent(g, "oknoZbanowany", root, g, spr[1].ip, spr[1].serial, spr[1].data, spr[1].admin, spr[1].nick)
		triggerClientEvent(g, "bShowedLogin", root)
	else
		exports.mysql:wykonaj("DELETE FROM bany WHERE serial=?", serial)
	end
end)

addEvent("banWyrzuc", true)
addEventHandler("banWyrzuc", root, function()
	kickPlayer(source, "Zostałeś zbanowany na tym serwerze!")
end)

function escapeStrings(str)
 local String = string.gsub(tostring(str),"'","")
 String = string.gsub(String,'"',"")
 String = string.gsub(String,';',"")
 String = string.gsub(String,"\\","")
 String = string.gsub(String,"/*","")
 String = string.gsub(String,"*/","")
 String = string.gsub(String,"'","")
 String = string.gsub(String,"`","")
 return String
end