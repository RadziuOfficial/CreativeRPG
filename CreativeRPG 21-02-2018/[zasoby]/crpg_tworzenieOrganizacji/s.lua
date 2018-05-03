--[[
  Autor: Asper
  Skrypt: System tworzenia organizacji
  Zakaz uzywania bez zgody autora!
  Zakaz udostepniania bez zgody autora!
]]

addEvent("sOrg", true)
addEventHandler("sOrg", root, function(nazwa, r1, r2, r3, r4, r5)
	if not nazwa then return end
	local online = getElementData(source, "online")
	online = tonumber(online)
	local kasa = getElementData(source, "pieniadze")
	kasa = tonumber(kasa)
	if online < 600 then
		exports["aw-noti"]:noti("Aby założyć organizacje musisz posiadać minimum przegrane 10 godzin.", source)
		return
	end
	if kasa < 10000 then
		exports["aw-noti"]:noti("Aby założyć organizacje musisz posiadać minimum £10000.00.", source)
		return
	end
	if getElementData(source, "organizacja") then 
		exports["aw-noti"]:noti("Posiadasz już organizacje.", source)
		return
	end
	exports.mysql:wykonaj("INSERT INTO organizacje SET nazwa=?, r1=?, r2=?, r3=?, r4=?, r5=?", nazwa, r1, r2, r3, r4, r5)
	local spr = exports.mysql:wykonaj("SELECT * FROM organizacje WHERE nazwa=?", nazwa)
	exports.mysql:wykonaj("UPDATE konta SET oranga=5, org=? WHERE dbid=?", spr[1].id, getElementData(source, "dbid"))
	local spr2 = exports.mysql:wykonaj("SELECT * FROM konta WHERE dbid=?", getElementData(source, "dbid"))
	setElementData(source, "org", spr2[1].org)
	setElementData(source, "oranga", spr2[1].oranga)
	setElementData(source, "organizacja", spr[1].nazwa)
	exports["aw-noti"]:noti("Założyłeś organizacje o nazwie "..nazwa.." za cene £10000.00.", source)
	setElementData(source, "pieniadze", kasa-10000)
end)