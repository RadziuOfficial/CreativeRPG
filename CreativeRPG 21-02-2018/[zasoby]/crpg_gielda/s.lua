--[[
  Autor: Asper
  Skrypt: Gielda
]]

local cuboid = {}

addEvent("kuppojazd:gielda", true)
addEventHandler("kuppojazd:gielda", root, function(pojazd)
	local gracz = source
	local gielda = getElementData(pojazd, "gielda")
	if not gielda then return end
	local kasa = getElementData(gracz, "pieniadze")
	gielda.cena = string.format("%d", gielda.cena)
	if kasa < tonumber(gielda.cena) then
        exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Nie posiadasz funduszy aby zakupić ten pojazd!", gracz)		
		return
	end
	if getPlayerName(gracz) == gielda.wlasciciel then exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Nie możesz zakupic swojego pojazdu!", source) return end
	local model = getVehicleName(pojazd)
    exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Zakupiłeś pojazd "..model.." za "..gielda.cena.." PLN od gracza "..gielda.wlasciciel, gracz)		
	setElementData(gracz, "pieniadze", kasa-gielda.cena)
	setElementData(pojazd, "wlasciciel", getElementData(gracz, "dbid"))
	warpPedIntoVehicle(gracz, pojazd)
	exports.mysql:wykonaj("UPDATE konta SET bkasa=bkasa+? WHERE dbid=?", gielda.cena, gielda.uwlasciciel)
	exports.mysql:wykonaj("UPDATE pojazdy SET wlasciciel=? WHERE id=?", getElementData(gracz, "dbid"), getElementData(pojazd, "id"))
	setElementData(pojazd, "gielda", false)
	setElementData(pojazd, "nametag", false)
	if cuboid[pojazd] and isElement(cuboid[pojazd]) then
		destroyElement(cuboid[pojazd])
	end
	for i,v in ipairs(getElementsByType("player")) do
		if getPlayerName(v) == gielda.wlasciciel and getElementData(v, "dbid") then
			setElementData(v, "pieniadze", getElementData(v, "pieniadze")+gielda.cena)
		else
			exports.mysql:wykonaj("UPDATE konta SET bkasa=bkasa+? WHERE dbid=?", gielda.cena, gielda.uwlasciciel)
		end
	end
end)

local cuboides = createColCuboid(1718.1804, 1859.4744, 9.6203127, 39, 183.5, 3.75)

addEvent("gielda", true)
addEventHandler("gielda", root, function(pojazd)
	local x,y,z = getElementPosition(pojazd)
	cuboid[pojazd] = createColSphere(x, y, z, 3.5)
    attachElements(cuboid[pojazd], pojazd, 0, 0, 0.5)
end)

addEventHandler("onColShapeHit", resourceRoot, function(hit)
	if getElementType(hit) ~= "player" then return end
  if source == cuboides then return end
  local pojazd = getPedOccupiedVehicle(hit)
  if pojazd then return end
  local pojazdy = getElementsWithinColShape(source, "vehicle")
  if #pojazdy < 1 then return end
  if #pojazdy > 1 then return end
  local gielda = getElementData(pojazdy[1], "gielda")
  if not gielda then return end
  triggerClientEvent(hit, "cuboid", hit, pojazdy[1])
end)

addEventHandler("onColShapeHit", cuboides, function(hit)
  if getElementType(hit) ~= "player" then return end
  local pojazd = getPedOccupiedVehicle(hit)
  if not pojazd then return end
    if cuboid[pojazd] then
      destroyElement(cuboid[pojazd])
      cuboid[pojazd] = false
    end
    setElementData(pojazd, "gielda", false)
    setElementData(pojazd, "nametag", false)
end)

addEventHandler("onColShapeLeave", cuboides, function(hit)
  if getElementType(hit) ~= "player" then return end
  local pojazd = getPedOccupiedVehicle(hit)
  if not pojazd then return end
    if cuboid[pojazd] then
      destroyElement(cuboid[pojazd])
      cuboid[pojazd] = false
    end
    setElementData(pojazd, "gielda", false)
    setElementData(pojazd, "nametag", false)
end)