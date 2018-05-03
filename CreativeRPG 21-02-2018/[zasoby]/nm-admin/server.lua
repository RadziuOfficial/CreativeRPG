--[[
	Autor: Asper
	Dla servera: .newMode
	Skrypt: Duty administracji
]]

function jp(gracz)
	if getElementData(gracz, "duty") then
		if doesPlayerHaveJetPack(gracz) then
			removePlayerJetPack(gracz)
		else
			givePlayerJetPack(gracz)
		end
	end
end

local jednostki = {
	["m"] = true,
	["h"] = true,
	["d"] = true,	
}

function getTimestamp(year, month, day, hour, minute, second)
    -- initiate variables
    local monthseconds = { 2678400, 2419200, 2678400, 2592000, 2678400, 2592000, 2678400, 2678400, 2592000, 2678400, 2592000, 2678400 }
    local timestamp = 0
    local datetime = getRealTime()
    year, month, day = year or datetime.year + 1900, month or datetime.month + 1, day or datetime.monthday
    hour, minute, second = hour or datetime.hour, minute or datetime.minute, second or datetime.second

    -- calculate timestamp
    for i=1970, year-1 do timestamp = timestamp + (isLeapYear(i) and 31622400 or 31536000) end
    for i=1, month-1 do timestamp = timestamp + ((isLeapYear(year) and i == 2) and 2505600 or monthseconds[i]) end
    timestamp = timestamp + 86400 * (day - 1) + 3600 * hour + 60 * minute + second

    timestamp = timestamp - 3600 --GMT+1 compensation
    if datetime.isdst then timestamp = timestamp - 3600 end

    return timestamp
end

function isLeapYear(year)
    if year then year = math.floor(year)
    else year = getRealTime().year + 1900 end
    return ((year % 4 == 0 and year % 100 ~= 0) or year % 400 == 0)
end

function zbanuj(plr, cmd, target, t1, t2, ...)
	if not getElementData(plr, "duty") then return end
	if not target or not t1 or not t2 or not ... then
		return
	end
	local player = findPlayer(plr, target)
	if not player then return end
		local text = table.concat({...}, ", ")
		local ts_start = getTimestamp()
		if t1 == "m" then
			local t2 = tonumber(t2)
			local ts_final = ts_start + t2*60
			local time = getRealTime(ts_final)
			local txt = getPlayerName(player).." został zbanowany przez "..getPlayerName(plr).." na czas "..t2.." minut z powodu "..text
			triggerClientEvent(getRootElement(), "notiAdmin", getRootElement(), txt)
			outputConsole(txt)
			local user_id = getElementData(player, "dbid")
			local user_serial = getPlayerSerial(player)
			local final_date = (time.year+1900).."-"..(time.month+1).."-"..(time.monthday).." "..(time.hour)..":"..(time.minute)..":"..(time.second)
			exports.mysql:wykonaj("INSERT INTO bany SET nick=?, serial=?, ip=?, data=?, admin=?", getPlayerName(player), getPlayerSerial(player), getPlayerIP(player), final_date, getPlayerName(plr))
			kickPlayer(player, "Połącz się ponownie")
		elseif t1 == "h" then
			local t2 = tonumber(t2)
			local ts_final = ts_start + t2*3600
			local time = getRealTime(ts_final)
			local txt = getPlayerName(player).." został zbanowany przez "..getPlayerName(plr).." na czas "..t2.." godzin z powodu "..text
			triggerClientEvent(getRootElement(), "notiAdmin", getRootElement(), txt)
			outputConsole(txt)
			local user_id = getElementData(player, "dbid")
			local user_serial = getPlayerSerial(player)
			local final_date = (time.year+1900).."-"..(time.month+1).."-"..(time.monthday).." "..(time.hour)..":"..(time.minute)..":"..(time.second)
			exports.mysql:wykonaj("INSERT INTO bany SET nick=?, serial=?, ip=?, data=?, admin=?", getPlayerName(player), getPlayerSerial(player), getPlayerIP(player), final_date, getPlayerName(plr))
			kickPlayer(player, "Połącz się ponownie")
		elseif t1 == "d" then
			local t2 = tonumber(t2)
			local ts_final = ts_start + t2*86400
			local time = getRealTime(ts_final)
			local txt = getPlayerName(player).." został zbanowany przez "..getPlayerName(plr).." na czas "..t2.." dni z powodu "..text
			triggerClientEvent(getRootElement(), "notiAdmin", getRootElement(), txt)
			outputConsole(txt)
			local user_id = getElementData(player, "dbid")
			local user_serial = getPlayerSerial(player)
			local final_date = (time.year+1900).."-"..(time.month+1).."-"..(time.monthday).." "..(time.hour)..":"..(time.minute)..":"..(time.second)
			exports.mysql:wykonaj("INSERT INTO bany SET nick=?, serial=?, ip=?, data=?, admin=?", getPlayerName(player), getPlayerSerial(player), getPlayerIP(player), final_date, getPlayerName(plr))
			kickPlayer(player, "Połącz się ponownie")
	end
