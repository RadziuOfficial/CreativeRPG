--[[
Autor: Asper
Dla: .newMode
Skrypt: Tuning pojazdów
Typ: Client
]]

local sx, sy = guiGetScreenSize()
local cuboid = createColCuboid(2135.73, -2192.62, 13.10, 4, 3, 5)  
local wb = guiCreateGridList(0.40, 0.11, 0.19, 0.17, true)
local nazwa = guiGridListAddColumn(wb, "Nazwa", 0.4)
local cena = guiGridListAddColumn(wb, "Cena", 0.2)
guiSetVisible(wb, false)

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
{"MK1", 35000},
{"MK2", 55000},
{"MK3", 75000},
--{"CB Radio",10000},
--{"Zawieszenie hydrauliczne", 30000},
--{"Napęd FWD", 10000},
--{"Napęd RWD", 10000},
--{"Napęd AWD", 15000},
--{"Bak 50L", 15000},
--{"Bak 75L", 30000},
--{"Bak 100L", 45000},
}

local screenW, screenH = guiGetScreenSize()

local czcionka = dxCreateFont(":crpg_fonty/f.ttf", 14)
if not czcionka then czcionka = "default-bold" end

function dxDrawButton(x, y, w, h, color)
  local color2 = tocolor(0,94,254)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x-0.4660164, y + h-1.6, w+1.5, 2, color2, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 3, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 3, color, false)
end

function gui()
        dxDrawButton(screenW * 0.3792, screenH * 0.0370, screenW * 0.2313, screenH * 0.3346, tocolor(15, 15, 15, 200))
        dxDrawRectangle(screenW * 0.3788, screenH * 0.0360, screenW * 0.2320, screenH * 0.0580, tocolor(0, 94, 254, 200), false)
        dxDrawBorderedText("Tuning Mechaniczny", screenW * 0.7600, screenH * 0.0725, screenW * 0.2320, screenH * 0.0580, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
      	if mysz(screenW * 0.3909, screenH * 0.2948, screenW * 0.0996, screenH * 0.0599) then
        	dxDrawButton(screenW * 0.3909, screenH * 0.2948, screenW * 0.0996, screenH * 0.0599, tocolor(0, 94, 254, 175), false)
        else
        	dxDrawButton(screenW * 0.3909, screenH * 0.2948, screenW * 0.0996, screenH * 0.0599, tocolor(15, 15, 15, 175), false)
        end
       	if mysz(screenW * 0.5007, screenH * 0.2948, screenW * 0.0996, screenH * 0.0599) then
        	dxDrawButton(screenW * 0.5007, screenH * 0.2948, screenW * 0.0996, screenH * 0.0599, tocolor(0, 94, 254, 175), false)
        else
        	dxDrawButton(screenW * 0.5007, screenH * 0.2948, screenW * 0.0996, screenH * 0.0599, tocolor(15, 15, 15, 175), false)
        end      
        dxDrawBorderedText("Akceptuj", screenW * 0.3909, screenH * 0.0948, screenW * 0.4905, screenH * 0.5547, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawBorderedText("Anuluj", screenW * 0.5000, screenH * 0.0948, screenW * 0.5996, screenH * 0.5547, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
end

addEventHandler("onClientClick", root, function(b, s)
	if b ~= "state" and s ~= "down" then return end
	if mysz(screenW * 0.5007, screenH * 0.2948, screenW * 0.0996, screenH * 0.0599) and guiGetVisible(wb) == true then
    	setElementData(localPlayer, "hud", false)		
		guiSetVisible(wb, false)
		showCursor(false)	
		showChat(true)
  		showPlayerHudComponent("radar", true)			
		local p = getPedOccupiedVehicle(localPlayer)
		setElementFrozen(p, false)
		removeEventHandler("onClientPreRender", root, gui)
	elseif mysz(screenW * 0.3909, screenH * 0.2948, screenW * 0.0996, screenH * 0.0599) and guiGetVisible(wb) == true then
		local wy = guiGridListGetSelectedItem(wb)
		local nazwa = guiGridListGetItemText(wb, wy, 1)
		local cena = guiGridListGetItemText(wb, wy, 2)
		cena = tonumber(cena)
		local p = getPedOccupiedVehicle(localPlayer)
		triggerServerEvent("mTuning", localPlayer, p, nazwa, cena)
	end
end)

addEventHandler("onClientMarkerHit", resourceRoot, function(hit)
	if hit ~= localPlayer then return end
	if not isPedInVehicle(hit) then return end
	if #getElementsWithinColShape(cuboid, "vehicle") == 1 then
		exports["nm-noti"]:noti("Tuning jest w tej chwili używany.")
		return
	end
	local p = getPedOccupiedVehicle(hit)
	if getVehicleController(p) ~= hit then return end
	if getElementData(p, "wlasciciel") ~= getElementData(hit, "dbid") then return end
    setElementData(localPlayer, "hud", true)	
	guiSetVisible(wb, true)
	showCursor(true)	
	showChat(false)	
  	showPlayerHudComponent("radar", false)		
	setElementFrozen(p, true)
	addEventHandler("onClientPreRender", root, gui)
end)

function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x - 1, y - 1, w - 1, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x + 1, y - 1, w + 1, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x - 1, y + 1, w - 1, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x + 1, y + 1, w + 1, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x - 1, y, w - 1, h, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x + 1, y, w + 1, h, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x, y - 1, w, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x, y + 1, w, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true )
end

addEventHandler("onClientResourceStart", resourceRoot, function()
	for k,v in ipairs(tuning) do
		local r = guiGridListAddRow(wb)
		guiGridListSetItemText(wb, r, nazwa, v[1], false, false)
		local cx = v[2]
		cx = string.format("%1.2f", cx)
		guiGridListSetItemText(wb, r, cena, cx, false, false)
	end
end)