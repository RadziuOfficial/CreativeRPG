--[[
  Autor: Asper
  Skrypt: System tworzenia organizacji
  Zakaz uzywania bez zgody autora!
  Zakaz udostepniania bez zgody autora!
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

function dxDrawButton(x, y, w, h, color)
  local color2 = tocolor(0,94,254)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x-0.4660164, y + h-1.6, w+1.5, 2, color2, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 3, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 3, color, false)
end

local czcionka = dxCreateFont(":crpg_fonty/f.ttf", 15)
local okno = false

function gui()
        dxDrawButton(screenW * 0.2573, screenH * 0.3046, screenW * 0.4859, screenH * 0.3907, tocolor(15,15,15,222), false)
        dxDrawRectangle(screenW * 0.2573, screenH * 0.3046, screenW * 0.4859, screenH * 0.0528, tocolor(0,94,254,105), false)
        dxDrawText("Panel tworzenia organizacji", (screenW * 0.2568) + 1, (screenH * 0.3019) + 1, (screenW * 0.7432) + 1, (screenH * 0.3556) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Panel tworzenia organizacji", screenW * 0.2568, screenH * 0.3019, screenW * 0.7432, screenH * 0.3556, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        if mysz(screenW * 0.2792, screenH * 0.6250, screenW * 0.1891, screenH * 0.0519) then
       		dxDrawButton(screenW * 0.2792, screenH * 0.6250, screenW * 0.1891, screenH * 0.0519, tocolor(0,94,254,125), false)
       	else
       		dxDrawButton(screenW * 0.2792, screenH * 0.6250, screenW * 0.1891, screenH * 0.0519, tocolor(30,30,30,225), false)
       	end
        if mysz(screenW * 0.5313, screenH * 0.6250, screenW * 0.1891, screenH * 0.0519) then
       		dxDrawButton(screenW * 0.5313, screenH * 0.6250, screenW * 0.1891, screenH * 0.0519, tocolor(0,94,254,125), false)
       	else
       		dxDrawButton(screenW * 0.5313, screenH * 0.6250, screenW * 0.1891, screenH * 0.0519, tocolor(30,30,30,225), false)
       	end
        dxDrawText("Załóż organizacje", (screenW * 0.2786) + 1, (screenH * 0.6241) + 1, (screenW * 0.4682) + 1, (screenH * 0.6769) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Załóż organizacje", screenW * 0.2786, screenH * 0.6241, screenW * 0.4682, screenH * 0.6769, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Anuluj", (screenW * 0.5313) + 1, (screenH * 0.6241) + 1, (screenW * 0.7208) + 1, (screenH * 0.6769) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Anuluj", screenW * 0.5313, screenH * 0.6241, screenW * 0.7208, screenH * 0.6769, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Aby założyć własną organizacje wypełnij wszystkie pola i kliknij załóż organizacje.\nWymagania: 10000 PLN oraz minimum 10 przegranych godzin.\nUwaga: Pamiętaj iż czwarta ranga to vLider, a piąta to Lider.", (screenW * 0.2625) + 1, (screenH * 0.3695) + 1, (screenW * 0.7349) + 1, (screenH * 0.4380) + 1, tocolor(0, 0, 0, 255), 0.7, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Aby założyć własną organizacje wypełnij wszystkie pola i kliknij załóż organizacje.\nWymagania: 10000 PLN oraz minimum 10 przegranych godzin.\nUwaga: Pamiętaj iż czwarta ranga to vLider, a piąta to Lider.", screenW * 0.2625, screenH * 0.3695, screenW * 0.7349, screenH * 0.4380, tocolor(255, 255, 255, 255), 0.7, czcionka, "center", "center", false, false, false, false, false)
end

local marker = createMarker(2279.32, -1556.70, 2189.04-1, "cylinder", 1.5, 0, 94, 254, 75)
setElementInterior(marker, 1)

addEventHandler("onClientMarkerHit", marker, function(hit)
  	if hit ~= localPlayer then return end
  	if getElementDimension(source) ~= getElementDimension(hit) then return end
    addEventHandler("onClientPreRender", root, gui)
    showCursor(true)
    okno = true
    exports["dxedits"]:editbox_create("", "Nazwa organizacji...", screenW * 0.2818, screenH * 0.4593, screenW * 0.4036, screenH * 0.5130,  screenW * 0.2755, screenH * 0.4593, screenW * 0.1281, screenH * 0.0537, "O2")
    exports["dxedits"]:editbox_create("", "Nazwa drugiej rangi...", screenW * 0.5953, screenH * 0.4593, screenW * 0.7172, screenH * 0.5130,  screenW * 0.5891, screenH * 0.4593, screenW * 0.1281, screenH * 0.0537, "O1")
    exports["dxedits"]:editbox_create("", "Nazwa pierwszej rangi...", screenW * 0.4375, screenH * 0.4583, screenW * 0.5589, screenH * 0.5130,  screenW * 0.4313, screenH * 0.4593, screenW * 0.1281, screenH * 0.0537, "O3")
    exports["dxedits"]:editbox_create("", "Nazwa czwartej rangi...", screenW * 0.4370, screenH * 0.5407, screenW * 0.5589, screenH * 0.5944,  screenW * 0.4307, screenH * 0.5407, screenW * 0.1281, screenH * 0.0537, "O5")
    exports["dxedits"]:editbox_create("", "Nazwa piątej rangi...", screenW * 0.5953, screenH * 0.5407, screenW * 0.7172, screenH * 0.5944,  screenW * 0.5891, screenH * 0.5407, screenW * 0.1281, screenH * 0.0537, "O6")
    exports["dxedits"]:editbox_create("", "Nazwa trzeciej rangi...", screenW * 0.2818, screenH * 0.5407, screenW * 0.4036, screenH * 0.5944,  screenW * 0.2755, screenH * 0.5407, screenW * 0.1281, screenH * 0.0537, "O4")
end)

function guiOff()
  	removeEventHandler("onClientPreRender", root, gui)
  	showCursor(false)
  	exports["dxedits"]:editbox_destroy("O1")
  	exports["dxedits"]:editbox_destroy("O2")
  	exports["dxedits"]:editbox_destroy("O3")
  	exports["dxedits"]:editbox_destroy("O4")
  	exports["dxedits"]:editbox_destroy("O5")
  	exports["dxedits"]:editbox_destroy("O6")
  	okno = false
end

addEventHandler("onClientClick", root, function(b, s)
	if b ~= "state" and s ~= "down" then return end
  	local nazwa = exports["dxedits"]:editbox_text("O2")
  	local r1 = exports["dxedits"]:editbox_text("O1")
  	local r2 = exports["dxedits"]:editbox_text("O3")
  	local r3 = exports["dxedits"]:editbox_text("O4")
  	local r4 = exports["dxedits"]:editbox_text("O5")
  	local r5 = exports["dxedits"]:editbox_text("O6")
  	if mysz(screenW * 0.2792, screenH * 0.6250, screenW * 0.1891, screenH * 0.0519) and okno == true then
  		if nazwa:len() < 2 then
    	  	exports["aw-noti"]:noti("Nazwa organizacji powinna mieć minimum 2 litery.")
    	 	return
  		end
   		if r1:len() < 2 or r2:len() < 2 or r3:len() < 2 or r4:len() < 2 or r5:len() < 2 then
    	  	exports["aw-noti"]:noti("Jedna z wpisanych rang nie ma wpisane minimum 2 liter.")
    	 	return
  		end
    	triggerServerEvent("sOrg", localPlayer, nazwa, r1, r2, r3, r4, r5)
    	guiOff()
  	elseif mysz(screenW * 0.5313, screenH * 0.6250, screenW * 0.1891, screenH * 0.0519) and okno == true then
  		guiOff()
  	end
end)