end

function kicknij(gracz, _, graczhere, ...)
	if graczhere and ... and getElementData(gracz, "duty") then
		graczhere = findPlayer(gracz, graczhere)
		if not graczhere then
			exports["crpg_powiadomienia"]:noti("Nie znaleziono podanego gracza.", gracz)
			return
		end
		local tresc = table.concat({...}, " ")
		local txt = getPlayerName(graczhere).." został wykopany przez "..getPlayerName(gracz).." z powodu "..tresc
		kickPlayer(graczhere, gracz, tresc)
		outputConsole(txt)
		triggerClientEvent(root, "notiAdmin", root, txt)
	end
end

function warnij(gracz, _, graczhere, ...)
	if graczhere and ... and getElementData(gracz, "duty") then
		graczhere = findPlayer(gracz, graczhere)
		if not graczhere then
			exports["crpg_powiadomienia"]:noti("Nie znaleziono podanego gracza.", gracz)
			return
		end
		local tresc = table.concat({...}, " ")
		local txt = getPlayerName(graczhere).." został ostrzeżony przez "..getPlayerName(gracz).." z powodu "..tresc
		outputChatBox(" ", graczhere, 255, 0, 0)
		outputChatBox("Otrzymałeś ostrzeżenie od "..getPlayerName(gracz), graczhere, 255, 0, 0)
		outputChatBox(" ", graczhere, 255, 0, 0)
		outputChatBox("Powód: "..tresc, graczhere, 255, 255, 255)
		outputChatBox(" ", graczhere, 255, 0, 0)
		outputChatBox("Nie stosowanie się do ostrzeżenia, może skutkować kickiem lub banem.", graczhere, 0, 131, 255)
		outputConsole(txt)
		triggerClientEvent(root, "notiAdmin", root, txt)
		triggerClientEvent(graczhere, "warnPlayer", root, {
			["powod"] = tresc,
			["kto"] = getPlayerName(gracz),
		})
	end
end

