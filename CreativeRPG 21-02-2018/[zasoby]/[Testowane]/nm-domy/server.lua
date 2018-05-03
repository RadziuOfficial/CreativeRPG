--[[
Autor: Asper
Edytował: Malentas
Skrypt: System domow
]]

addEventHandler("onResourceStart", resourceRoot, function()
	local q = exports.mysql:wykonaj("SELECT * FROM domy")
	for i,v in ipairs(q) do
		v.wejscie = split(v.wejscie, ",")
if v.nwlasciciel:len() < 3 then id = 1273 else id = 1272 end
		local wejscie = createPickup(v.wejscie[1], v.wejscie[2], v.wejscie[3], 3, id, 0, 0)
		local cwejscie = createColSphere(v.wejscie[1], v.wejscie[2], v.wejscie[3], 1)
		local wlasciciel = false
		local nwlascciiel = false
		if id == 1273 then
			wlasciciel = "brak"
			nwlasciciel = "brak"
		else
			wlasciciel = v.wlasciciel
			nwlasciciel = v.nwlasciciel
		end
		v.wyjscie = split(v.wyjscie, ",")
		v.tpw = split(v.tpw, ",")
		setElementData(cwejscie, "dom", {
		["id"]=v.id,
		["wlasciciel"]=wlasciciel,
		["nwlasciciel"]=nwlasciciel,
		["cena"]=v.cena,
		["nazwa"]=v.nazwa,
		["x"]=v.tpw[1],
		["y"]=v.tpw[2],
		["z"]=v.tpw[3],
		["data"]=v.data,
		["int"]=v.int,
		})
		--local wyjscie = createMarker(v.wyjscie[1], v.wyjscie[2], v.wyjscie[3]+1, "arrow", 1, 0, 94, 254)
		local wyjscie = createMarker(2807.60, -1174.75, 1025.57+0.8, "arrow", 1, 0, 94, 254)		
		setElementData(wyjscie, "wdom", {
		["x"]=v.wejscie[1],
		["y"]=v.wejscie[2],
		["z"]=v.wejscie[3],
		})
		setElementInterior(wyjscie, v.int)
		setElementDimension(wyjscie, v.id)
	end
end)

function refreshDomy()
	local q = exports.mysql:wykonaj("SELECT * FROM domy")
	for i,v in ipairs(q) do
	local qq = exports.mysql:wykonaj("SELECT * FROM domy WHERE id=?", v.id)
	local t = getRealTime()
	local r = t.year
	local m = t.month
	local t = t.monthday
	r = r+1900
	m = m+1
	if t < 10 then
		t = "0"..t
	end
	local data = r.."-"..m.."-"..t
	if qq[1].data == data then
		exports.mysql:wykonaj("UPDATE domy SET wlasciciel=0, nwlasciciel=?, data=? WHERE id=?", "", "0000-00-00", q[1].id)
		restartResource(getThisResource())
	end
	end
end
setTimer(refreshDomy, 3600000, 0)

addCommandHandler("dom", function(g, _, c, ...)
	if ... and c and getElementData(g, "duty") == 4 then
		local x, y, z = getElementPosition(g)
		local n = table.concat({...}, " ")
		outputChatBox("Dom na "..x..":"..y..":"..z.." nazwa "..n.." za cene "..c.." PLN", g)
		local wejscie = x..","..y..","..z
		exports.mysql:wykonaj("INSERT INTO domy SET wlasciciel=0, nwlasciciel=?, nazwa=?, data=?, wejscie=?, wyjscie=?, tpw=?, cena=?", "", n, "0000-00-00", wyjscie, "2807.61, -1174.76, 1025.57", "2807.69, -1172.22, 1025.57", c)
		restartResource(getThisResource())
	end
end)

addEvent("zDom", true)
addEventHandler("zDom", root, function(id)
	exports.mysql:wykonaj("UPDATE domy SET wlasciciel=0, nwlasciciel=?, data=? WHERE id=?", "", "0000-00-00", id)
	restartResource(getThisResource())
end)

local function getPlayerDBID(plr)
	local c=getElementData(plr,"dbid")
	if not c then return nil end
	return tonumber(c)
end

addEvent("kDom", true)
addEventHandler("kDom", root, function(id, dni, koszt)
	if not id and not dni and not koszt then return end
	local dbid = getPlayerDBID(client)
	local hajs = getElementData(client, "pieniadze")
	koszt = dni*koszt
	koszt = koszt
	if tonumber(koszt) > hajs then
		outputChatBox("Nie stać cię na zakup tego domu, potrzebujesz "..koszt.." PLN.", client)
		return
	end
	local r = exports.mysql:wykonaj("UPDATE domy SET wlasciciel=?,nwlasciciel=?,data=IF(data>NOW(),data,NOW())+INTERVAL ? DAY WHERE id=?", dbid, getPlayerName(client), dni, id)
	setElementData(client, "pieniadze", hajs-koszt)
		outputChatBox("Zakupiłeś/przedłużyłeś mieszkanie o id "..id.." na ilość dni "..dni.." za cene "..koszt.." PLN.", client)
	restartResource(getThisResource())
end)

addEvent("tdDomu", true)
addEventHandler("tdDomu", root, function(x, y, z, int, dim)
	if int and dim then
		setElementInterior(client, int)
		setElementDimension(client, dim)
	else
		setElementDimension(client, 0)
		setElementInterior(client, 0)
	end
	setElementPosition(client, x, y, z)
end)