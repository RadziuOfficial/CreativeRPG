--[[
Autor: Asper
Skrypt: Prace urzedowe
Zakaz udostepniania bez zgody autora!
Zakaz uzywania bez zgody autora!
]]

function dxDrawButton(x, y, w, h, color)
  local color2 = tocolor(0,255,25)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x-0.4660164, y + h-1.6, w+1.5, 2, color2, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 3, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 3, color, false)
end

local screenW, screenH = guiGetScreenSize()
local sx, sy = guiGetScreenSize()

function isMouseIn(psx,psy,pssx,pssy,abx,aby)
    if not isCursorShowing() then return end
    cx,cy=getCursorPosition()
    cx,cy=cx*sx,cy*sy
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true,cx,cy
    else
        return false
    end
end

local prace = {}

local czcionka = dxCreateFont(":crpg_fonty/f.ttf", 15)
if not czcionka then
    czcionka = czcionka
end
  
local grid = false
local gridlist = false

function roundedRectangle(x, y, w, h, color)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x + 2, y + h, w - 4, 1, color, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 4, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 4, color, false)
end

function gui()
        roundedRectangle(screenW * 0.3380, screenH * 0.2602, screenW * 0.3245, screenH * 0.4796, tocolor(15,15,15,222), false)
        roundedRectangle(screenW * 0.3380, screenH * 0.2602, screenW * 0.3245, screenH * 0.0509, tocolor(0,255,25,125), false)
        dxDrawText("Panel prac urzędowych", (screenW * 0.3380) + 1, (screenH * 0.2593) + 1, (screenW * 0.6625) + 1, (screenH * 0.3111) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Panel prac urzędowych", screenW * 0.3380, screenH * 0.2593, screenW * 0.6625, screenH * 0.3111, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        if isMouseIn(screenW * 0.3536, screenH * 0.6694, screenW * 0.1344, screenH * 0.0565) then
            dxDrawButton(screenW * 0.3536, screenH * 0.6694, screenW * 0.1344, screenH * 0.0565, tocolor(0,255,25,125), false)
        else
            dxDrawButton(screenW * 0.3536, screenH * 0.6694, screenW * 0.1344, screenH * 0.0565, tocolor(30,30,30,225), false)
        end
        if isMouseIn(screenW * 0.5109, screenH * 0.6694, screenW * 0.1344, screenH * 0.0565) then
            dxDrawButton(screenW * 0.5109, screenH * 0.6694, screenW * 0.1344, screenH * 0.0565, tocolor(0,255,25,125), false)
        else
            dxDrawButton(screenW * 0.5109, screenH * 0.6694, screenW * 0.1344, screenH * 0.0565, tocolor(30,30,30,225), false)
        end
        dxDrawText("Zatrudnij się", (screenW * 0.3531) + 1, (screenH * 0.6694) + 1, (screenW * 0.4880) + 1, (screenH * 0.7259) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Zatrudnij się", screenW * 0.3531, screenH * 0.6694, screenW * 0.4880, screenH * 0.7259, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Anuluj", (screenW * 0.5109) + 1, (screenH * 0.6694) + 1, (screenW * 0.6458) + 1, (screenH * 0.7259) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Anuluj", screenW * 0.5109, screenH * 0.6694, screenW * 0.6458, screenH * 0.7259, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
end

function gui2()
        roundedRectangle(screenW * 0.3745, screenH * 0.3231, screenW * 0.2516, screenH * 0.1981, tocolor(15,15,15,222), false)
        roundedRectangle(screenW * 0.3745, screenH * 0.3231, screenW * 0.2516, screenH * 0.0509, tocolor(0,255,25,125), false)
        dxDrawText("Panel pracy urzędowej", (screenW * 0.3745) + 1, (screenH * 0.3231) + 1, (screenW * 0.6260) + 1, (screenH * 0.3741) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Panel pracy urzędowej", screenW * 0.3745, screenH * 0.3231, screenW * 0.6260, screenH * 0.3741, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Aby zwolnić się z pracy urzędowej '"..getElementData(localPlayer, "urzedowka").."'\nkliknij w poniższy przycisk.", (screenW * 0.3839) + 1, (screenH * 0.3833) + 1, (screenW * 0.6208) + 1, (screenH * 0.4398) + 1, tocolor(0, 0, 0, 255), 0.7, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Aby zwolnić się z pracy urzędowej '"..getElementData(localPlayer, "urzedowka").."'\nkliknij w poniższy przycisk.", screenW * 0.3839, screenH * 0.3833, screenW * 0.6208, screenH * 0.4398, tocolor(255, 255, 255, 255), 0.7, czcionka, "center", "center", false, false, false, false, false)
        if isMouseIn(screenW * 0.4307, screenH * 0.4491, screenW * 0.1417, screenH * 0.0528) then
            dxDrawButton(screenW * 0.4307, screenH * 0.4491, screenW * 0.1417, screenH * 0.0528, tocolor(0,255,25,125), false)
        else
            dxDrawButton(screenW * 0.4307, screenH * 0.4491, screenW * 0.1417, screenH * 0.0528, tocolor(30,30,30,225), false)
        end
        dxDrawText("Zwolnij się", (screenW * 0.4307) + 1, (screenH * 0.4491) + 1, (screenW * 0.5724) + 1, (screenH * 0.5019) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Zwolnij się", screenW * 0.4307, screenH * 0.4491, screenW * 0.5724, screenH * 0.5019, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
end

local lista = {
{"Mechanik", 150, 0, 5},
}

function sprawdzMiejsca()
	if grid ~= true then
    	showCursor(true)
    	addEventHandler("onClientPreRender", root, gui)
    end
	exports["dxlists"]:dxDestroy(1)
    gridlist = exports["dxlists"]:dxCreate(screenW * 0.3453, screenH * 0.3213, screenW * 0.3120, screenH * 0.3389,  1)
    exports["dxlists"]:dxAddColumn(1, "ID", 50)
    exports["dxlists"]:dxAddColumn(1, "Nazwa", 75)
    exports["dxlists"]:dxAddColumn(1, "Reputacja", 100) 
    exports["dxlists"]:dxAddColumn(1, "Miejsca", 75) 	
	triggerServerEvent("updateMiejsca",localPlayer)
	for i,v in ipairs(getElementsByType("urzad")) do
		for k,miejsce in ipairs(lista) do
			if miejsce[1] == "Mechanik" then
				miejsce[3] = getElementData(v, "miejsca1")
			end
			exports["dxlists"]:dxAddItem(1, tostring(k), 1)
			exports["dxlists"]:dxAddItem(2, tostring(miejsce[1]), 1)
			exports["dxlists"]:dxAddItem(3, tostring(miejsce[2]), 1) 
			exports["dxlists"]:dxAddItem(4, tostring(miejsce[3]).."/"..tostring(miejsce[4]), 1) 
		end
	end
end

addEvent("openGui_prace", true)
addEventHandler("openGui_prace", root, function()
	local hit = localPlayer
    if grid ~= true then
    	if getElementData(hit, "urzedowka") then
        	addEventHandler("onClientPreRender", root, gui2)
        	showCursor(true, false)
        else
            sprawdzMiejsca()
        end 
        grid = true
    end
end)

addEvent("closeGui_prace", true)
addEventHandler("closeGui_prace", root, function(c)
	local hit = localPlayer
	if c == true then
		grid = false
        removeEventHandler("onClientPreRender", root, gui)
        exports["dxlists"]:dxDestroy(1)
        showCursor(false)
	else
    if grid == true then
        grid = false
    	exports["dxlists"]:dxDestroy(1)
    	for k,miejsce in ipairs(lista) do
    		miejsce[3] = miejsce[4]
    	end
    	if getElementData(hit, "urzedowka") then
        	removeEventHandler("onClientPreRender", root, gui2)
    	else
        	removeEventHandler("onClientPreRender", root, gui)
    	end 
        showCursor(false)
    end
end
end)

addEventHandler("onClientClick", root, function(button, state)
    if button == "left" and state == "down" and isMouseIn(screenW * 0.5109, screenH * 0.6694, screenW * 0.1344, screenH * 0.0565) and grid == true then
        grid = false
        removeEventHandler("onClientPreRender", root, gui)
        exports["dxlists"]:dxDestroy(1)
        showCursor(false)
    elseif button == "left" and state == "down" and isMouseIn(screenW * 0.3536, screenH * 0.6694, screenW * 0.1344, screenH * 0.0565) and grid == true then
    	if not getElementData(localPlayer, "urzedowka") then
        	local nazwa = exports["dxlists"]:dxItemDetails(1, 2)
        	local cena = exports["dxlists"]:dxItemDetails(1, 3)
        	if not nazwa and not cena then
            	exports["crpg_powiadomienia"]:noti("Nie wybrałeś pracy do której chcesz dołączyć!")
            	return
        	end
        	for i,v in ipairs(lista) do
        		if v[1] == tostring(nazwa) and v[3] == v[4] then
        			exports["crpg_powiadomienia"]:noti("Wszystkie miejsca w tej pracy urzędowej są zajęte.")
        			return
        		end
        	end
        	if getElementData(localPlayer, "punkty") < tonumber(cena) then
        		exports["crpg_powiadomienia"]:noti("Nie posiadasz minimalnej reputacji ("..cena..") aby dołączyć do tej pracy urzędowej.")
        		return
        	end
        	triggerServerEvent("dolacz:urzedowka", localPlayer, nazwa)
        	grid = false
        	removeEventHandler("onClientPreRender", root, gui)
        	exports["dxlists"]:dxDestroy(1)
        	showCursor(false)
        end
    elseif button == "left" and state == "down" and isMouseIn(screenW * 0.4307, screenH * 0.4491, screenW * 0.1417, screenH * 0.0528) and grid == true then
    	if getElementData(localPlayer, "urzedowka") then
    		triggerServerEvent("odejdz:urzedowka", localPlayer)
    	end
        grid = false
        removeEventHandler("onClientPreRender", root, gui2)
        exports["dxlists"]:dxDestroy(1)
        showCursor(false)
    end
end)