function prawko(plr, cmd, target, t1, t2, ...)
	if not getElementData(plr, "duty") then return end
	if not target or not t1 or not t2 or not ... then
		exports["aw-noti"]:noti("Poprawne użycie: /"..cmd.." <id/nick> <jednostka> <czas> <powód>", plr)
		return
	end
	local player = findPlayer(plr, target)
	if not player then 
		exports["aw-noti"]:noti("Nie znaleziono podanego gracza.", plr)
		return 
	end
		local text = table.concat({...}, " ")
		local ts_start = getTimestamp()
		if t1 == "m" then
			local t2 = tonumber(t2)
			local ts_final = ts_start + t2*60
			local time = getRealTime(ts_final)
			local txt = getPlayerName(player).." otrzymał zakaz prowadzenia pojazdów kat. A,B,C od "..getPlayerName(plr).." na czas "..t2.." minut z powodu "..text
			triggerClientEvent(getRootElement(), "notiAdmin", getRootElement(), txt)
			outputConsole(txt)
			local user_id = getElementData(player, "dbid")
			local user_serial = getPlayerSerial(player)
			removePedFromVehicle(player)
			local final_date = (time.year+1900).."-"..(time.month+1).."-"..(time.monthday).." "..(time.hour+1)..":"..(time.minute)..":"..(time.second)
			exports.mysql:wykonaj("INSERT INTO prawka SET nick=?, serial=?, ip=?, data=?, admin=?", getPlayerName(player), getPlayerSerial(player), getPlayerIP(player), final_date, getPlayerName(plr))
		elseif t1 == "h" then
			local t2 = tonumber(t2)
			local ts_final = ts_start + t2*3600
			local time = getRealTime(ts_final)
			removePedFromVehicle(player)
			local txt = getPlayerName(player).." otrzymał zakaz prowadzenia pojazdów kat. A,B,C od "..getPlayerName(plr).." na czas "..t2.." godzin z powodu "..text
			triggerClientEvent(getRootElement(), "notiAdmin", getRootElement(), txt)
			outputConsole(txt)
			local user_id = getElementData(player, "dbid")
			local user_serial = getPlayerSerial(player)
			local final_date = (time.year+1900).."-"..(time.month+1).."-"..(time.monthday).." "..(time.hour+1)..":"..(time.minute)..":"..(time.second)
			exports.mysql:wykonaj("INSERT INTO prawka SET nick=?, serial=?, ip=?, data=?, admin=?", getPlayerName(player), getPlayerSerial(player), getPlayerIP(player), final_date, getPlayerName(plr))
		elseif t1 == "d" then
			local t2 = tonumber(t2)
			removePedFromVehicle(player)
			local ts_final = ts_start + t2*86400
			local time = getRealTime(ts_final)
			local txt = getPlayerName(player).." otrzymał zakaz prowadzenia pojazdów kat. A,B,C od "..getPlayerName(plr).." na czas "..t2.." dni z powodu "..text
			triggerClientEvent(getRootElement(), "notiAdmin", getRootElement(), txt)
			outputConsole(txt)
			local user_id = getElementData(player, "dbid")
			local user_serial = getPlayerSerial(player)
			local final_date = (time.year+1900).."-"..(time.month+1).."-"..(time.monthday).." "..(time.hour+1)..":"..(time.minute)..":"..(time.second)
			exports.mysql:wykonaj("INSERT INTO prawka SET nick=?, serial=?, ip=?, data=?, admin=?", getPlayerName(player), getPlayerSerial(player), getPlayerIP(player), final_date, getPlayerName(plr))
	end
end

function report(gracz, cmd, graczhere, ...)
	if ... and graczhere then
		graczhere = findPlayer(gracz, graczhere)
		if not graczhere then 
			exports["crpg_powiadomienia"]:noti("Nie znaleziono podanego gracza.", gracz)
			return
		end
		local tekst = table.concat({...}, " ")
		exports["crpg_powiadomienia"]:noti("Pomyślnie wysłano zgłoszenie na gracza "..getPlayerName(graczhere).." o treści "..tekst, gracz)
		tekst = getPlayerName(gracz).."("..getElementData(gracz, "id")..") > "..getPlayerName(graczhere).."("..getElementData(graczhere, "id").."): "..tekst
		triggerClientEvent(root, "dRaps", root, tekst, getElementData(graczhere, "id"))
	else
		exports["crpg_powiadomienia"]:noti("Poprawne użycie: /"..cmd.." [id/nick] [powód]", gracz)
	end
end
addCommandHandler("report", report)
addCommandHandler("raport", report)

