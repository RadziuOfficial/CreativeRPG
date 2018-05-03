--[[
Autor: Asper
Dla: .newMode
Skrypt: Tuning pojazdów
Typ: Client
]]

local napisy = createElement("text")
setElementData(napisy, "text", "Tuning Wizualny")
setElementPosition(napisy, -2175.27, 637.31, 49.44)

local cuboid = createColCuboid(-2206.90, 662.25, 49.44, 14.5, 8, 6)

local sb = guiCreateScrollBar(0.34, 0.85, 0.32, 0.04, true, true)    
local wb = guiCreateGridList(0.01, 0.38, 0.31, 0.27, true)
local id = guiGridListAddColumn(wb, "ID", 0.2)
local nazwa = guiGridListAddColumn(wb, "NAZWA", 0.2)
local cena = guiGridListAddColumn(wb, "CENA", 0.2)
local typ = guiGridListAddColumn(wb, "TYP", 0.1)
local akcja = guiGridListAddColumn(wb, "AKCJA", 0.2)
guiSetVisible(sb, false)
guiSetVisible(wb, false)

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

local tuning = {
{1025, "Offroad", 3500, "Felgi"},
{1073, "Shadow", 5500, "Felgi"},
{1074, "Mega", 5000, "Felgi"},
{1075, "Rimshine", 4250, "Felgi"},
{1076, "Wires", 5000, "Felgi"},
{1077, "Classic", 5500, "Felgi"},
{1078, "Twist", 4250, "Felgi"},
{1079, "Cutter", 5250, "Felgi"},
{1080, "Switch", 4250, "Felgi"},
{1082, "Import", 4000, "Felgi"},
{1084, "Trance", 4500, "Felgi"},
{1096, "Ahab", 5500, "Felgi"},
{1098, "Access", 4000, "Felgi"},
{1097, "Virtual", 4500, "Felgi"},
{1018, "Upswept", 1600, "Wydechy"},
{1019, "Twin", 1650, "Wydechy"},
{1020, "Large", 1700, "Wydechy"},
{1021, "Medium", 1650, "Wydechy"},
{1022, "Small", 1600, "Wydechy"},
}

local tuning_elegy = {
{1148, "Tylni #1", 3000, "Zderzaki"},
{1149, "Tylni #2", 3000, "Zderzaki"},
{1171, "Przedni #1", 3000, "Zderzaki"},
{1172, "Przedni #2", 300, "Zderzaki"},
{1036, "Boczny #1", 3000, "Zderzaki"},
{1039, "Boczny #2", 300, "Zderzaki"},
{1040, "Boczny #3", 3000, "Zderzaki"},
{1041, "Boczny #4", 300, "Zderzaki"},
{1034, "Wydech #1", 2000, "Wydechy"},
{1037, "Wydech #2", 2000, "Wydechy"},
{1035, "Dach #1", 2000, "Wloty"},
{1038, "Dach #2", 2000, "Wloty"},
}

local tuning_jester = {
{1059, "Tylni #1", 3000, "Zderzaki"},
{1061, "Tylni #2", 3000, "Zderzaki"},
{1060, "Przedni #1", 3000, "Zderzaki"},
{1073, "Przedni #2", 300, "Zderzaki"},
{1069, "Boczny #1", 3000, "Zderzaki"},
{1079, "Boczny #2", 300, "Zderzaki"},
{1071, "Boczny #3", 3000, "Zderzaki"},
{1072, "Boczny #4", 300, "Zderzaki"},
{1065, "Wydech #1", 2000, "Wydechy"},
{1066, "Wydech #2", 2000, "Wydechy"},
{1067, "Dach #1", 2000, "Wloty"},
{1068, "Dach #2", 2000, "Wloty"},
}

local tuning_flash = {
{1150, "Tylni #1", 3000, "Zderzaki"},
{1151, "Tylni #2", 3000, "Zderzaki"},
{1152, "Przedni #1", 3000, "Zderzaki"},
{1153, "Przedni #2", 300, "Zderzaki"},
{1047, "Boczny #1", 3000, "Zderzaki"},
{1048, "Boczny #2", 300, "Zderzaki"},
{1051, "Boczny #3", 3000, "Zderzaki"},
{1052, "Boczny #4", 300, "Zderzaki"},
{1045, "Wydech #1", 2000, "Wydechy"},
{1046, "Wydech #2", 2000, "Wydechy"},
{1053, "Dach #1", 2000, "Wloty"},
{1054, "Dach #2", 2000, "Wloty"},
}

