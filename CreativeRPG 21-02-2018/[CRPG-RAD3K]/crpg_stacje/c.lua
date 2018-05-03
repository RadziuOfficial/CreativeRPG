--[[
  Autor: Asper
  Dla: .newMode
  Skrypt: Stacje paliw
]]

local screenW, screenH = guiGetScreenSize()
local gs = false
local czcionka = dxCreateFont(":crpg_fonty/f.ttf", 15) or "default-bold"

function guiStacja()
	if not isPedInVehicle(localPlayer) then
		return
	end
	local pojazd = getPedOccupiedVehicle(localPlayer)
	local paliwo = getElementData(pojazd, "paliwo") or 0
	paliwo = string.format("%1.2f", paliwo)
	local cena = "5.55"
	if getElementData(localPlayer, "premium") then
		cena = "3.55"
	end
	dxDrawImage(screenW * 0, screenH * 0, screenW * 1, screenH * 1, "panel.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)	
 	dxDrawText("Stan paliwa: "..paliwo.." litrów\nCena za litr paliwa: "..cena.." PLN\nAby zatankować 1 litr kliknij LPM.", screenW * -0.1300, screenH * 0.6450, screenW * 0.9854, screenH * 0.3815, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
end

addEvent("gStacja", true)
addEventHandler("gStacja", root, function()
	addEventHandler("onClientRender", root, guiStacja)
	gs = true
end)

addEvent("cgStacja", true)
addEventHandler("cgStacja", root, function()
	removeEventHandler("onClientRender", root, guiStacja)
	gs = false
end)

bindKey("mouse1", "down", function()
	if gs == true then
		local pojazd = getPedOccupiedVehicle(localPlayer)
		local paliwo = getElementData(pojazd, "paliwo") or 0
		local bak = getElementData(pojazd, "bak") or 100
		if tonumber(paliwo) and tonumber(paliwo) >= bak then 
			exports["nm-noti"]:noti("Bak pojazdu jest pełny.")
			return
		end
		local cena = "5.55"
		if getElementData(localPlayer, "premium") then
			cena = "3.55"
		end
		cena = tonumber(cena)
		local hajs = getElementData(localPlayer, "pieniadze")
		if hajs > cena then
			setElementData(localPlayer, "pieniadze", hajs-cena)
			local paliwo = getElementData(pojazd, "paliwo") or 0
			setElementData(pojazd, "paliwo", paliwo+1)
		else
			exports["nm-noti"]:noti("Brak funduszy na tankowanie pojazdu.")
		end
	end
end)