addCommandHandler("cl", function(gracz, _, graczh)
	if getElementData(gracz, "duty") and graczh then
		triggerClientEvent(root, "uRaps", root, graczh)
		exports["crpg_powiadomienia"]:noti("Pomyślnie usunięto reporta.", gracz)
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

--[[local serials = {
["25EFE28965FF8D1B625CF2C0EF312912"] = true, -- RAD3K
}

addEventHandler("onPlayerCommand", root, function(cmd)
	if cmd == "shutdown" then cancelEvent() end
	if cmd == "aexec" then cancelEvent() end
	if cmd == "runcode" then cancelEvent() end
	if cmd == "refreshall" then cancelEvent() end
	if cmd == "logout" then cancelEvent() end
	if cmd == "msg" then cancelEvent() end
	if cmd == "nick" then cancelEvent() end
	if cmd == "chgmypass" then cancelEvent() end
	if cmd == "ver" then cancelEvent() end
	if cmd == "whowas" then cancelEvent() end
	if cmd == "whois" then cancelEvent() end
	if cmd == "sver" then cancelEvent() end
	if cmd == "openports" then cancelEvent() end
	if cmd == "help" then cancelEvent() end
	if cmd == "debugdb" then cancelEvent() end
	if cmd == "ase" then cancelEvent() end
	if cmd == "stopall" then cancelEvent() end
	if cmd == "refreshall" then cancelEvent() end
	if not serials[getPlayerSerial(source)] then
		if cmd == "login" then cancelEvent() end
		if cmd == "register" then cancelEvent() end
		if cmd == "reloadmodule" then cancelEvent() end
		if cmd == "unloadmodule" then cancelEvent() end
		if cmd == "loadmodule" then cancelEvent() end
		if cmd == "delaccount" then cancelEvent() end
		if cmd == "addaccount" then cancelEvent() end
		if cmd == "aclrequest" then cancelEvent() end
		if cmd == "upgrade" then cancelEvent() end
		if cmd == "list" then cancelEvent() end
		if cmd == "check" then cancelEvent() end
		if cmd == "refreshall" then cancelEvent() end
		if cmd == "maps" then cancelEvent() end
		if cmd == "zarejestruj" then cancelEvent() end
	end
end)]]

--[[function globalChat(gracz, _, ...)
	if getElementData(gracz, "duty") and ... then
		local tekst = table.concat({...}, " ")
		local duty = getElementData(gracz, "duty")
		local c1, c2, c3 = 255, 255, 255
		if duty == 1 then
			c1, c2, c3 = 0, 255, 155
		elseif duty == 2 then
			c1, c2, c3 = 0, 100, 0
		elseif duty == 3 then
			c1, c2, c3 = 0, 155, 255
		elseif duty == 4 then
			c1, c2, c3 = 255, 0, 0
		end
		outputChatBox(">> "..tekst.." #ffffff- "..getPlayerName(gracz), root, c1, c2, c3, true)
	end
end]]

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

addCommandHandler("r", function(plr,cmd,...)
	if getElementData(plr, "duty") == 4 then
		local text=table.concat({...}, " ")
		outputChatBox("#FFFFFF[#950000RCON#FFFFFF] "..text.." #C0C0C0>>>#950000 "..getPlayerName(plr):gsub("#%x%x%x%x%x%x",""), root, 100, 0, 0,true)
	end
end)

addCommandHandler("a", function(plr,cmd,...)
	if getElementData(plr, "duty") == 3 then
		local text=table.concat({...}, " ")
		outputChatBox("#FFFFFF[#FF0000ADMINISTRATOR#FFFFFF] "..text.." #C0C0C0>>>#FF0000 "..getPlayerName(plr):gsub("#%x%x%x%x%x%x",""), root, 255, 0, 0,true)
	end
end)

addCommandHandler("m", function(plr,cmd,...)
	if getElementData(plr, "duty") == 2 then
		local text=table.concat({...}, " ")
		outputChatBox("#FFFFFF[#27DB0FMODERATOR#FFFFFF] "..text.." #C0C0C0>>>#27DB0F "..getPlayerName(plr):gsub("#%x%x%x%x%x%x",""), root, 0, 255, 255,true)
	end
end)

addCommandHandler("s", function(plr,cmd,...)
	if getElementData(plr, "duty") == 1 then
		local text=table.concat({...}, " ")
		outputChatBox("#FFFFFF[#00FFFFSUPPORT#FFFFFF] "..text.." #C0C0C0>>>#00FFFF "..getPlayerName(plr):gsub("#%x%x%x%x%x%x",""), root, 0, 255, 255,true)
	end
end)

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

function tpTo(gracz, _, graczhere)
	if getElementData(gracz, "duty") and graczhere then
		local graczhere = findPlayer(gracz, graczhere)
		if not graczhere then return end
		local x, y, z = getElementPosition(graczhere)
		setElementPosition(gracz, x, y, z)
		exports["crpg_powiadomienia"]:noti("Teleportowałeś się do "..getPlayerName(graczhere), gracz)
	end
end

function dpln(gracz, _, graczhere, ile)
	if getElementData(gracz, "duty") == 4 and graczhere and ile then
		local graczhere = findPlayer(gracz, graczhere)
		if not graczhere then return end
		ile = string.format("%1d", ile)
		setElementData(graczhere, "pieniadze", getElementData(graczhere, "pieniadze")+ile)
		exports["crpg_powiadomienia"]:noti("Dałeś "..ile.." PLN graczu "..getPlayerName(graczhere), gracz)
		exports["crpg_powiadomienia"]:noti("Otrzymałeś "..ile.." PLN od "..getPlayerName(gracz), graczhere)
	end
end

function dmp(gracz, _, graczhere, ile)
	if getElementData(gracz, "duty") == 4 and graczhere and ile then
		local graczhere = findPlayer(gracz, graczhere)
		if not graczhere then return end
		setElementData(graczhere, "punkty", getElementData(graczhere, "punkty")+ile)
		exports["crpg_powiadomienia"]:noti("Dałeś "..ile.." RP graczu "..getPlayerName(graczhere), gracz)
		exports["crpg_powiadomienia"]:noti("Otrzymałeś "..ile.." RP od "..getPlayerName(gracz), graczhere)
	end
end

function paliwo(gracz)
	if getElementData(gracz, "duty") and isPedInVehicle(gracz) then
		local pojazd = getPedOccupiedVehicle(gracz)
		if not pojazd then return end
		local bak = getElementData(pojazd, "bak") or 100
		setElementData(pojazd, "paliwo", bak)
		exports["crpg_powiadomienia"]:noti("Zatankowałeś pojazd.", gracz)
	end
end

function tpToHere(gracz, _, graczhere)
	if getElementData(gracz, "duty") and graczhere then
		local graczhere = findPlayer(gracz, graczhere)
		if not graczhere then return end
		local x, y, z = getElementPosition(gracz)
		setElementPosition(graczhere, x, y, z)
		exports["crpg_powiadomienia"]:noti("Teleportowałeś do siebie użytkownika "..getPlayerName(graczhere), gracz)
	end
end

function tpv(gracz, _, id)
	if getElementData(gracz, "duty") and id then
		id = tonumber(id)
		for i,v in ipairs(getElementsByType("vehicle")) do
			if getElementData(v, "id") and getElementData(v, "id") == id then
				local x, y, z = getElementPosition(v)
				setElementPosition(gracz, x, y, z)
			end
		end
	end
end

function tpvh(gracz, _, id)
	if getElementData(gracz, "duty") and id then
		id = tonumber(id)
		for i,v in ipairs(getElementsByType("vehicle")) do
			if getElementData(v, "id") and getElementData(v, "id") == id then
				local x, y, z = getElementPosition(gracz)
				setElementPosition(v, x, y, z)
			end
		end
	end
end

function aChat(gracz, _, ...)
	if ... and getElementData(gracz, "duty") then
		local tekst = table.concat({...}, " ")
		for i,v in ipairs(getElementsByType("player")) do
			if getElementData(v, "duty") then
				outputChatBox("#ff0000[Administracja]#ffffff "..getPlayerName(gracz)..": "..tekst, v, 255, 255, 255, true)
			end
		end
	end
end

function inv(gracz)
	if getElementData(gracz, "duty") then
		if getElementAlpha(gracz) == 255 then
			setElementAlpha(gracz, 0)
		else
			setElementAlpha(gracz, 255)
		end
	end
end

addCommandHandler("fix", function(plr,cmd)
	if getElementData(plr, "duty") then
		local veh=getPedOccupiedVehicle(plr)
		if not veh then
	        exports["crpg_powiadomienia"]:noti("Nie znajdujesz się w pojeżdzie!", plr)	
			return
		end
		setElementHealth(veh, 1000)
		fixVehicle(veh)
	    exports["crpg_powiadomienia"]:noti("Pojazd został naprawiony!", plr)			
	end
end)

function spec(gracz, _, graczhere)
	if graczhere and getElementData(gracz, "duty") then
		graczhere = findPlayer(gracz, graczhere)
		if not graczhere then return end
		if getCameraTarget(gracz) == graczhere then
			setCameraTarget(gracz, gracz)
		else
			setCameraTarget(gracz, graczhere)
		end
	end
end

function komendy(gracz)
	if getElementData(gracz, "duty") then
		outputChatBox("Komendy administracji:", gracz)
outputChatBox("/k <id/nick> <powod> (wyrzucenie gracza z serwera)", gracz)
outputChatBox("/ban <id/nick> <jednostka> <czas> <powod> (zbanowanie gracza na serwerze)", gracz)
outputChatBox("/zp <id/nick> <jednostka <czas> <powod> (zabranie prawa jazdy gracza)", gracz)
outputChatBox("/jp (jectpack)", gracz)
outputChatBox("/tt <id/nick> (teleport do gracza)", gracz)
outputChatBox("/th <id/nick> (teleport gracza do siebie)", gracz)
outputChatBox("/vtt <id> (teleport do pojazdu)", gracz)
outputChatBox("/vth <id> (teleport pojazdu do siebie)", gracz)
outputChatBox("/warn <id/nick> <powod> (ostrzezenie gracza)", gracz)
outputChatBox("/daj.paliwo (danie paliwa do pojazdu)", gracz)
outputChatBox("/ac <tresc> (chat ekipy)", gracz)
	end
end

local komendy = {
{"tt",	tpTo},
{"th",	tpToHere},
{"daj.pln", dpln},
{"daj.paliwo", paliwo},
{"vtt", tpv},
{"vth", tpvh},
{"ac", aChat},
{"ban", zbanuj},
{"k", kicknij},
{"warn", warnij},
{"zp", prawko},
{"jp", jp},
{"spec", spec},
{"inv", inv},
{"cmd", komendy},
{"daj.rp", dmp},
}

addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(komendy) do
		addCommandHandler(v[1], v[2])
	end
end)