local tuning_uranus = {
{1167, "Tylni #1", 3000, "Zderzaki"},
{1168, "Tylni #2", 3000, "Zderzaki"},
{1165, "Przedni #1", 3000, "Zderzaki"},
{1166, "Przedni #2", 300, "Zderzaki"},
{1090, "Boczny #1", 3000, "Zderzaki"},
{1093, "Boczny #2", 300, "Zderzaki"},
{1094, "Boczny #3", 3000, "Zderzaki"},
{1095, "Boczny #4", 300, "Zderzaki"},
{1089, "Wydech #1", 2000, "Wydechy"},
{1092, "Wydech #2", 2000, "Wydechy"},
{1088, "Dach #1", 2000, "Wloty"},
{1091, "Dach #2", 2000, "Wloty"},
}

local tuning_sultan = {
{1140, "Tylni #1", 3000, "Zderzaki"},
{1141, "Tylni #2", 3000, "Zderzaki"},
{1169, "Przedni #1", 3000, "Zderzaki"},
{1170, "Przedni #2", 300, "Zderzaki"},
{1128, "Wydech #1", 2000, "Wydechy"},
{1129, "Wydech #2", 2000, "Wydechy"},
{1026, "Right Alien", 2100, "Progi"},
{1027, "Left Alien", 2000, "Progi"},
{1030, "Right X-Flow", 2100, "Progi"},
{1031, "Left X-Flow", 2000, "Progi"},
{1032, "Roof Alien", 2000, "Wloty"},
{1033, "Roof X-Flow", 2000, "Wloty"},
}

local spoilery = {
{1000, "Spoiler Pro", 1500, "Spoiler"},
{1001, "Spoiler Win", 1500, "Spoiler"},
{1002, "Spoiler Drag", 1500, "Spoiler"},
{1003, "Spoiler Alpha", 1500, "Spoiler"},
{1014, "Spoiler Champ", 15000, "Spoiler"},
{1015, "Spoiler Race", 15000, "Spoiler"},
{1016, "Spoiler Worx", 1500, "Spoiler"},
{1023, "Spoiler Fury", 1500, "Spoiler"},
{1049, "Side skirt Right (X-flow)", 1500, "Spoiler"},
{1050, "Side skirt Left (X-flow)", 1500, "Spoiler"},
{1058, "Exhaust (X-flow)", 1500, "Spoiler"},
{1060, "Side skirt Left (X-flow)", 1500, "Spoiler"},
{1138, "Spoiler (Alien)", 1500, "Spoiler"},
{1139, "Spoiler (X-flow)", 1500, "Spoiler"},
{1146, "Spoiler (Alien)", 1500, "Spoiler"},
{1147, "Spoiler (X-flow)", 1500, "Spoiler"},
{1158, "Spoiler (Alien)", 1500, "Spoiler"},
{1162, "Front bumper (Alien)", 1500, "Spoiler"},
{1163, "Spoiler (Alien)", 1500, "Spoiler"},
{1164, "Spoiler (X-flow)", 1500, "Spoiler"},
}

local dspoilery = {
["Blista Compact"] = true,
["Bravura"] = true,
["Cadrona"] = true,
["Clover"] = true,
["Majestic"] = true,
["Manana"] = true,
["Previon"] = true,
["Perennial"] = true,
["Tampa"] = true,
["Stalion"] = true,
["Emperor"] = true,
["Greenwood"] = true,
["Merit"] = true,
["Nebula"] = true,
["Premier"] = true,
["Primo"] = true,
["Sentienel"] = true,
["Stafford"] = true,
["Sunrise"] = true,
["Tahoma"] = true,
["Vincent"] = true,
["Cheetah"] = true,
["Elegy"] = true,
["Euros"] = true,
["Flash"] = true,
["Jester"] = true,
["Pheonix"] = true,
["Sultan"] = true,
["Uranus"] = true,
}

local screenW, screenH = guiGetScreenSize()

local czcionka = dxCreateFont(":nm-geodeta/czcionka.ttf", 10)
if not czcionka then czcionka = "default-bold" end

