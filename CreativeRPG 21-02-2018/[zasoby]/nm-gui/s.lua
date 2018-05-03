--[[
Autor: Asper
Skrypt: Premium
Typ: Server
]]

addCommandHandler("ogloszenie", function(player, _, ...)
	if not getElementData(player, "premium") then return end
	if ... then
		local text = table.concat({...}, " ")
		triggerClientEvent(root, "addOgloszenie", root, player, text)
	else
		exports["nm-noti"]:noti("Poprawne użycie: /ogloszenie [treść]", player)
	end
end)

--[[function sprawdzIloscDni(gracz)
	local spr = exports.mysql:wykonaj("SELECT * FROM konta WHERE dbid=? AND premium>NOW() LIMIT 1", getElementData(gracz, "dbid"))
	if (spr and #spr > 0) then
		return spr[1].premium
	end
	return false
end

function ustawIloscDni(gracz, dni)
	if sprawdzIloscDni(gracz) then
	local wyk = exports.mysql:wykonaj(string.format("UPDATE konta SET premium = DATE(premium) + INTERVAL %d DAY WHERE dbid=%d", dni, getElementData(gracz, "dbid")))
	return end
	local wyk = exports.mysql:wykonaj(string.format("UPDATE konta SET premium = DATE(curdate()) + INTERVAL %d DAY WHERE dbid=%d", dni, getElementData(gracz, "dbid")))
end

addEvent("skPremium", true)
addEventHandler("skPremium", root, function(kod, dni)
	local spr = "http://microsms.pl/api/v2/multi.php?userid=3614&code="..kod.."&serviceid=4580"
	fetchRemote(spr, wyk, "", false, client, dni)
end)

function wyk(responseData, errno, playerToReceive, amount)
	if errno == 0 then
	--if string.find(responseData, "CreativeRPG") then
	if string.find(responseData, '"status":0') then	
		if string.find(responseData, '"number":"71480"') then
			amount = 1
		elseif string.find(responseData, '"number":"74480"') then
			amount = 7
		elseif string.find(responseData, '"number":"76480"') then
			amount = 14
		elseif string.find(responseData, '"number":"79480"') then
			amount = 30
		end
        exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Zakupiłeś premium na "..amount.." dni.", playerToReceive)		
		setElementData(playerToReceive, "premium", true)
		ustawIloscDni(playerToReceive, amount)
		setPlayerNametagColor(playerToReceive, 255, 200, 0)
	else
        exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Podany kod jest nieprawidłowy.", playerToReceive)		
	end
end
end]]


addCommandHandler("daj.premium", function(g, _, graczhere, dni)
	if getElementData(g, "duty") == 4 and graczhere and dni then
		graczhere = findPlayer(g, graczhere)
		if not graczhere then return end
		ustawIloscDni(graczhere, dni)
		setElementData(graczhere, "premium", true)
		setPlayerNametagColor(graczhere, 255, 200, 0)
        exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Nadałeś graczu "..getPlayerName(graczhere).." premium na "..dni.." dni", g)			
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