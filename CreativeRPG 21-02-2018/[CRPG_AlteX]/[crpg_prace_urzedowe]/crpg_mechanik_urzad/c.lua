--[[
  Autor: Asper
  Skrypt: Naprawa pojazdow
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

local lista = {
	{"Silnik", 1},
	{"Maska", 2},
	{"Bagażnik", 3},
	{"Drzwi lewy przód", 4},
	{"Drzwi prawy przód", 5},
	{"Drzwi lewy tył", 6},
	{"Drzwi prawy tył", 7},
	{"Szyba przednia", 8},
	{"Zderzak przedni", 9},
	{"Zderzak tylni", 10},
	{"Światło lewy przód", 11},
	{"Światło prawy przód", 12},
	{"Światło lewy tył", 13},
	{"Światło prawy tył", 14},
}

local naprawiany_pojazd = false

function sprawdz_czesc(czesc)
	if czesc  ==  1 then
		if getElementHealth(naprawiany_pojazd) > 1000 then 
			return true 
		else
			return false
		end
	elseif czesc  ==  2 then
		if getVehicleDoorState(naprawiany_pojazd, 0) == 0 then
			return true
		else
			return false
		end
	elseif czesc  ==  3 then 
		if getVehicleDoorState(naprawiany_pojazd, 1) == 0 then
			return true
		else
			return false
		end
	elseif czesc  ==  4 then
		if getVehicleDoorState(naprawiany_pojazd, 2) == 0 then
			return true
		else
			return false
		end
	elseif czesc  ==  5 then
		if getVehicleDoorState(naprawiany_pojazd, 3) == 0 then
			return true
		else
			return false
		end
	elseif czesc  ==  6 then
		if getVehicleDoorState(naprawiany_pojazd, 4) == 0 then
			return true
		else
			return false
		end
	elseif czesc  ==  7 then
		if getVehicleDoorState(naprawiany_pojazd, 5) == 0 then
			return true
		else
			return false
		end
	elseif czesc  ==  8 then
		if getVehiclePanelState(naprawiany_pojazd, 4) == 0 then
			return true
		else
			return false
		end
	elseif czesc  ==  9 then
		if getVehiclePanelState(naprawiany_pojazd, 5) == 0 then
			return true
		else
			return false
		end
	elseif czesc  ==  10 then
		if getVehiclePanelState(naprawiany_pojazd, 6) == 0 then
			return true
		else
			return false
		end
	elseif czesc  ==  11 then
		if getVehicleLightState(naprawiany_pojazd, 0) == 0 then
			return true
		else
			return false
		end
	elseif czesc  ==  12 then
		if getVehicleLightState(naprawiany_pojazd, 1) == 0 then
			return true
		else
			return false
		end
	elseif czesc  ==  13 then
		if getVehicleLightState(naprawiany_pojazd, 2) == 0 then
			return true
		else
			return false
		end
	elseif czesc  ==  14 then
		if getVehicleLightState(naprawiany_pojazd, 3) == 0 then
			return true
		else
			return false
		end
	end
end

local koszty = {
[1] = 50,	
[2] = 50,
[3] = 50,
[4] = 50,
[5] = 50,
[6] = 50,
[7] = 50,
[8] = 50,
[9] = 50,
[10] = 50,
[11] = 50,
[12] = 50,
[13] = 50,
[14] = 50,
}

local stany = {
[0] = "65%",
[1] = "48%",
[2] = "37%",
[3] = "0%",	
}

local gridlist = false
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

function roundedRectangle(x, y, w, h, color)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x + 2, y + h, w - 4, 1, color, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 4, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 4, color, false)
end

local czcionka = dxCreateFont(":crpg_fonty/f.ttf", 15)
if not czcionka then
    czcionka = "default"
end

function gui()
        roundedRectangle(screenW * 0.3328, screenH * 0.2870, screenW * 0.3349, screenH * 0.4259, tocolor(15,15,15,222), false)
        roundedRectangle(screenW * 0.3328, screenH * 0.2870, screenW * 0.3349, screenH * 0.0574, tocolor(0,255,25,125), false)
        dxDrawText("Monitor systemu naprawczego", (screenW * 0.3323) + 1, (screenH * 0.2870) + 1, (screenW * 0.6677) + 1, (screenH * 0.3444) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Monitor systemu naprawczego", screenW * 0.3323, screenH * 0.2870, screenW * 0.6677, screenH * 0.3444, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        if mysz(screenW * 0.3516, screenH * 0.6472, screenW * 0.1339, screenH * 0.0528) then
            dxDrawButton(screenW * 0.3516, screenH * 0.6472, screenW * 0.1339, screenH * 0.0528, tocolor(0,255,25,125), false)
        else
            dxDrawButton(screenW * 0.3516, screenH * 0.6472, screenW * 0.1339, screenH * 0.0528, tocolor(30,30,30,225), false)
        end
        if mysz(screenW * 0.5146, screenH * 0.6472, screenW * 0.1339, screenH * 0.0528) then
            dxDrawButton(screenW * 0.5146, screenH * 0.6472, screenW * 0.1339, screenH * 0.0528, tocolor(0,255,25,125), false)
        else
            dxDrawButton(screenW * 0.5146, screenH * 0.6472, screenW * 0.1339, screenH * 0.0528, tocolor(30,30,30,225), false)
        end
        dxDrawText("Napraw wybraną część", (screenW * 0.3516) + 1, (screenH * 0.6463) + 1, (screenW * 0.4854) + 1, (screenH * 0.7000) + 1, tocolor(0, 0, 0, 255), 0.8, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Napraw wybraną część", screenW * 0.3516, screenH * 0.6463, screenW * 0.4854, screenH * 0.7000, tocolor(255, 255, 255, 255), 0.8, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Anuluj naprawe", (screenW * 0.5146) + 1, (screenH * 0.6463) + 1, (screenW * 0.6484) + 1, (screenH * 0.7000) + 1, tocolor(0, 0, 0, 255), 0.8, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Anuluj naprawe", screenW * 0.5146, screenH * 0.6463, screenW * 0.6484, screenH * 0.7000, tocolor(255, 255, 255, 255), 0.8, czcionka, "center", "center", false, false, false, false, false)
end

addEventHandler("onClientMarkerHit", resourceRoot, function(hit)
	if hit ~= localPlayer then return end
	local cuboid = getElementData(source, "cuboid")
	if not cuboid then return end
	local frakcja = getElementData(hit, "frakcja")
	if not frakcja or frakcja ~= "Mechanik" then
		exports["crpg_powiadomienia"]:noti("Nie jesteś zatrudniony jako Mechanik, zatrudnić możesz się w urzędzie miasta.")
		return
	end
	local pojazd = getElementsWithinColShape(cuboid, "vehicle")
	if #pojazd < 1 then
		exports["crpg_powiadomienia"]:noti("Na stanowisku naprawczym nie znajduje się pojazd.")
		return 
	end
	if #pojazd > 1 then 
		exports["crpg_powiadomienia"]:noti("Na stanowisku naprawczym jest zbyt dużo pojazdów.")
		return 
	end
	addEventHandler("onClientPreRender", root, gui)
	showCursor(true, false)
	naprawiany_pojazd = pojazd[1]
    gridlist = exports["dxlists"]:dxCreate(screenW * 0.3432, screenH * 0.3537, screenW * 0.3151, screenH * 0.2806, 4)
    exports["dxlists"]:dxAddColumn(4, "ID części", 100) 
    exports["dxlists"]:dxAddColumn(4, "Nazwa części", 170)
    exports["dxlists"]:dxAddColumn(4, "Cena części", 150) 
    exports["dxlists"]:dxAddColumn(4, "Stan części", 150) 
	for i,v in pairs(lista) do
		if sprawdz_czesc(v[2]) ~= true then
			exports["dxlists"]:dxAddItem(1, tostring(i), 4) 
			exports["dxlists"]:dxAddItem(2, tostring(v[1]), 4) 
			exports["dxlists"]:dxAddItem(3, "PLN"..tostring(koszty[i]), 4) 
			exports["dxlists"]:dxAddItem(4, tostring(stany[getVehiclePanelState(naprawiany_pojazd, i)]), 4) 
		end
	end
end)

addEventHandler("onClientMarkerLeave", resourceRoot, function(hit)
	if hit ~= localPlayer then return end
	if gridlist == false then return end
	naprawiany_pojazd = false
	showCursor(false)
	gridlist = false
	exports["dxlists"]:dxDestroy(4)
	removeEventHandler("onClientPreRender", root, gui)
end)

addEventHandler("onClientClick", root, function(button, state)
  	if button ~= "state" and state ~= "down" then return end
  	if mysz(screenW * 0.3516, screenH * 0.6472, screenW * 0.1339, screenH * 0.0528) and gridlist ~= false then
  		naprawCzesc()
  	elseif mysz(screenW * 0.5146, screenH * 0.6472, screenW * 0.1339, screenH * 0.0528) and gridlist ~= false then
  		naprawiany_pojazd = false
		showCursor(false)
		gridlist = false
		exports["dxlists"]:dxDestroy(4)
		removeEventHandler("onClientPreRender", root, gui)
  	end
 end)

function naprawCzesc()
	local czesc = exports["dxlists"]:dxItemDetails(4, 1)
	if not czesc then
		exports["crpg_powiadomienia"]:noti("Nie wybrałeś żadnej częscido jej naprawy.")
		return
	end
	local nazwa_czesci = exports["dxlists"]:dxItemDetails(4, 2)
	local cena_czesci = exports["dxlists"]:dxItemDetails(4, 3)
	cena_czesci = string.gsub(cena_czesci, "[PLN]", "")
	cena_czesci = tonumber(cena_czesci)
	local hajs = getElementData(localPlayer, "pieniadze")
	if cena_czesci > hajs then
		exports["crpg_powiadomienia"]:noti("Aby naprawić część '"..nazwa_czesci.."' musisz posiadać minimum PLN"..cena_czesci)
		return
	end
	exports["crpg_powiadomienia"]:noti("Naprawiłeś '"..nazwa_czesci.."' za cene"..cena_czesci.."' PLN" )
	setElementData(localPlayer, "pieniadze", hajs-cena_czesci)
	triggerServerEvent("napraw:czesc", localPlayer, naprawiany_pojazd, tonumber(czesc))
	setTimer(function()
		refresh_list()
	end, 150, 1)
end

function refresh_list()
for i = 0,2 do
	exports["dxlists"]:dxDestroy(4)
    gridlist = exports["dxlists"]:dxCreate(screenW * 0.3432, screenH * 0.3537, screenW * 0.3151, screenH * 0.2806, 4)
    exports["dxlists"]:dxAddColumn(4, "ID części", 100) 
    exports["dxlists"]:dxAddColumn(4, "Nazwa części", 170)
    exports["dxlists"]:dxAddColumn(4, "Cena części", 150) 
    exports["dxlists"]:dxAddColumn(4, "Stan części", 150) 
	for i,v in pairs(lista) do
		if sprawdz_czesc(v[2]) ~= true then
			exports["dxlists"]:dxAddItem(1, tostring(i), 4) 
			exports["dxlists"]:dxAddItem(2, tostring(v[1]), 4) 
			exports["dxlists"]:dxAddItem(3, "PLN"..tostring(koszty[i]), 4) 
			exports["dxlists"]:dxAddItem(4, tostring(stany[getVehiclePanelState(naprawiany_pojazd, i)]), 4) 
		end
	end
end
end