addCommandHandler("duty", function(gracz)
	local spr = exports.mysql:wykonaj("SELECT * FROM ekipa WHERE gracz=? AND serial=?", getPlayerName(gracz), getPlayerSerial(gracz))
	if #spr > 0 then
		if getElementData(gracz, "duty") then
			takeWeapon(gracz, 22)			
            toggleControl(gracz, "fire", false)
	        toggleControl(gracz, "aim_weapon", false)
			setElementData(gracz, "duty", false)
			setElementData(gracz, "hex", false)
			setElementData(gracz, "ranga", false)	
            exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Wylogowałeś się z duty!", gracz)				
            setElementModel(gracz, getElementData(gracz, "user:lastskinadmin"))
		else	
            toggleControl(gracz, "fire", true)
	        toggleControl(gracz, "aim_weapon", true)
			giveWeapon(gracz, 22)						
			setElementData(gracz, "duty", spr[1].tranga)
			setElementData(gracz, "ranga", spr[1].ranga)
			setElementData(gracz, "hex", spr[1].hex)
            exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Zalogowałeś się na duty!", gracz)				        
		end
	end
end)

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

function komenda_admins(plr)	
    local moderator = {}
	local administrator = {}
	local developer = {}
	local rcon = {}
  for i,v in ipairs(getElementsByType("player")) do
    
	if getElementData(v,"duty") == 4  then 
	  local r = getPlayerName(v).." #FFFFFF[#950000"..getElementData(v,"id").."#FFFFFF]"
		table.insert(rcon, r)
	elseif getElementData(v,"duty") == 3  then 
		local d = getPlayerName(v).." #FFFFFF[#ff0000"..getElementData(v,"id").."#FFFFFF]"
		table.insert(developer, d)
	elseif getElementData(v,"duty") == 2 then
		local a = getPlayerName(v).." #FFFFFF[#27DB0F"..getElementData(v,"id").."#FFFFFF]"
		table.insert(administrator, a)
	elseif getElementData(v,"duty") == 1 then
		local m = getPlayerName(v).." #FFFFFF[#00FFFF"..getElementData(v,"id").."#FFFFFF]"
		table.insert(moderator, m)	
  end
