--[[
Autor: Asper
Dla: .newMode
Skrypt: Logi serwera w gui
Typ: Server
]]

function data()
	local t = getRealTime()
	local r = t.year
	local m = t.month
	local t = t.monthday
	r = r+1900
	m = m+1
	if t < 10 then
		t = "0"..t
	end
	return r.."-"..m.."-"..t
end

function czas()
	local t = getRealTime()
	local h = t.hour
	local m = t.minute
	return h..":"..m
end

addCommandHandler("logi", function(g)
	if getElementData(g, "duty") then
		local spr = exports.mysql:wykonaj("SELECT * FROM logi")
		triggerClientEvent(g, "lLogow", g, spr)
	end
end)

addEvent("dodajLogi", true)
addEventHandler("dodajLogi", root, function(tresc, typ)
	exports.mysql:wykonaj("INSERT INTO logi SET nick=?, tresc=?, serial=?, typ=?, data=?", getPlayerName(source), tresc, getPlayerSerial(source), typ, data().." "..czas())
end)