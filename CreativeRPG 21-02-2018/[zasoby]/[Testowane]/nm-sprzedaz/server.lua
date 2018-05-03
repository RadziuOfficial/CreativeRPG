--[[
	Autor: Asper
	Dla servera: .newMode
	Skrypt: Sprzedaz pojazdow
]]

local sprzedaz = {
{-2690.83, 260.39, 4.33},
}

local msprzedaz = false

addEvent("sprzedaz", true)
addEventHandler("sprzedaz", root, function(p, c, n, pp, id)
	if not p and not c and not n then return end
	local gracz = findPlayer(p, n)
	if not gracz then outputChatBox("Nie znaleziono podanego gracza.", p, 255, 0, 0) return end
	if not getElementData(gracz, "ms") then outputChatBox("Ten gracz nie znajduje sie w punkcie sprzedazy.", p, 255, 0, 0) return end
	outputChatBox("Wysłano oferte sprzedazy pojazdu o id "..id.." do gracza "..getPlayerName(gracz).." za cene "..string.format("%1.2f", c).." PLN", p, 255, 255, 255)
  outputChatBox("Gracz "..getPlayerName(p).." oferuje ci kupno pojazdu "..pp.." o id "..id.." za cene "..string.format("%1.2f", c).." PLN aby zakupić pojazd wpisz /zakup <id> <cena>", gracz, 255, 255, 255)
	setElementData(gracz, "ofertaKupna", p)
	setElementData(gracz, "coid", id)
end)

addCommandHandler("zakup", function(p, _, i, c)
	if not i or not c then return end
	local o = getElementData(p, "ofertaKupna")
	if not o then return end
	if i ~= getElementData(p, "coid") then return end
	outputChatBox("Zakupiłeś pojazd o id "..i.." za cene "..string.format("%1.2f", c).." PLN od gracza "..getPlayerName(o), p, 255, 255, 255)
	outputChatBox("Gracz "..getPlayerName(p).." zakupił od ciebie pojazd o id "..i.." za cene "..string.format("%1.2f", c).." PLN", o, 255, 255, 255)
	local wyk = exports.mysql:wykonaj("UPDATE pojazdy SET wlasciciel=? WHERE id=?", getElementData(p, "dbid"), i)
	takePlayerMoney(p, c*100)
	givePlayerMoney(o, c*100)
	for _, v in pairs(getElementsByType("vehicle")) do
		if getElementData(v, "id") then
			if getElementData(v, "id") == tonumber(i) then
				setElementData(v, "wlasciciel", getElementData(p, "dbid"))
			end
		end
	end
	setElementData(p, "coid", false)
	setElementData(p, "ofertaKupna", false)
end)


addEventHandler("onResourceStart", resourceRoot, function()
	for _, m in ipairs(sprzedaz) do
		msprzedaz = createMarker(m[1], m[2], m[3]-1, "cylinder", 1.5, 255, 255, 255, 75)
	end
end)

addEventHandler("onMarkerHit", resourceRoot, function(hit)
	if source == msprzedaz then
		if getElementType(hit) == "player" then
			local spr = exports.mysql:wykonaj("SELECT * FROM pojazdy WHERE wlasciciel=? AND przechowalnia=0", getElementData(hit, "dbid"))
			triggerClientEvent(hit, "lista", hit, spr)
			setElementData(hit, "ms", true)
		end
	end
end)

addEventHandler("onMarkerLeave", resourceRoot, function(hit)
	if source == msprzedaz then
	if getElementType(hit) ~= "player" then return end
		triggerClientEvent(hit, "oknoSell", hit)
		setElementData(hit, "ms", false)
		setElementData(hit, "ofertaKupna", false)
	end
end)

function findPlayer(plr, cel)
	local target = nil
	if (tonumber(cel) ~= nil) then
		target = getElementByID("p"..cel)
	else
		for _,thePlayer in ipairs(getElementsByType("player")) do
			if string.find(string.gsub(getPlayerName(thePlayer):lower(),"#%x%x%x%x%x%x", ""), cel:lower(), 1, true) then
				if (target) then
					outputChatBox("Znaleziono wiecej niz jednego gracza o pasujacym nicku, podaj wiecej liter.", plr)
					return nil
				end
				target=thePlayer
			end
		end
	end
	return target
end