function gui()
        exports["nm-blur"]:dxDrawBluredRectangle(screenW * 0.0066, screenH * 0.3242, screenW * 0.3221, screenH * 0.4063, tocolor(150, 150, 150, 255))
        if mysz(screenW * 0.1735, screenH * 0.6589, screenW * 0.1406, screenH * 0.0651) then
     	   dxDrawRectangle(screenW * 0.1735, screenH * 0.6589, screenW * 0.1406, screenH * 0.0651, tocolor(25, 75, 125, 180), false)
     	else
     	   dxDrawRectangle(screenW * 0.1735, screenH * 0.6589, screenW * 0.1406, screenH * 0.0651, tocolor(25, 75, 125, 125), false)
     	end
        if mysz(screenW * 0.0212, screenH * 0.6589, screenW * 0.1406, screenH * 0.0651) then
      		dxDrawRectangle(screenW * 0.0212, screenH * 0.6589, screenW * 0.1406, screenH * 0.0651, tocolor(25, 75, 125, 180), false)
      	else
      		dxDrawRectangle(screenW * 0.0212, screenH * 0.6589, screenW * 0.1406, screenH * 0.0651, tocolor(25, 75, 125, 125), false)
      	end
      	dxDrawRectangle(screenW * 0.0066, screenH * 0.3242, screenW * 0.3221, screenH * 0.0495, tocolor(25, 75, 125, 155), false)
        dxDrawText("Zamontuj/wymontuj\nwybrany tuning", (screenW * 0.0212) + 1, (screenH * 0.6589) + 1, (screenW * 0.1618) + 1, (screenH * 0.7240) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Zamontuj/wymontuj\nwybrany tuning", screenW * 0.0212, screenH * 0.6589, screenW * 0.1618, screenH * 0.7240, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Anuluj", (screenW * 0.1735) + 1, (screenH * 0.6589) + 1, (screenW * 0.3141) + 1, (screenH * 0.7240) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Anuluj", screenW * 0.1735, screenH * 0.6589, screenW * 0.3141, screenH * 0.7240, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Tuning wizualny", (screenW * 0.0066) + 1, (screenH * 0.3242) + 1, (screenW * 0.3287) + 1, (screenH * 0.3737) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Tuning wizualny", screenW * 0.0066, screenH * 0.3242, screenW * 0.3287, screenH * 0.3737, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
end

addEventHandler("onClientClick", root, function(b, s)
	if b ~= "state" and s ~= "down" then return end
	if mysz(screenW * 0.1735, screenH * 0.6589, screenW * 0.1406, screenH * 0.0651) and guiGetVisible(wb) == true then
		guiSetVisible(sb, false)
		guiSetVisible(wb, false)
		showCursor(false)
		local p = getPedOccupiedVehicle(localPlayer)
		setElementFrozen(p, false)
		setElementPosition(p, 1843.09, -1868.19, 13.12)
		setElementRotation(p, 359.8, 356.5, 359.6)
		removeEventHandler("onClientPreRender", root, gui)
		setElementData(napisy, "text", "")
	elseif mysz(screenW * 0.0212, screenH * 0.6589, screenW * 0.1406, screenH * 0.0651) and guiGetVisible(wb) == true then
		local wy = guiGridListGetSelectedItem(wb)
		local id = guiGridListGetItemText(wb, wy, 1)
		local cena = guiGridListGetItemText(wb, wy, 3)
		cena = tonumber(cena)
		local typ = guiGridListGetItemText(wb, wy, 4)
		local nazwa = guiGridListGetItemText(wb, wy, 2)
		local p = getPedOccupiedVehicle(localPlayer)
		if wy > 0 then
			if removeVehicleUpgrade(p, id) == true then
				local hajs = getElementData(localPlayer, "pieniadze")
				local cenax = cena/2
				setElementData(localPlayer, "pieniadze", hajs+cenax)
				triggerServerEvent("uTuning", localPlayer, p, id)
				exports["nm-noti"]:noti("Wymontowano tuning o nazwie "..nazwa..", otrzymano "..cenax.." PLN.")
			else
				local hajs = getElementData(localPlayer, "pieniadze")
				if hajs > cena then
					setElementData(localPlayer, "pieniadze", hajs-cena)
					triggerServerEvent("dTuning", localPlayer, p, id)
					exports["nm-noti"]:noti("Zamontowano tuning o nazwie "..nazwa..", zapłacono "..cena.." PLN.")
				else
					exports["nm-noti"]:noti("Brak funduszy na montaż tuningu.")
				end
			end
		end
	end
end)

addEventHandler("onClientGUIScroll", sb, function()
	local sp = guiScrollBarGetScrollPosition(sb)
	local p = getPedOccupiedVehicle(localPlayer)
	local rx, ry, rz = getElementRotation(p)
	setElementRotation(p, rx, ry, sp*3)
end)

function zawieszenie(p)
	if getElementData(p, "zawieszenie") then
		return "TAK"
	else
		return "NIE"
	end
end

function naped(p)
	local hp = getVehicleHandling(p)
	local dp = hp.driveType
	if dp == "rwd" then
		return "RWD"
	elseif dp == "fwd" then
		return "FWD"
	elseif dp == "awd" then
		return "AWD"
	else
		return dp
	end
end

addEventHandler("onClientMarkerHit", resourceRoot, function(hit)
	if hit ~= localPlayer then return end
	if not isPedInVehicle(hit) then return end
	local pp = getElementsWithinColShape(cuboid, "vehicle")
	if #pp > 1 then
		exports["nm-noti"]:noti("Tuning jest w tej chwili używany.")
		return
	end
	local p = getPedOccupiedVehicle(hit)
	local tune = getVehicleUpgrades(p)
	if getVehicleController(p) ~= hit then return end
	if getElementData(p, "wlasciciel") ~= getElementData(hit, "dbid") then return end
	guiGridListClear(wb)
	for k,v in ipairs(tuning) do
		local r = guiGridListAddRow(wb)
		guiGridListSetItemText(wb, r, id, v[1], false, false)
		guiGridListSetItemText(wb, r, nazwa, v[2], false, false)
		local cx = v[3]
		cx = string.format("%1.2f", cx)
		guiGridListSetItemText(wb, r, cena, cx, false, false)
		for _,t in ipairs(tune) do
			if t == v[1] then
				guiGridListSetItemText(wb, r, akcja, "DEMONTAŻ", false, false)	
			else
				guiGridListSetItemText(wb, r, akcja, "MONTAŻ", false, false)	
            end
        end
		guiGridListSetItemText(wb, r, typ, v[4], false, false)	
	end
	if getVehicleName(p) == "Elegy" then
		for k2,v2 in ipairs(tuning_elegy) do
			local r = guiGridListAddRow(wb)
			guiGridListSetItemText(wb, r, id, v2[1], false, false)
			guiGridListSetItemText(wb, r, nazwa, v2[2], false, false)
			local cx = v2[3]
			cx = string.format("%1.2f", cx)
			guiGridListSetItemText(wb, r, cena, cx, false, false)
			guiGridListSetItemText(wb, r, typ, v2[4], false, false)	
			for _,t in ipairs(tune) do
				if t == v2[1] then
					guiGridListSetItemText(wb, r, akcja, "DEMONTAŻ", false, false)	
				else
					guiGridListSetItemText(wb, r, akcja, "MONTAŻ", false, false)	
          	  end
       		end
		end
	end	
	if getVehicleName(p) == "Sultan" then
		for k2,v2 in ipairs(tuning_sultan) do
			local r = guiGridListAddRow(wb)
			guiGridListSetItemText(wb, r, id, v2[1], false, false)
			guiGridListSetItemText(wb, r, nazwa, v2[2], false, false)
			local cx = v2[3]
			cx = string.format("%1.2f", cx)
			guiGridListSetItemText(wb, r, cena, cx, false, false)
			guiGridListSetItemText(wb, r, typ, v2[4], false, false)	
			for _,t in ipairs(tune) do
				if t == v2[1] then
					guiGridListSetItemText(wb, r, akcja, "DEMONTAŻ", false, false)	
				else
					guiGridListSetItemText(wb, r, akcja, "MONTAŻ", false, false)	
          	  end
       		end
		end
	end
		if getVehicleName(p) == "Jester" then
		for k2,v2 in ipairs(tuning_jester) do
			local r = guiGridListAddRow(wb)
			guiGridListSetItemText(wb, r, id, v2[1], false, false)
			guiGridListSetItemText(wb, r, nazwa, v2[2], false, false)
			local cx = v2[3]
			cx = string.format("%1.2f", cx)
			guiGridListSetItemText(wb, r, cena, cx, false, false)
			guiGridListSetItemText(wb, r, typ, v2[4], false, false)	
			for _,t in ipairs(tune) do
				if t == v2[1] then
					guiGridListSetItemText(wb, r, akcja, "DEMONTAŻ", false, false)	
				else
					guiGridListSetItemText(wb, r, akcja, "MONTAŻ", false, false)	
          	  end
       		end
		end
	end	
		if getVehicleName(p) == "Flash" then
		for k2,v2 in ipairs(tuning_flash) do
			local r = guiGridListAddRow(wb)
			guiGridListSetItemText(wb, r, id, v2[1], false, false)
			guiGridListSetItemText(wb, r, nazwa, v2[2], false, false)
			local cx = v2[3]
			cx = string.format("%1.2f", cx)
			guiGridListSetItemText(wb, r, cena, cx, false, false)
			guiGridListSetItemText(wb, r, typ, v2[4], false, false)	
			for _,t in ipairs(tune) do
				if t == v2[1] then
					guiGridListSetItemText(wb, r, akcja, "DEMONTAŻ", false, false)	
				else
					guiGridListSetItemText(wb, r, akcja, "MONTAŻ", false, false)	
          	  end
       		end
		end
	end	
		if getVehicleName(p) == "Uranus" then
		for k2,v2 in ipairs(tuning_uranus) do
			local r = guiGridListAddRow(wb)
			guiGridListSetItemText(wb, r, id, v2[1], false, false)
			guiGridListSetItemText(wb, r, nazwa, v2[2], false, false)
			local cx = v2[3]
			cx = string.format("%1.2f", cx)
			guiGridListSetItemText(wb, r, cena, cx, false, false)
			guiGridListSetItemText(wb, r, typ, v2[4], false, false)	
			for _,t in ipairs(tune) do
				if t == v2[1] then
					guiGridListSetItemText(wb, r, akcja, "DEMONTAŻ", false, false)	
				else
					guiGridListSetItemText(wb, r, akcja, "MONTAŻ", false, false)	
          	  end
       		end
		end
	end		
	if dspoilery[getVehicleName(p)] then
		for k3,v3 in ipairs(spoilery) do
			local r = guiGridListAddRow(wb)
			guiGridListSetItemText(wb, r, id, v3[1], false, false)
			guiGridListSetItemText(wb, r, nazwa, v3[2], false, false)
			local cx = v3[3]
			cx = string.format("%1.2f", cx)
			guiGridListSetItemText(wb, r, cena, cx, false, false)
			guiGridListSetItemText(wb, r, typ, v3[4], false, false)	
			for _,t in ipairs(tune) do
				if t == v3[1] then
					guiGridListSetItemText(wb, r, akcja, "DEMONTAŻ", false, false)	
				else
					guiGridListSetItemText(wb, r, akcja, "MONTAŻ", false, false)	
          	  end
       		end
		end
	end
	local id = getElementData(p, "id")
	local paliwo = string.format("%1d", getElementData(p, "paliwo"))
	local bak = getElementData(p, "bak")
	local przebieg = string.format("%1.2f", getElementData(p, "przebieg"))
	local tune = getVehicleUpgrades(p)
	local tuning = ""
	local ntuning = "?"
	for i,v in ipairs(tune) do
		local nt = getVehicleUpgradeSlotName(v)
		if nt == "Wheels" then
			ntuning = "Felgi"
		elseif nt == "Exhaust" then
			ntuning = "Wydechy"
		else
			ntuning = getVehicleUpgradeSlotName(v)
		end
		if tuning == "" then
			tuning = ntuning..": "..v
		else
			tuning = tuning..", "..ntuning..":"..v
		end
	end
	local zawieszenie = zawieszenie(p)
	local naped = naped(p)
	local text = "ID: "..id.."\nBak: "..paliwo.."/"..bak.."L\nPrzebieg: "..przebieg.."km\nTuning: "..tuning.."\nZawieszenie hydrauliczne: "..zawieszenie.."\nNapęd: "..naped
	setElementData(napisy, "text", "Informacje o pojeździe:\n"..text)
	guiSetVisible(sb, true)
	guiSetVisible(wb, true)
	showCursor(true)
	setElementFrozen(p, true)
	setElementPosition(p, -2206.90, 662.25, 49.44)
	addEventHandler("onClientPreRender", root, gui)
end)