end


  if #rcon > 0 then
    outputChatBox("#C0C0C0☛ #950000Administratorzy RCON#ffffff: " ..table.concat(rcon,", "), plr,true,true,true,true,true)
  else
		outputChatBox("#C0C0C0☛ #950000Administratorzy RCON#ffffff: ✖ ",plr,true,true,true,true,true)
  end

    if #developer > 0 then
    outputChatBox("#C0C0C0☛ #FF0000Administratorzy#ffffff: " ..table.concat(developer,", "), plr,true,true,true,true,true)
  else
		outputChatBox("#C0C0C0☛ #FF0000Administratorzy#ffffff: ✖ ",plr,true,true,true,true,true)
  end

    if #administrator > 0 then
    outputChatBox("#C0C0C0☛ #27DB0FModeratorzy#ffffff: " ..table.concat(administrator,", "), plr,true,true,true,true,true)
  else
		outputChatBox("#C0C0C0☛ #27DB0FModeratorzy#ffffff: ✖ ",plr,true,true,true,true,true)
  end

    if #moderator > 0 then
    outputChatBox("#C0C0C0☛ #00FFFFSupporterzy#ffffff: " ..table.concat(moderator,", "), plr,true,true,true,true,true)
  else
		outputChatBox("#C0C0C0☛ #00FFFFSupporterzy#ffffff: ✖ ",plr,true,true,true,true,true)
  end
 


 end
