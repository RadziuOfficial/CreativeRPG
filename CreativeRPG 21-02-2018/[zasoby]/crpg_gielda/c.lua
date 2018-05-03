--[[
  Autor: Asper
  Skrypt: Gielda
]]

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

local showed = false

local czcionka = dxCreateFont(":crpg_fonty/f.ttf", 15)
if not czcionka then 
	czcionka = czcionka 
end

function roundedRectangle(x, y, w, h, color)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x + 2, y + h, w - 4, 1, color, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 4, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 4, color, false)
end

function dxDrawButton(x, y, w, h, color)
  local color2 = tocolor(0,94,254)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x-0.4660164, y + h-1.6, w+1.5, 2, color2, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 3, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 3, color, false)
end

function gui()
        dxDrawButton(screenW * 0.3661, screenH * 0.3222, screenW * 0.2677, screenH * 0.2657, tocolor(15, 15, 15, 222), false)
        roundedRectangle(screenW * 0.3661, screenH * 0.3204, screenW * 0.2677, screenH * 0.0509, tocolor(0,94,254,185), false)
        dxDrawText("Panel giełdy", (screenW * 0.3661) + 1, (screenH * 0.3204) + 1, (screenW * 0.6339) + 1, (screenH * 0.3713) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Panel giełdy", screenW * 0.3661, screenH * 0.3204, screenW * 0.6339, screenH * 0.3713, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        if mysz(screenW * 0.3776, screenH * 0.5019, screenW * 0.1156, screenH * 0.0593) then
        	dxDrawButton(screenW * 0.3776, screenH * 0.5019, screenW * 0.1156, screenH * 0.0593, tocolor(0,94,254,125), false)
        else
        	dxDrawButton(screenW * 0.3776, screenH * 0.5019, screenW * 0.1156, screenH * 0.0593, tocolor(30,30,30,225), false)
        end
        if mysz(screenW * 0.5094, screenH * 0.5009, screenW * 0.1156, screenH * 0.0593) then
        	dxDrawButton(screenW * 0.5094, screenH * 0.5009, screenW * 0.1156, screenH * 0.0593, tocolor(0,94,254,125), false)
        else
        	dxDrawButton(screenW * 0.5094, screenH * 0.5009, screenW * 0.1156, screenH * 0.0593, tocolor(30,30,30,225), false)
        end
        dxDrawText("Wystaw pojazd", (screenW * 0.3771) + 1, (screenH * 0.5009) + 1, (screenW * 0.4932) + 1, (screenH * 0.5602) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Wystaw pojazd", screenW * 0.3771, screenH * 0.5009, screenW * 0.4932, screenH * 0.5602, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Anuluj", (screenW * 0.5094) + 1, (screenH * 0.5009) + 1, (screenW * 0.6255) + 1, (screenH * 0.5611) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Anuluj", screenW * 0.5094, screenH * 0.5009, screenW * 0.6255, screenH * 0.5611, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
end

local marker = createMarker(1736.67, 1873.74, 10.82-1, "cylinder", 5, 255, 0, 0, 75)
createBlipAttachedTo(marker,55,2,255,0,0,255,0,100)

addEventHandler("onClientMarkerHit", marker, function(hit)
  if hit ~= localPlayer then return end
  local pojazd  = getPedOccupiedVehicle(hit)
  if not pojazd then return end
  if not getElementData(pojazd, "id") then
    return
  end
  if getElementHealth(pojazd) < 900 then
    exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Posiadasz niesprawny pojazd!")
    return
  end
  if getElementData(pojazd, "wlasciciel") ~= getElementData(hit, "dbid") then
      return
    end
    addEventHandler("onClientRender", root, gui)
    showCursor(true, false)
    showed = true
    exports["dxedits"]:editbox_create("", "Cena pojazdu...", screenW * 0.4219, screenH * 0.4065, screenW * 0.5896, screenH * 0.4639,  screenW * 0.4099, screenH * 0.4065, screenW * 0.1797, screenH * 0.0574, "cGielda")
end)

addEventHandler("onClientMarkerLeave", marker, function(hit)
  if hit ~= localPlayer then return end
  local pojazd = getPedOccupiedVehicle(hit)
  if not pojazd then return end
  removeEventHandler("onClientRender", getRootElement(), gui)
  showCursor(false)
  exports["dxedits"]:editbox_destroy("cGielda")
  showed = false
end)

local actual_vehicle = false

addEventHandler("onClientClick", root, function(b, s)
  if b ~= "state" and s ~= "down" then return end
  if mysz(screenW * 0.3776, screenH * 0.5019, screenW * 0.1156, screenH * 0.0593) and showed == true then
    local cena = exports["dxedits"]:editbox_text("cGielda")
    if cena:len() < 1 then return end
  	if not tonumber(cena) then
          exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Podana cena musi być liczbą!")	
        return
    end
  	if cena:len() < 2 then
          exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Cena pojazdu powinna mieć minimum 2 liczby!")		
    	 return
  	end
  	if cena:len() > 8 then
      exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Cena pojazdu powinna mieć maksimum 8 liczb!")	
      return
  	end
  	if tonumber(cena) <= 1 then
      exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Cena pojazdu powinna mieć wartość większą od zera!")	
  	  return
  	end
    local pojazd = getPedOccupiedVehicle(localPlayer)
  	if getElementData(pojazd, "gielda") then
      exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Pojazd jest już wystawiony na giełdzie!")		
      return
  	end
    setElementData(pojazd, "gielda", {
    ["cena"] = cena,
    ["id"] = getElementData(pojazd, "id"),
    ["wlasciciel"] = getPlayerName(localPlayer),
    ["uwlasciciel"] = getElementData(localPlayer, "dbid"),
    })
    cena = string.format("%d", cena)
    exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Wystawiłeś pojazd "..getVehicleName(pojazd).." za cene "..cena.." PLN")	
    triggerServerEvent("gielda", localPlayer, pojazd)
    setElementData(pojazd, "nametag", "ID: "..getElementData(pojazd, "id").."\nModel: "..getVehicleName(pojazd).."\nCena: "..cena.." PLN\nPodejdź aby zobaczyć więcej informacji.")
    removeEventHandler("onClientRender", root, gui)
    showCursor(false)
    exports["dxedits"]:editbox_destroy("cGielda")
    showed = false
  elseif mysz(screenW * 0.5094, screenH * 0.5009, screenW * 0.1156, screenH * 0.0593) and showed == true then
    showCursor(false)
    removeEventHandler("onClientRender", root, gui)
    exports["dxedits"]:editbox_destroy("cGielda")
    showed = false
  elseif mysz(screenW * 0.4125, screenH * 0.5935, screenW * 0.0844, screenH * 0.0509) and actual_vehicle ~= false then
    triggerServerEvent("kuppojazd:gielda", localPlayer, actual_vehicle)
    actual_vehicle = false
    removeEventHandler("onClientRender", root, gui2)
    showCursor(false)
  elseif mysz(screenW * 0.5021, screenH * 0.5935, screenW * 0.0844, screenH * 0.0509) and actual_vehicle ~= false then
    actual_vehicle = false
    removeEventHandler("onClientRender", root, gui2)
    showCursor(false)
  end
end)

function gui2()
  local gielda = getElementData(actual_vehicle, "gielda")
        dxDrawButton(screenW * 0.4026, screenH * 0.3417, screenW * 0.1953, screenH * 0.3167, tocolor(15,15,15,222), false)
        roundedRectangle(screenW * 0.4026, screenH * 0.3417, screenW * 0.1953, screenH * 0.0481, tocolor(0,94,254,125), false)
        dxDrawText("Panel kupna pojazdu!", (screenW * 0.4026) + 1, (screenH * 0.3417) + 1, (screenW * 0.5979) + 1, (screenH * 0.3898) + 1, tocolor(0, 0, 0, 255), 0.7, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Panel kupna pojazdu!", screenW * 0.4026, screenH * 0.3417, screenW * 0.5979, screenH * 0.3898, tocolor(255, 255, 255, 255), 0.7, czcionka, "center", "center", false, false, false, false, false)
	local modules = {}
	--[[if getElementData(veh, "zawieszenie") > 0 then
		table.insert(modules, "RZ")
	end]]
	if getElementData(actual_vehicle, "veh:mk1") == 1 then
		table.insert(modules, "MK1")
	end
	if getElementData(actual_vehicle, "veh:mk2") == 1 then
		table.insert(modules, "MK2")
	end
	if getElementData(actual_vehicle, "veh:mk3") == 1 then
		table.insert(modules, "MK3")
	end
	modules = table.concat(modules, ", ")
	if #modules < 1 then
		modules = "brak"
	end			
        dxDrawText("Informacje o pojeździe:\nModel: "..getVehicleName(actual_vehicle).."\nID: "..getElementData(actual_vehicle, "id").."\nCena: "..gielda.cena.." PLN\nWłaściciel: "..gielda.wlasciciel.."\nModuły: "..modules.."\nPrzebieg: "..string.format("%1.2f", getElementData(actual_vehicle, "przebieg")).."km\n", (screenW * 0.4099) + 1, (screenH * 0.3972) + 1, (screenW * 0.5896) + 1, (screenH * 0.5750) + 1, tocolor(0, 0, 0, 255), 0.8, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Informacje o pojeździe:\nModel: "..getVehicleName(actual_vehicle).."\nID: "..getElementData(actual_vehicle, "id").."\nCena: "..gielda.cena.." PLN\nWłaściciel: "..gielda.wlasciciel.."\nModuły: "..modules.."\nPrzebieg: "..string.format("%1.2f", getElementData(actual_vehicle, "przebieg")).."km\n", screenW * 0.4099, screenH * 0.3972, screenW * 0.5896, screenH * 0.5750, tocolor(255, 255, 255, 255), 0.8, czcionka, "center", "center", false, false, false, false, false)
        if mysz(screenW * 0.4125, screenH * 0.5935, screenW * 0.0844, screenH * 0.0509) then
          dxDrawButton(screenW * 0.4125, screenH * 0.5935, screenW * 0.0844, screenH * 0.0509, tocolor(0,94,254,125), false)
        else
          dxDrawButton(screenW * 0.4125, screenH * 0.5935, screenW * 0.0844, screenH * 0.0509, tocolor(30,30,30,225), false)
        end
        if mysz(screenW * 0.5021, screenH * 0.5935, screenW * 0.0844, screenH * 0.0509) then
          dxDrawButton(screenW * 0.5021, screenH * 0.5935, screenW * 0.0844, screenH * 0.0509, tocolor(0,94,254,125), false)
        else
          dxDrawButton(screenW * 0.5021, screenH * 0.5935, screenW * 0.0844, screenH * 0.0509, tocolor(30,30,30,225), false)
        end
        dxDrawText("Zakup", (screenW * 0.4120) + 1, (screenH * 0.5926) + 1, (screenW * 0.4969) + 1, (screenH * 0.6444) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Zakup", screenW * 0.4120, screenH * 0.5926, screenW * 0.4969, screenH * 0.6444, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Anuluj", (screenW * 0.5021) + 1, (screenH * 0.5926) + 1, (screenW * 0.5870) + 1, (screenH * 0.6444) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Anuluj", screenW * 0.5021, screenH * 0.5926, screenW * 0.5870, screenH * 0.6444, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
end

addEvent("cuboid", true)
addEventHandler("cuboid", root, function(pojazd)
  actual_vehicle = pojazd
  addEventHandler("onClientRender", root, gui2)
  showCursor(true)
end)