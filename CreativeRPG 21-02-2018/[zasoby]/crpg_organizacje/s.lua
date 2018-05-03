--[[
Autor: Asper
Skrypt: Organizacje
Zakaz udostepniania bez zgody autora!
Zakaz uzywania bez zgody autora!
]]

addEvent("sListaO", true)
addEventHandler("sListaO", root, function(p)
   local spr = exports.mysql:wykonaj("SELECT * FROM konta WHERE org=?", getElementData(p, "org"))
   local spr2 = exports.mysql:wykonaj("SELECT * FROM organizacje WHERE id=?", spr[1].org)
   if spr then
      triggerClientEvent(p, "cListaO", p, spr, spr2[1])
   end
end)

function cOrg(g, _, ...)
	if ... and getElementData(g, "organizacja") then
		local t = table.concat({...}, " ")
		local o = getElementData(g, "organizacja")
		for i,v in ipairs(getElementsByType("player")) do
			if getElementData(v, "organizacja") == o then
				outputChatBox("#000000"..getElementData(v, "organizacja")..">#ffffff "..getPlayerName(g)..": "..t, v, 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("organizacja", cOrg)

addEventHandler("onResourceStart", resourceRoot, function()
	for i,v in ipairs(getElementsByType("player")) do
		bindKey(v, "o", "down", "chatbox", "organizacja")
	end
end)

addEventHandler("onPlayerSpawn", root, function()
	bindKey(source, "o", "down", "chatbox", "organizacja")
end)

addEvent("oDodaj", true)
addEventHandler("oDodaj", root, function(p, p2)
	if not p and not p2 then return end
	local graczhere = findPlayer(p, p2)
	if not graczhere then
		exports["aw-noti"]:noti("Nie znaleziono podanego gracza.", p)
		return
	end
	if getElementData(graczhere, "org") then
		exports["aw-noti"]:noti("Podany gracz posiada organizacje.", p)
		return
	end
	exports["aw-noti"]:noti("Wysłano zaproszenie o dołączenie do organizacji graczu "..getPlayerName(graczhere), p)
	setElementData(graczhere, "zaproszenie", {
		["id"] = getElementData(p, "org"),
		["nazwa"] = getElementData(p, "organizacja"),
		["dodany"] = p,
	})
	outputChatBox("Otrzymałeś zaproszenie do orgnizacji "..getElementData(p, "organizacja"), graczhere)
	outputChatBox("Aby dołączyć użyj: /dolacz "..getElementData(p, "org"), graczhere)
	setTimer(function()
		setElementData(graczhere, "zaproszenie", false)
	end, 30000, 1)
end)

addCommandHandler("dolacz", function(player, cmd, idd)
	local zaproszenie = getElementData(player, "zaproszenie")
	if zaproszenie then
		if not idd then
			exports["aw-noti"]:noti("Poprawne użycie: /"..cmd.." <id organizacji>", player)
			return
		end
		outputChatBox(getPlayerName(player).." przyjął zaproszenie do organizacji.", p)
		exports["aw-noti"]:noti("Przyjąłeś zaproszenie do organizacji "..zaproszenie.nazwa, player)
		setElementData(player, "oranga", 1)
		setElementData(player, "org", zaproszenie.id)
		setElementData(player, "organizacja", zaproszenie.nazwa) 
		exports.mysql:wykonaj("UPDATE konta SET org=? WHERE dbid=?", zaproszenie.id, getElementData(player, "dbid"))
		setElementData(player, "zaproszenie", false)
	else
		exports["aw-noti"]:noti("Nie posiadasz zaproszenia do organizacji.", player)
	end
end)

addEvent("oWyrzuc", true)
addEventHandler("oWyrzuc", root, function(p, p2, ranga)
	if not p and not p2 then return end
	ranga = tonumber(ranga)
	if ranga == 5 then 
		exports["aw-noti"]:noti("Nie możesz wyrzucić Lidera.", p)
		return
	end
	if ranga == 4 and getElementData(p, "oranga") ~= 5 then 
		exports["aw-noti"]:noti("Nie możesz wyrzucić vLidera.", p)
		return
	end
	exports["aw-noti"]:noti("Wyrzucono gracza "..p2.." z organizacji.", p)
	if getPlayerFromName(p2) then
		local graczhere = getPlayerFromName(p2)
		exports["aw-noti"]:noti("Gracz "..getPlayerName(p).." wyrzucił cię z organizacji.", graczhere)
		setElementData(graczhere, "oranga", false)
		setElementData(graczhere, "organizacja", false) 
		setElementData(graczhere, "org", false)
	end
	exports.mysql:wykonaj("UPDATE konta SET org=?, oranga=? WHERE login=?", "0", "1", p2)
end)

addEvent("oEdytuj", true)
addEventHandler("oEdytuj", root, function(p, p2, r, r2)
	if not p and not p2 and not r then return end
	r = tonumber(r)
	r2 = tonumber(r2)
	local graczhere = getPlayerFromName(p2)
	if r2 == 5 then 
		exports["aw-noti"]:noti("Nie możesz edytować Lidera.", p)
		return
	end
	if r2 == 4 and r ~= 5 then 
		exports["aw-noti"]:noti("Nie możesz edytować vLidera.", p)
		return
	end
	if r2 == r then 
		exports["aw-noti"]:noti("Podany gracz posiada już rangę "..r, p)
		return
	end
	exports["aw-noti"]:noti("Edytowano gracza "..p2.." na rangę "..r, p)
	if graczhere then
		exports["aw-noti"]:noti("Gracz "..getPlayerName(p).." edytował twoją rangę na "..r, graczhere)
		setElementData(graczhere, "oranga", r)
	end
	exports.mysql:wykonaj("UPDATE konta SET oranga=? WHERE login=?", r, p2)
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

addCommandHandler("opuscorganizacje", function(player)
	if getElementData(player, "org") then
		if getElementData(player, "oranga") == 5 then
			local result = exports.mysql:wykonaj("SELECT * FROM konta WHERE org=?", getElementData(player, "org"))
			if #result < 2 then
				exports["aw-noti"]:noti("Usunąłeś organizacje.", player)
				exports.mysql:wykonaj("DELETE FROM organizacje WHERE id=?", getElementData(player, "org"))
				setElementData(player, "oranga", false)
				setElementData(player, "organizacja", false) 
				setElementData(player, "org", false)
				exports.mysql:wykonaj("UPDATE konta SET org=?, oranga=? WHERE login=?", "0", "1", getPlayerName(player))
			else
				exports["aw-noti"]:noti("Aby usunąć organizacje musi zostać w nim 1 gracz (Lider).", player)
			end
		else
			exports["aw-noti"]:noti("Opuściłeś organizacje.", player)
			setElementData(player, "oranga", false)
			setElementData(player, "organizacja", false) 
			setElementData(player, "org", false)
			exports.mysql:wykonaj("UPDATE konta SET org=?, oranga=? WHERE login=?", "0", "1", getPlayerName(player))
		end
	else
		exports["aw-noti"]:noti("Nie posiadasz organizacji.", player)
	end
end)