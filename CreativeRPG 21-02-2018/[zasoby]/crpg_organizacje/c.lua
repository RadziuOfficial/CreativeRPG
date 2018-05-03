--[[
Autor: Asper
Skrypt: Organizacje
Zakaz udostepniania bez zgody autora!
Zakaz uzywania bez zgody autora!
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

local czcionka = dxCreateFont(":crpg_fonty/f.ttf", 15)

local org = "?"

function dxDrawButton(x, y, w, h, color)
  local color2 = tocolor(0,94,254)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x-0.4660164, y + h-1.6, w+1.5, 2, color2, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 3, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 3, color, false)
end

function roundedRectangle(x, y, w, h, color)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x + 2, y + h, w - 4, 1, color, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 4, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 4, color, false)
end

local liderGui = false

function gui()
    dxDrawButton(screenW * 0.2665, screenH * 0.2513, screenW * 0.4671, screenH * 0.4974, tocolor(15,15,15,222), false)
    dxDrawRectangle(screenW * 0.2665, screenH * 0.2513, screenW * 0.4671, screenH * 0.0521, tocolor(0,94,254,125), false)
    dxDrawText("Panel organizacji", (screenW * 0.2665) + 1, (screenH * 0.2500) + 1, (screenW * 0.7335) + 1, (screenH * 0.3021) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
    dxDrawText("Panel organizacji", screenW * 0.2665, screenH * 0.2500, screenW * 0.7335, screenH * 0.3021, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
    
    if liderGui == true then
        if mysz(screenW * 0.6186, screenH * 0.6667, screenW * 0.1047, screenH * 0.0612) then
       		dxDrawButton(screenW * 0.6186, screenH * 0.6667, screenW * 0.1047, screenH * 0.0612, tocolor(0,94,254,125), false)
       	else
       		dxDrawButton(screenW * 0.6186, screenH * 0.6667, screenW * 0.1047, screenH * 0.0612, tocolor(30,30,30,225), false)
       	end
       
        if mysz(screenW * 0.6186, screenH * 0.5664, screenW * 0.1047, screenH * 0.0612) then
       		dxDrawButton(screenW * 0.6186, screenH * 0.5664, screenW * 0.1047, screenH * 0.0612, tocolor(0,94,254,125), false)
       	else
       		dxDrawButton(screenW * 0.6186, screenH * 0.5664, screenW * 0.1047, screenH * 0.0612, tocolor(30,30,30,225), false)
       	end
       
        if mysz(screenW * 0.6186, screenH * 0.4844, screenW * 0.1047, screenH * 0.0612) then
       		dxDrawButton(screenW * 0.6186, screenH * 0.4844, screenW * 0.1047, screenH * 0.0612, tocolor(0,94,254,125), false)
       	else
       		dxDrawButton(screenW * 0.6186, screenH * 0.4844, screenW * 0.1047, screenH * 0.0612, tocolor(30,30,30,225), false)
       	end
       
        if mysz(screenW * 0.6186, screenH * 0.4049, screenW * 0.1047, screenH * 0.0612) then
       		dxDrawButton(screenW * 0.6186, screenH * 0.4049, screenW * 0.1047, screenH * 0.0612, tocolor(0,94,254,125), false)
       	else
       		dxDrawButton(screenW * 0.6186, screenH * 0.4049, screenW * 0.1047, screenH * 0.0612, tocolor(30,30,30,225), false)
       	end
       
        dxDrawText("Dodaj osobe", (screenW * 0.6186) + 1, (screenH * 0.4049) + 1, (screenW * 0.7225) + 1, (screenH * 0.4661) + 1, tocolor(0, 0, 0, 255), 0.9, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Dodaj osobe", screenW * 0.6186, screenH * 0.4049, screenW * 0.7225, screenH * 0.4661, tocolor(255, 255, 255, 255), 0.9, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Edytuj osobe", (screenW * 0.6186) + 1, (screenH * 0.4844) + 1, (screenW * 0.7225) + 1, (screenH * 0.5456) + 1, tocolor(0, 0, 0, 255), 0.9, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Edytuj osobe", screenW * 0.6186, screenH * 0.4844, screenW * 0.7225, screenH * 0.5456, tocolor(255, 255, 255, 255), 0.9, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Wyrzuć osobe", (screenW * 0.6186) + 1, (screenH * 0.5664) + 1, (screenW * 0.7225) + 1, (screenH * 0.6276) + 1, tocolor(0, 0, 0, 255), 0.9, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Wyrzuć osobe", screenW * 0.6186, screenH * 0.5664, screenW * 0.7225, screenH * 0.6276, tocolor(255, 255, 255, 255), 0.9, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Zamknij panel", (screenW * 0.6186) + 1, (screenH * 0.6667) + 1, (screenW * 0.7225) + 1, (screenH * 0.7279) + 1, tocolor(0, 0, 0, 255), 0.9, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Zamknij panel", screenW * 0.6186, screenH * 0.6667, screenW * 0.7225, screenH * 0.7279, tocolor(255, 255, 255, 255), 0.9, czcionka, "center", "center", false, false, false, false, false)
    end
end

function gui2()
        roundedRectangle(screenW * 0.3679, screenH * 0.0333, screenW * 0.2643, screenH * 0.1876, tocolor(15, 15, 15, 222), false)
        if mysz(screenW * 0.3798, screenH * 0.1457, screenW * 0.1196, screenH * 0.0505) then
       		dxDrawButton(screenW * 0.3798, screenH * 0.1457, screenW * 0.1196, screenH * 0.0505, tocolor(0,94,254,125), false)
       	else
       		dxDrawButton(screenW * 0.3798, screenH * 0.1457, screenW * 0.1196, screenH * 0.0505, tocolor(30,30,30,225), false)
       	end
        if mysz(screenW * 0.5024, screenH * 0.1457, screenW * 0.1196, screenH * 0.0505) then
       		dxDrawButton(screenW * 0.5024, screenH * 0.1457, screenW * 0.1196, screenH * 0.0505, tocolor(0,94,254,125), false)
       	else
       		dxDrawButton(screenW * 0.5024, screenH * 0.1457, screenW * 0.1196, screenH * 0.0505, tocolor(30,30,30,225), false)
       	end
        dxDrawText("Akceptuj", (screenW * 0.3792) + 1, (screenH * 0.1457) + 1, (screenW * 0.4994) + 1, (screenH * 0.1962) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Akceptuj", screenW * 0.3792, screenH * 0.1457, screenW * 0.4994, screenH * 0.1962, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Anuluj", (screenW * 0.5018) + 1, (screenH * 0.1457) + 1, (screenW * 0.6220) + 1, (screenH * 0.1962) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Anuluj", screenW * 0.5018, screenH * 0.1457, screenW * 0.6220, screenH * 0.1962, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
end

local gridlist = false
local gui2_showed = false
local gui3_showed = false

function usunGui()
	gridlist = false
   	exports["dxlists"]:dxDestroy(3)
   	showCursor(false)
   	removeEventHandler("onClientPreRender", root, gui)
   	org = false
   	if gui2_showed == true then
   		removeEventHandler("onClientPreRender", root, gui2)
   		gui2_showed = false
   	   	exports["dxedits"]:editbox_destroy("oNick")
	end
   	if gui3_showed == true then
   		removeEventHandler("onClientPreRender", root, gui2)
   		gui3_showed = false
   	   	exports["dxedits"]:editbox_destroy("oRanga")
	end
end

addEvent("cListaO", true)
addEventHandler("cListaO", root, function(s, s2)
	if gridlist == false then
  		addEventHandler("onClientPreRender", root, gui)
  		showCursor(true, false)
  		gridlist = exports["dxlists"]:dxCreate(screenW * 0.2745, screenH * 0.3176, screenW * 0.3312, screenH * 0.4176,  3)
       	exports["dxlists"]:dxAddColumn(3, "DBID", 100) 
        exports["dxlists"]:dxAddColumn(3, "Nick", 125)
        exports["dxlists"]:dxAddColumn(3, "Ranga", 125) 
        exports["dxlists"]:dxAddColumn(3, "Status", 125) 
        exports["dxlists"]:dxAddColumn(3, "O-R", 200) 
        local ranga = getElementData(localPlayer, "oranga")
        if ranga > 3 then
        	liderGui = true
        else
        	liderGui = false
        end
  		if not s and not s2 then return end
  		for _, p in pairs(s) do
    		if getPlayerFromName(p["login"]) then
    			stan = "ONLINE"
    		else
    			stan = "OFFLINE"
    		end
    		org = s2["nazwa"]
  			local ranga = "Nieznana"
  			if p["oranga"] == 1 then ranga = s2["r1"] end
  			if p["oranga"] == 2 then ranga = s2["r2"] end
  			if p["oranga"] == 3 then ranga = s2["r3"] end
  			if p["oranga"] == 4 then ranga = s2["r4"] end
   			if p["oranga"] == 5 then ranga = s2["r5"] end

   			exports["dxlists"]:dxAddItem(1, tostring(p["dbid"]), 3)
            exports["dxlists"]:dxAddItem(2, p["login"], 3)
            exports["dxlists"]:dxAddItem(3, ranga, 3) 
            exports["dxlists"]:dxAddItem(4, stan, 3) 
            exports["dxlists"]:dxAddItem(5, tostring(p["oranga"]), 3) 
   		end
   	else
   		usunGui()
   	end
end)

bindKey("F5", "down", function()
	if not getElementData(localPlayer, "organizacja") then return end
	triggerServerEvent("sListaO", resourceRoot, localPlayer)
end)

addEventHandler("onClientClick", root, function(b, s)
	if b ~= "state" and s ~= "down" then return end
	if mysz(screenW * 0.6186, screenH * 0.6667, screenW * 0.1047, screenH * 0.0612) and gridlist ~= false then
		usunGui()
		removeEventHandler("onClientPreRender", root, gui)
	elseif mysz(screenW * 0.6186, screenH * 0.4049, screenW * 0.1047, screenH * 0.0612) and gridlist ~= false and liderGui == true then
		if gui2_showed ~= true then
			gui2_showed = true
			addEventHandler("onClientPreRender", root, gui2)
			exports["dxedits"]:editbox_create("", "Nick osoby do dodania...", screenW * 0.3905, screenH * 0.0638, screenW * 0.6196, screenH * 0.1105,  screenW * 0.3798, screenH * 0.0638, screenW * 0.2399, screenH * 0.0467, "oNick")
		end
	elseif mysz(screenW * 0.5024, screenH * 0.1457, screenW * 0.1196, screenH * 0.0505) and gridlist ~= false and liderGui == true and gui2_showed == true then
		removeEventHandler("onClientPreRender", root, gui2)
		exports["dxedits"]:editbox_destroy("oNick")
		gui2_showed = false
	elseif mysz(screenW * 0.3798, screenH * 0.1457, screenW * 0.1196, screenH * 0.0505) and gridlist ~= false and liderGui == true and gui2_showed == true then
		local gracz = exports["dxedits"]:editbox_text("oNick")
		if not gracz or gracz:len() < 2 then return end
		triggerServerEvent("oDodaj", resourceRoot, localPlayer, gracz)
	elseif mysz(screenW * 0.6186, screenH * 0.4844, screenW * 0.1047, screenH * 0.0612) and gridlist ~= false and liderGui == true then
		if gui3_showed ~= true then
			local wybrany_gracz = exports["dxlists"]:dxItemDetails(3, 2)
			if not wybrany_gracz then
				exports["aw-noti"]:noti("Najpierw wybierz gracza którego chcesz edytować.")
				return
			end
			gui3_showed = true
			addEventHandler("onClientPreRender", root, gui2)
			exports["dxedits"]:editbox_create("", "Ranga osoby do edytowania...", screenW * 0.3905, screenH * 0.0638, screenW * 0.6196, screenH * 0.1105,  screenW * 0.3798, screenH * 0.0638, screenW * 0.2399, screenH * 0.0467, "oRanga")
		end
	elseif mysz(screenW * 0.5024, screenH * 0.1457, screenW * 0.1196, screenH * 0.0505) and gridlist ~= false and liderGui == true and gui3_showed == true then
		removeEventHandler("onClientPreRender", root, gui2)
		exports["dxedits"]:editbox_destroy("oRanga")
		gui3_showed = false
	elseif mysz(screenW * 0.3798, screenH * 0.1457, screenW * 0.1196, screenH * 0.0505) and gridlist ~= false and liderGui == true and gui3_showed == true then
   		local ranga = exports["dxedits"]:editbox_text("oRanga")
   		local wybrany_gracz = exports["dxlists"]:dxItemDetails(3, 2)
   		local wybrana_ranga = exports["dxlists"]:dxItemDetails(3, 5)
   		if not wybrany_gracz and not wybrana_ranga then return end
   		ranga = tonumber(ranga)
   		wybrana_ranga = tonumber(wybrana_ranga)
		if not tonumber(ranga) then return end
		triggerServerEvent("oEdytuj", resourceRoot, localPlayer, wybrany_gracz, ranga, wybrana_ranga)
	elseif mysz(screenW * 0.6186, screenH * 0.5664, screenW * 0.1047, screenH * 0.0612) and gridlist ~= false and liderGui == true then
   		local wybrany_gracz = exports["dxlists"]:dxItemDetails(3, 2)
   		local wybrana_ranga = exports["dxlists"]:dxItemDetails(3, 5)
   		if not wybrana_ranga and not wybrana_ranga then return end
		triggerServerEvent("oWyrzuc", resourceRoot, localPlayer, wybrany_gracz, wybrana_ranga)
	end
end)