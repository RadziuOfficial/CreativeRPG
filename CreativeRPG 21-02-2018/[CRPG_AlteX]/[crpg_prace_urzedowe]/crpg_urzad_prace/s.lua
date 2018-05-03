--[[
Autor: Asper
Skrypt: Prace urzedowe
Zakaz udostepniania bez zgody autora!
Zakaz uzywania bez zgody autora!
]]

local marker = createMarker(1947.32, 2170.48, 10.82-1, "cylinder", 1.5, 0, 255, 255, 75)

function getElementsWithinMarker(marker)
	local markerColShape = getElementColShape(marker)
	local elements = getElementsWithinColShape(markerColShape)
	return elements
end

addEventHandler("onMarkerHit", marker, function(hit)
	triggerClientEvent(hit, "openGui_prace", hit)
end)

addEventHandler("onMarkerLeave", marker, function(hit)
	triggerClientEvent(hit, "closeGui_prace", hit)
end)

addEvent("dolacz:urzedowka", true)
addEventHandler("dolacz:urzedowka", root, function(nazwa)
	for i,v in ipairs(getElementsWithinMarker(marker)) do
		if v ~= source then
			triggerClientEvent(v, "closeGui_prace", v, true)
		end
	end
	setElementData(source, "urzedowka", nazwa)
	local query = exports.mysql:wykonaj("UPDATE konta SET urzedowka=? WHERE dbid=?", nazwa, getElementData(source, "Mechanik"))
	exports["crpg_powiadomienia"]:noti("Dołączyłeś od pracy urzędowej: "..nazwa, source)
	if not query then
		outputDebugString("query error: not add to urzedowka "..getElementData(source, "dbid"))
	end
end)

addEvent("odejdz:urzedowka", true)
addEventHandler("odejdz:urzedowka", root, function()
	for i,v in ipairs(getElementsWithinMarker(marker)) do
		if v ~= source then
			triggerClientEvent(v, "closeGui_prace", v, true)
		end
	end
	exports["crpg_powiadomienia"]:noti("Opuściłeś prace urzędową: "..getElementData(source, "urzedowka"), source)
	setElementData(source, "urzedowka", false)
	local query = exports.mysql:wykonaj("UPDATE konta SET urzedowka=? WHERE dbid=?", "", getElementData(source, "Mechanik"))
	if not query then
		outputDebugString("query error: not remove in urzedowka "..getElementData(source, "dbid"))
	end
end)

function update(element)
	if element then
		destroyElement(element)
	end
	local urzad = createElement("urzad")
	local mechanik_r = exports.mysql:wykonaj("SELECT * FROM konta WHERE urzedowka=?", "dbid")
	setElementData(urzad, "miejsca1", #mechanik_r)
end

addEventHandler("onResourceStart", resourceRoot, function()
	update()
end)

addEvent("updateMiejsca", true)
addEventHandler("updateMiejsca",root,function()
	for i,v in ipairs(getElementsByType("urzad")) do
		update(v)
	end
end)