addCommandHandler("admins", komenda_admins)

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

local zablokowane ={
['hydra'] = true,
['police lv'] = true,
['police ls'] = true,
['police sf'] = true,
['rhino'] = true,
['seasparrow'] = true,
['hunter'] = true,
['police'] = true,
['emperor'] = true,
}

addCommandHandler("p", function(plr, cmd, ...)
	if getElementData(plr, "duty") == 4 or getElementData(plr, "duty") == 3 then
        if (not ...) then
	        exports["crpg_powiadomienia"]:noti("Użyj: /p <model>", plr)		
            return
        end
		local model = table.concat ( { ... }, " " )
		if tonumber(model) ~= nil then
	    exports["crpg_powiadomienia"]:noti("Podaj nazwe nie ID!", plr)
		return end
		local model  = model:lower()
		if zablokowane[model] then
		return end
        local dim = getElementDimension(plr)
        local x,y,z = getElementPosition(plr)
        local r1,r2,r3 = getElementRotation(plr)
        local model = getVehicleModelFromName(model)
        local vehicle = getPedOccupiedVehicle(plr)
        if getPedOccupiedVehicle(plr) then
	    exports["crpg_powiadomienia"]:noti("Nie możesz podmienic pojazdu!", plr)			
        else
            pojazd = createVehicle(model, x, y, z, r1, r2, r3)
            setElementDimension(pojazd, dim)
			setElementPosition(plr,x, y, z+1.5)		
			setVehiclePlateText(pojazd, "RESPIONY")
			addEventHandler("onVehicleExit", pojazd, function(plr,seat)
			if seat ~= 0 then return end
			destroyElement(source)
			end)
        end
	else
	exports["crpg_powiadomienia"]:noti("Nie posiadasz uprawnień!", plr)	
    end
end)