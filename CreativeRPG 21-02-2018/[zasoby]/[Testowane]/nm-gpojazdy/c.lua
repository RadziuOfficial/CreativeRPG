--[[
Autor: Asper
Dla: .newMode
Skrypt: Pojazdy gracza
Typ: Client
]]

local nick = guiCreateEdit(0.60, 0.32, 0.10, 0.06, "Nick/rejestracja", true)
local lista = guiCreateGridList(0.30, 0.32, 0.29, 0.42, true)    
guiGridListAddColumn(lista, "ID", 0.1)
guiGridListAddColumn(lista, "Model", 0.15)
guiGridListAddColumn(lista, "Lokalizacja", 0.3)
guiGridListAddColumn(lista, "Organizacja", 0.17)
guiGridListAddColumn(lista, "Rejestracja", 0.15)
guiSetVisible(lista, false)  
guiSetVisible(nick, false)   

addEventHandler("onClientGUIClick", nick, function()
	if guiGetText(nick) == "Nick/rejestracja" then
		guiSetText(nick, "")
	end
end)

local screenW, screenH = guiGetScreenSize()
local sx, sy = guiGetScreenSize()

function mysz(psx,psy,pssx,pssy,abx,aby)
    if not isCursorShowing() then return end
    cx,cy=getCursorPosition()
    cx,cy=cx*sx,cy*sy
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true,cx,cy
    else
        return false
    end
end  


local czcionka = dxCreateFont(":crpg_fonty/f.ttf", 10)
if not czcionka then czcionka = "default-bold" end
local organizacja = "?"
local rejestracja = "?"

