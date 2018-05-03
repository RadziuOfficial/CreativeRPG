--[[
Autor: Asper
Dla: .newMode
Skrypt: Pojazdy gracza
Typ: Server
]]

local marker = createMarker(2128.87, 2355.74, 10.67-1, "cylinder", 1.5, 150, 150, 150, 75)
--setElementDimension(marker, 0)

local napisy = createElement("text")
setElementData(napisy, "text", "Rejestracja auta\nprzekazywanie kluczy\nprzepisywanie")
setElementPosition(napisy, -2690.30, 245.13, 4.33)

addEventHandler("onMarkerHit", marker, function(hit)
	local spr = exports.mysql:wykonaj("SELECT * FROM pojazdy WHERE wlasciciel=?", getElementData(hit, "dbid"))
	triggerClientEvent(hit, "listaP", hit, spr)
end)

addEventHandler("onMarkerLeave", marker, function(hit)
	triggerClientEvent(hit, "listaPC", hit)
end)

addEvent("gKeys", true)
addEventHandler("gKeys", root, function(g, i, n)
	if not g and not i and not n then return end
	n = findPlayer(g, n)
	if not n then
		exports["crpg_powiadomienia"]:noti("Nie znaleziono podanego gracza.", g)
		return
	end
	if n == g then return end
	local q = exports.mysql:wykonaj("SELECT * FROM pojazdy WHERE id=?", i)
	if q[1].przechowalnia == 1 then
		exports["crpg_powiadomienia"]:noti("Podany pojazd znajduje się w przechowalni.", g)
		return
	end
	for _, v in pairs(getElementsByType("vehicle")) do
		if getElementData(v, "id") then
			if getElementData(v, "id") == tonumber(i) then
				if getElementData(v, "keys") then
					exports["crpg_powiadomienia"]:noti("Zabrano dostęp do pojazdu o id "..i.." graczu "..getPlayerName(n), g)
					setElementData(v, "keys", false)
				else
					exports["crpg_powiadomienia"]:noti("Dałeś graczu "..getPlayerName(n).." klucze do pojazdu o id "..i, g)
					setElementData(v, "keys", getElementData(n, "dbid"))
				end
			end
		end
	end
end)

addEvent("kOrg", true)
addEventHandler("kOrg", root, function(l, i)
	if not l and not i then return end
	if not getElementData(l, "organizacja") then return end
	local q = exports.mysql:wykonaj("SELECT * FROM pojazdy WHERE id=?", i)
	if q[1].przechowalnia == 1 then
		exports["crpg_powiadomienia"]:noti("Podany pojazd znajduje się w przechowalni.", l)
		return
	end
	for _, v in pairs(getElementsByType("vehicle")) do
		if getElementData(v, "id") then
			if getElementData(v, "id") == tonumber(i) then
				if getElementData(v, "organizacja") then
					exports["crpg_powiadomienia"]:noti("Pojazd o id "..i.." został wypisany z organizacji.", l)
					setElementData(v, "organizacja", false)
					exports.mysql:wykonaj("UPDATE pojazdy SET organizacja=? WHERE id=?", "", i)
				else
					exports["crpg_powiadomienia"]:noti("Pojazd o id "..i.." został przepisany na organizacje.", l)
					setElementData(v, "organizacja", getElementData(l, "organizacja"))
					exports.mysql:wykonaj("UPDATE pojazdy SET organizacja=? WHERE id=?", getElementData(l, "organizacja"), i)
				end
			end
		end
	end
end)

addEvent("gRejka", true)
addEventHandler("gRejka", root, function(l, i, r)
	if not l and not i and not r then return end
	local q = exports.mysql:wykonaj("SELECT * FROM pojazdy WHERE id=?", i)
	local hajs = getElementData(l, "pieniadze")
	if q[1].przechowalnia == 1 then
		exports["crpg_powiadomienia"]:noti("Podany pojazd znajduje się w przechowalni.", l)
		return
	end
	if hajs < 5000 then
		exports["crpg_powiadomienia"]:noti("Brak wystarczających funduszy.", l)
		return
	end
	for _, v in pairs(getElementsByType("vehicle")) do
		if getElementData(v, "id") then
			if getElementData(v, "id") == tonumber(i) then
				exports["crpg_powiadomienia"]:noti("Rejestracja pojazdu uległa zmiane na "..r.." cena wyniosła 1000 PLN.", l)
				setElementData(l, "pieniadze", hajs-1000)
				setVehiclePlateText(v, r)
				exports.mysql:wykonaj("UPDATE pojazdy SET rejestracja=? WHERE id=?", r, i)
			end
		end
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