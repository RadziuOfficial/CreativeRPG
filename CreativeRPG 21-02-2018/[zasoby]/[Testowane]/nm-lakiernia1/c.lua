--[[
Autor: Asper
Dla: .newMode 
Skrypt: Lakiernia
Typ: Client
]]

local c = {}

c.r = guiCreateEdit(0.40, 0.41, 0.12, 0.05, "255", true)
c.g = guiCreateEdit(0.40, 0.47, 0.12, 0.05, "255", true)
c.b = guiCreateEdit(0.40, 0.53, 0.12, 0.05, "255", true)  
guiEditSetMaxLength(c.r, 3)    
guiEditSetMaxLength(c.g, 3)    
guiEditSetMaxLength(c.b, 3)
guiSetVisible(c.r, false) 
guiSetVisible(c.g, false)
guiSetVisible(c.b, false) 

local f = guiCreateFont( ":nm-noti/czcionka.ttf", 10 )
local f2 = dxCreateFont(":nm-noti/czcionka.ttf", 10)

guiSetAlpha(c.r, 0.5)
guiSetFont(c.r, f)
guiSetAlpha(c.g, 0.5)
guiSetFont(c.g, f)
guiSetAlpha(c.b, 0.5)
guiSetFont(c.b, f)

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

function gui()
        exports["nm-blur"]:dxDrawBluredRectangle(screenW * 0.3272, screenH * 0.3477, screenW * 0.3624, screenH * 0.3138, tocolor(150, 150, 150, 255))
        dxDrawText("R:", (screenW * 0.3302) + 1, (screenH * 0.4128) + 1, (screenW * 0.3799) + 1, (screenH * 0.4596) + 1, tocolor(0, 0, 0, 255), 1.00, f2, "center", "center", false, false, false, false, false)
        dxDrawText("R:", screenW * 0.3302, screenH * 0.4128, screenW * 0.3799, screenH * 0.4596, tocolor(255, 255, 255, 255), 1.00, f2, "center", "center", false, false, false, false, false)
        dxDrawText("G:", (screenW * 0.3302) + 1, (screenH * 0.4740) + 1, (screenW * 0.3799) + 1, (screenH * 0.5208) + 1, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        dxDrawText("G:", screenW * 0.3302, screenH * 0.4740, screenW * 0.3799, screenH * 0.5208, tocolor(255, 255, 255, 255), 1.00, f2, "center", "center", false, false, false, false, false)
        dxDrawText("B:", (screenW * 0.3302) + 1, (screenH * 0.5352) + 1, (screenW * 0.3799) + 1, (screenH * 0.5820) + 1, tocolor(0, 0, 0, 255), 1.00, f2, "center", "center", false, false, false, false, false)
        dxDrawText("B:", screenW * 0.3302, screenH * 0.5352, screenW * 0.3799, screenH * 0.5820, tocolor(255, 255, 255, 255), 1.00, f2, "center", "center", false, false, false, false, false)      
        if mysz(screenW * 0.5337, screenH * 0.4115, screenW * 0.1479, screenH * 0.0482) then
      		dxDrawRectangle(screenW * 0.5337, screenH * 0.4115, screenW * 0.1479, screenH * 0.0482, tocolor(101, 255, 0, 180), false)
      	else
      		dxDrawRectangle(screenW * 0.5337, screenH * 0.4115, screenW * 0.1479, screenH * 0.0482, tocolor(101, 255, 0, 180), false)
      	end
        if mysz(screenW * 0.5337, screenH * 0.4727, screenW * 0.1479, screenH * 0.0482) then
      		dxDrawRectangle(screenW * 0.5337, screenH * 0.4727, screenW * 0.1479, screenH * 0.0482, tocolor(101, 255, 0, 180), false)
      	else
      		dxDrawRectangle(screenW * 0.5337, screenH * 0.4727, screenW * 0.1479, screenH * 0.0482, tocolor(101, 255, 0, 180), false)
      	end
        if mysz(screenW * 0.5337, screenH * 0.5339, screenW * 0.1479, screenH * 0.0482) then
      		dxDrawRectangle(screenW * 0.5337, screenH * 0.5339, screenW * 0.1479, screenH * 0.0482, tocolor(101, 255, 0, 180), false)
      	else
      		dxDrawRectangle(screenW * 0.5337, screenH * 0.5339, screenW * 0.1479, screenH * 0.0482, tocolor(101, 255, 0, 180), false)
      	end
        dxDrawText("Zmien kolor pojazdu", (screenW * 0.5329) + 1, (screenH * 0.4115) + 1, (screenW * 0.6816) + 1, (screenH * 0.4596) + 1, tocolor(0, 0, 0, 255), 1.00, f2, "center", "center", false, false, false, false, false)
        dxDrawText("Zmien kolor pojazdu", screenW * 0.5329, screenH * 0.4115, screenW * 0.6816, screenH * 0.4596, tocolor(255, 255, 255, 255), 1.00, f2, "center", "center", false, false, false, false, false)
        dxDrawText("Załóż kolor lamp\nCena: 7 RP", (screenW * 0.5329) + 1, (screenH * 0.4727) + 1, (screenW * 0.6816) + 1, (screenH * 0.5208) + 1, tocolor(0, 0, 0, 255), 1.00, f2, "center", "center", false, false, false, false, false)
        dxDrawText("Załóż kolor lamp\nCena: 7 RP", screenW * 0.5329, screenH * 0.4727, screenW * 0.6816, screenH * 0.5208, tocolor(255, 255, 255, 255), 1.00, f2, "center", "center", false, false, false, false, false)
        dxDrawText("Zmień kolor felg\nCena: 5 RP", (screenW * 0.5329) + 1, (screenH * 0.5326) + 1, (screenW * 0.6816) + 1, (screenH * 0.5807) + 1, tocolor(0, 0, 0, 255), 1.00, f2, "center", "center", false, false, false, false, false)
        dxDrawText("Zmień kolor felg\nCena: 5 RP", screenW * 0.5329, screenH * 0.5326, screenW * 0.6816, screenH * 0.5807, tocolor(255, 255, 255, 255), 1.00, f2, "center", "center", false, false, false, false, false)
        if mysz(screenW * 0.3616, screenH * 0.5951, screenW * 0.1318, screenH * 0.0547) then
      		dxDrawRectangle(screenW * 0.3616, screenH * 0.5951, screenW * 0.1318, screenH * 0.0547, tocolor(101, 255, 0, 180), false)
      	else
      		dxDrawRectangle(screenW * 0.3616, screenH * 0.5951, screenW * 0.1318, screenH * 0.0547, tocolor(101, 255, 0, 180), false)
      	end
      	if mysz(screenW * 0.5234, screenH * 0.5951, screenW * 0.1318, screenH * 0.0547) then
      		--dxDrawRectangle(screenW * 0.5234, screenH * 0.5951, screenW * 0.1318, screenH * 0.0547, tocolor(101, 255, 0, 180), false)
      	else
      		--dxDrawRectangle(screenW * 0.5234, screenH * 0.5951, screenW * 0.1318, screenH * 0.0547, tocolor(101, 255, 0, 180), false)
      	end
		local r = guiGetText(c.r) 
		local g = guiGetText(c.g)
		local b = guiGetText(c.b)
		dxDrawRectangle(screenW * 0.3316, screenH * 0.5977, screenW * 0.0271, screenH * 0.0508, tocolor(r, g, b, 155), false)
        dxDrawText("Zamknij panel lakierni", (screenW * 0.3616) + 1, (screenH * 0.5938) + 1, (screenW * 0.4934) + 1, (screenH * 0.6497) + 1, tocolor(0, 0, 0, 255), 1.00, f2, "center", "center", false, false, false, false, false)
        dxDrawText("Zamknij panel lakierni", screenW * 0.3616, screenH * 0.5938, screenW * 0.4934, screenH * 0.6497, tocolor(255, 255, 255, 255), 1.00, f2, "center", "center", false, false, false, false, false)
        --dxDrawText("Zmień licznik na nowy kolor\nCena: 5 RP", (screenW * 0.5234) + 1, (screenH * 0.5951) + 1, (screenW * 0.6552) + 1, (screenH * 0.6497) + 1, tocolor(0, 0, 0, 255), 1.00, f2, "center", "center", false, false, false, false, false)
        --dxDrawText("Zmień licznik na nowy kolor\nCena: 5 RP", screenW * 0.5234, screenH * 0.5951, screenW * 0.6552, screenH * 0.6497, tocolor(255, 255, 255, 255), 1.00, f2, "center", "center", false, false, false, false, false)
        dxDrawRectangle(screenW * 0.3272, screenH * 0.3477, screenW * 0.3616, screenH * 0.0508, tocolor(101, 255, 0, 180), false)
        dxDrawText("Lakiernia pojazdów", (screenW * 0.3272) + 1, (screenH * 0.3477) + 1, (screenW * 0.6889) + 1, (screenH * 0.3984) + 1, tocolor(0, 0, 0, 255), 1.00, f2, "center", "center", false, false, false, false, false)
        dxDrawText("Lakiernia pojazdów", screenW * 0.3272, screenH * 0.3477, screenW * 0.6889, screenH * 0.3984, tocolor(255, 255, 255, 255), 1.00, f2, "center", "center", false, false, false, false, false)
end

addEventHandler("onClientClick", root, function(b, s)
	if b ~= "state" and s == "down" then return end
  	if guiGetVisible(c.r) ~= true then return end
  	local mp = getElementData(localPlayer, "punkty")
  	if mysz(screenW * 0.3616, screenH * 0.5951, screenW * 0.1318, screenH * 0.0547) then
  		guiSetVisible(c.r, false) 
		guiSetVisible(c.g, false)
		guiSetVisible(c.b, false) 
		showCursor(false)
		showChat(true)
		removeEventHandler("onClientPreRender", root, gui) 
	elseif mysz(screenW * 0.5337, screenH * 0.4115, screenW * 0.1479, screenH * 0.0482) then
		local p = getPedOccupiedVehicle(localPlayer)
		local r = guiGetText(c.r) 
		local g = guiGetText(c.g)
		local b = guiGetText(c.b)
		r = tonumber(r)
		b = tonumber(b)
		g = tonumber(g)
		if r > -1 and g > -1 and b > -1 and r < 256 and g < 256 and b < 256 then
			if getElementData(localPlayer, "l:trakt") then return end
			fadeCamera(false)
		    guiSetVisible(c.r, false) 
			guiSetVisible(c.g, false)
			guiSetVisible(c.b, false) 
			setElementData(localPlayer, "l:trakt", true)
			exports["nm-noti"]:noti("Trwa malowanie pojazdu...")
			setTimer(function()
				fadeCamera(true)
				guiSetVisible(c.r, true) 
				guiSetVisible(c.g, true)
				guiSetVisible(c.b, true)
				triggerServerEvent("mPojazd", localPlayer, p, r, g, b)
				setElementData(localPlayer, "l:trakt", false)
				exports["nm-noti"]:noti("Pomalowałeś pojazd.")
			end, 5000, 1)
		end
    elseif mysz(screenW * 0.5337, screenH * 0.5339, screenW * 0.1479, screenH * 0.0482) then
        local p = getPedOccupiedVehicle(localPlayer)
        local r = guiGetText(c.r) 
        local g = guiGetText(c.g)
        local b = guiGetText(c.b)
        r = tonumber(r)
        b = tonumber(b)
        g = tonumber(g)
        if r > -1 and g > -1 and b > -1 and r < 256 and g < 256 and b < 256 then
        	if getElementData(localPlayer, "l:trakt") then return end
        	if mp < 4 then 
        		exports["nm-noti"]:noti("Brak wystarczających punktów mP.")
        		return 
        	end
		    guiSetVisible(c.r, false) 
			guiSetVisible(c.g, false)
			guiSetVisible(c.b, false) 
        	setElementData(localPlayer, "punkty", mp-5)
			fadeCamera(false)
			exports["nm-noti"]:noti("Trwa malowanie felg pojazdu...")
			setElementData(localPlayer, "l:trakt", true)
			setTimer(function()
				guiSetVisible(c.r, true) 
				guiSetVisible(c.g, true)
				guiSetVisible(c.b, true)
				exports["nm-noti"]:noti("Pomalowałeś felgi, cena 5 mP.")
				fadeCamera(true)
				triggerServerEvent("mFelgi", localPlayer, p, r, g, b)
				setElementData(localPlayer, "l:trakt", false)
			end, 5000, 1)
        end
    elseif mysz(screenW * 0.5337, screenH * 0.4727, screenW * 0.1479, screenH * 0.0482) then
        local p = getPedOccupiedVehicle(localPlayer)
        local r = guiGetText(c.r) 
        local g = guiGetText(c.g)
        local b = guiGetText(c.b)
        r = tonumber(r)
        b = tonumber(b)
        g = tonumber(g)
        if r > -1 and g > -1 and b > -1 and r < 256 and g < 256 and b < 256 then
        	if getElementData(localPlayer, "l:trakt") then return end
        	if mp < 6 then 
        		exports["nm-noti"]:noti("Brak wystarczających punktów mP.")
        		return 
        	end
			fadeCamera(false)
		    guiSetVisible(c.r, false) 
			guiSetVisible(c.g, false)
			guiSetVisible(c.b, false) 
        	setElementData(localPlayer, "punkty", mp-7)
			exports["nm-noti"]:noti("Trwa zmienianie lamp pojazdu...")
			setElementData(localPlayer, "l:trakt", true)
			setTimer(function()
				fadeCamera(true)
				guiSetVisible(c.r, true) 
				guiSetVisible(c.g, true)
				guiSetVisible(c.b, true)
				triggerServerEvent("mSwiatla", localPlayer, p, r, g, b)
				setElementData(localPlayer, "l:trakt", false)
			end, 5000, 1)
        end
    elseif mysz(screenW * 0.5234, screenH * 0.5951, screenW * 0.1318, screenH * 0.0547) then
        local p = getPedOccupiedVehicle(localPlayer)
        local r = guiGetText(c.r) 
        local g = guiGetText(c.g)
        local b = guiGetText(c.b)
        r = tonumber(r)
        b = tonumber(b)
        g = tonumber(g)
        if r > -1 and g > -1 and b > -1 and r < 256 and g < 256 and b < 256 then
        	if getElementData(localPlayer, "l:trakt") then return end
        	if mp < 4 then 
        		exports["nm-noti"]:noti("Brak wystarczających punktów mP.")
        		return 
        	end
		    guiSetVisible(c.r, false) 
			guiSetVisible(c.g, false)
			guiSetVisible(c.b, false) 
			fadeCamera(false)
			setElementData(localPlayer, "l:trakt", true)
			exports["nm-noti"]:noti("Trwa zmienianie licznika pojazdu...")
        	setElementData(localPlayer, "punkty", mp-5)
			setTimer(function()
				fadeCamera(true)
				guiSetVisible(c.r, true) 
				guiSetVisible(c.g, true)
				guiSetVisible(c.b, true)
				setElementData(localPlayer, "l:trakt", false)
            	setElementData(p, "lrgb", {
            		["r"] = r,
            		["g"] = g,
            		["b"] = b,
           		 })
			end, 5000, 1)
        end
	end
end)

addEvent("openLakiernia", true)
addEventHandler("openLakiernia", root, function()
	guiSetVisible(c.r, true) 
	guiSetVisible(c.g, true)
	guiSetVisible(c.b, true)
	showCursor(true)
	showChat(false)
	addEventHandler("onClientPreRender", root, gui) 
end)

addEvent("closeLakiernia", true)
addEventHandler("closeLakiernia", root, function()
	guiSetVisible(c.r, false) 
	guiSetVisible(c.g, false)
	guiSetVisible(c.b, false) 
	showCursor(false)
	showChat(true)
	removeEventHandler("onClientPreRender", root, gui) 
end)