function gui()
        exports["nm-blur"]:dxDrawBluredRectangle(screenW * 0.2950, screenH * 0.2461, screenW * 0.4100, screenH * 0.5091, tocolor(150, 150, 150, 255))
        dxDrawRectangle(screenW * 0.2943, screenH * 0.2461, screenW * 0.4107, screenH * 0.0599, tocolor(78, 174, 1, 255), false)
        dxDrawText("Panel pojazdów", (screenW * 0.2943) + 1, (screenH * 0.2461) + 1, (screenW * 0.7050) + 1, (screenH * 0.3060) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Panel pojazdów", screenW * 0.2943, screenH * 0.2461, screenW * 0.7050, screenH * 0.3060, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
       
        if mysz(screenW * 0.6025, screenH * 0.6719, screenW * 0.0952, screenH * 0.0703) then
          dxDrawRectangle(screenW * 0.6025, screenH * 0.6719, screenW * 0.0952, screenH * 0.0703, tocolor(78, 174, 1, 255), false)
        else
          dxDrawRectangle(screenW * 0.6025, screenH * 0.6719, screenW * 0.0952, screenH * 0.0703, tocolor(78, 174, 1, 255), false)
        end

        if mysz(screenW * 0.6025, screenH * 0.5885, screenW * 0.0952, screenH * 0.0703) then
          dxDrawRectangle(screenW * 0.6025, screenH * 0.5885, screenW * 0.0952, screenH * 0.0703, tocolor(78, 174, 1, 255), false)
        else
          dxDrawRectangle(screenW * 0.6025, screenH * 0.5885, screenW * 0.0952, screenH * 0.0703, tocolor(78, 174, 1, 255), false)
        end

        if mysz(screenW * 0.6025, screenH * 0.5052, screenW * 0.0952, screenH * 0.0703) then
          dxDrawRectangle(screenW * 0.6025, screenH * 0.5052, screenW * 0.0952, screenH * 0.0703, tocolor(78, 174, 1, 255), false)
        else
          dxDrawRectangle(screenW * 0.6025, screenH * 0.5052, screenW * 0.0952, screenH * 0.0703, tocolor(78, 174, 1, 255), false)
        end

        if mysz(screenW * 0.6025, screenH * 0.4252, screenW * 0.0952, screenH * 0.0703) then
          dxDrawRectangle(screenW * 0.6025, screenH * 0.4252, screenW * 0.0952, screenH * 0.0703, tocolor(78, 174, 1, 255), false)
        else
          dxDrawRectangle(screenW * 0.6025, screenH * 0.4252, screenW * 0.0952, screenH * 0.0703, tocolor(78, 174, 1, 255), false)
        end

        dxDrawText("Zmień rejestracje\nCena: 5000.00 PLN", (screenW * 0.6025) + 1, (screenH * 0.4239) + 1, (screenW * 0.6977) + 1, (screenH * 0.5000) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, true, false, false, false)
        dxDrawText("Zmień rejestracje\nCena: 5000.00 PLN", screenW * 0.6025, screenH * 0.4239, screenW * 0.6977, screenH * 0.5000, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, true, false, false, false)
        dxDrawText("Przepisz lub wypisz pojazd na organizacje", (screenW * 0.6025) + 1, (screenH * 0.5885) + 1, (screenW * 0.6977) + 1, (screenH * 0.6589) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, true, false, false, false)
        dxDrawText("Przepisz lub wypisz pojazd na organizacje", screenW * 0.6025, screenH * 0.5885, screenW * 0.6977, screenH * 0.6589, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, true, false, false, false)
        dxDrawText("Daj lub zabierz klucze", (screenW * 0.6025) + 1, (screenH * 0.5039) + 1, (screenW * 0.6977) + 1, (screenH * 0.5755) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, true, false, false, false)
        dxDrawText("Daj lub zabierz klucze", screenW * 0.6025, screenH * 0.5039, screenW * 0.6977, screenH * 0.5755, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, true, false, false, false)
        dxDrawText("Zamknij panel", (screenW * 0.6025) + 1, (screenH * 0.6706) + 1, (screenW * 0.6977) + 1, (screenH * 0.7422) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, true, false, false, false)
        dxDrawText("Zamknij panel", screenW * 0.6025, screenH * 0.6706, screenW * 0.6977, screenH * 0.7422, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, true, false, false, false)
end

addEvent("listaPC", true)
addEventHandler("listaPC", root, function()
    guiSetVisible(nick, false)
    guiSetVisible(lista, false)
    removeEventHandler("onClientPreRender", root, gui)
    showCursor(false)
    showChat(true)
end)

addEvent("listaP", true)
addEventHandler("listaP", root, function(s)
  guiSetVisible(lista, true)
  addEventHandler("onClientPreRender", root, gui)
  showCursor(true, false)
  guiGridListClear(lista)
  showChat(false)
  guiSetVisible(nick, true)
  if not s then return end
  for _, p in pairs(s) do
    local spr = guiGridListAddRow(lista)
    guiGridListSetItemText(lista, spr, 1, p["id"], false, false)
    guiGridListSetItemText(lista, spr, 2, getVehicleNameFromModel(p["model"]), false, false)
    local lok = "Przechowalnia"
    for i,v in ipairs(getElementsByType("vehicle")) do
      if getElementData(v, "id") == p["id"] then
        local x, y, z = getElementPosition(v)
        lok = getZoneName(x, y, z, true)..", "..getZoneName(x, y, z, false)
      end
    end
    guiGridListSetItemText(lista, spr, 3, lok, false, false)
    if p["organizacja"] ~= "" then
    	organizacja = p["organizacja"]
    else
    	organizacja = "brak"
    end
    if p["rejestracja"]:len() > 2 then
    	rejestracja = p["rejestracja"]
    else
    	rejestracja = "crpg_"..p["id"]
    end
    guiSetText(nick, "Nick/rejestracja")
    guiGridListSetItemText(lista, spr, 4, organizacja, false, false)
    guiGridListSetItemText(lista, spr, 5, rejestracja, false, false)
  end
end)

addEventHandler("onClientClick", root, function(b, s)
	if b ~= "state" and s ~= "down" then return end
	if mysz(screenW * 0.6025, screenH * 0.6719, screenW * 0.0952, screenH * 0.0703) and guiGetVisible(lista) == true then
		guiSetVisible(lista, false)
		removeEventHandler("onClientPreRender", root, gui)
		showCursor(false)
    	showChat(true)
		guiSetVisible(nick, false)
	elseif mysz(screenW * 0.6025, screenH * 0.5052, screenW * 0.0952, screenH * 0.0703) and guiGetVisible(lista) == true then
		local gracz = guiGetText(nick)
		if gracz == "Nick/rejestracja" then return end
		if gracz:len() < 2 then return end
		local wy = guiGridListGetSelectedItem(lista)
		local id = guiGridListGetItemText(lista, wy, 1)
		triggerServerEvent("gKeys", resourceRoot, localPlayer, id, gracz)
	elseif mysz(screenW * 0.6025, screenH * 0.5885, screenW * 0.0952, screenH * 0.0703) and guiGetVisible(lista) == true then
		local wy = guiGridListGetSelectedItem(lista)
		local id = guiGridListGetItemText(lista, wy, 1)
		triggerServerEvent("kOrg", resourceRoot, localPlayer, id)
	elseif mysz(screenW * 0.6025, screenH * 0.4252, screenW * 0.0952, screenH * 0.0703) and guiGetVisible(lista) == true then
		local rejka = guiGetText(nick)
		if rejka == "Nick/rejestracja" then return end
		if rejka:len() < 1 then
			exports["crpg_powiadomienia"]:noti("Rejestracja powinna zawierać minimum 1 znak.")
		 	return 
		end
		if rejka:len() > 8 then
			exports["crpg_powiadomienia"]:noti("Rejestracja powinna zawierać maksimum 8 znaków.")
			return
		end
		local wy = guiGridListGetSelectedItem(lista)
		local id = guiGridListGetItemText(lista, wy, 1)
		triggerServerEvent("gRejka", resourceRoot, localPlayer, id, rejka)
	end
end)