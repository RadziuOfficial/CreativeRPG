--[[

*** author: krampsi
*** copyright ©
*** Zakaz używania zasobu bez mojej zgody.

]]--
local marker=createMarker(-1610.40, 690.04, 1337.95-0.9, 'cylinder', 1, 255,255, 255, 30)
setElementDimension(marker, 0)
setElementInterior(marker, 0)

local screenW, screenH = guiGetScreenSize()
local sw,sh = guiGetScreenSize()
local elements = {}

function shadowText2(text, x, y, w, h, color, size, font, xx, yy)
	dxDrawText(text, x, y, w, h, color, size, font, xx, yy, false,false,false,true)
end

function shadowText(text, x, y, w, h, color, size, font, xx, yy)
	dxDrawText(text, x+1, y+1, w+1, h+1, tocolor(0,0,0), size, font, xx, yy, false)
	dxDrawText(text, x, y, w, h, color, size, font, xx, yy, false,false,false,true)
end

function roundedRectangle(x, y, w, h, color)

  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x + 2, y + h, w - 4, 1, color, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 4, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 4, color, false)
end

local font = "default-bold"

okno = false
okno69 = false


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



addEventHandler("onClientMarkerHit", marker, function(player)
if player ~= localPlayer then return end

addEventHandler("onClientRender", root, gui)
okno69 = true
showCursor(true)
end)


function gui()
        roundedRectangle(screenW * 0.3403, screenH * 0.2378, screenW * 0.3049, screenH * 0.5089, tocolor(0, 0, 0, 30), false)
		
        roundedRectangle(screenW * 0.3403, screenH * 0.1967, screenW * 0.3049, screenH * 0.0644, tocolor(0, 60, 255, 150), false)
		if mysz(screenW * 0.3563, screenH * 0.5800, screenW * 0.2771, screenH * 0.0722) then
        roundedRectangle(screenW * 0.3563, screenH * 0.5800, screenW * 0.2771, screenH * 0.0722, tocolor(0, 60, 255, 100), false)
		else
		roundedRectangle(screenW * 0.3563, screenH * 0.5800, screenW * 0.2771, screenH * 0.0722, tocolor(0, 60, 255, 130), false)
		end
		if mysz(screenW * 0.3563, screenH * 0.6633, screenW * 0.2771, screenH * 0.0722) then
        roundedRectangle(screenW * 0.3563, screenH * 0.6633, screenW * 0.2771, screenH * 0.0722, tocolor(0, 60, 255, 100), false)
		else
		roundedRectangle(screenW * 0.3563, screenH * 0.6633, screenW * 0.2771, screenH * 0.0722, tocolor(0, 60, 255, 130), false)
		end
        shadowText("Zamknij", screenW * 0.3563, screenH * 0.6633, screenW * 0.6333, screenH * 0.7356, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
		if getElementData(localPlayer,"player:duty")=="Policja" then
		shadowText("Zakończ służbę\nPolicja", screenW * 0.3563, screenH * 0.7000, screenW * 0.6333, screenH * 0.5289, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
		else
		shadowText("Rozpocznij służbę\nPolicja", screenW * 0.3563, screenH * 0.7000, screenW * 0.6333, screenH * 0.5289, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
		end
        shadowText("Policja", screenW * 0.3396, screenH * 0.1967, screenW * 0.6451, screenH * 0.2611, tocolor(255, 255, 255, 255), 1.5, font, "center", "center", false, false, false, false, false)
		shadowText2("Policja\nKomenda miejska policji\nInformacje", screenW * 0.3396, screenH * 0.3300, screenW * 0.6451, screenH * 0.2611, tocolor(255, 0, 0, 200), 1.3, font, "center", "center", false, false, false, false, false)
		shadowText("", screenW * 0.3396, screenH * 0.5300, screenW * 0.6451, screenH * 0.2611, tocolor(255, 255, 255, 255), 1, font, "center", "center", false, false, false, false, false)
end






		addEventHandler("onClientClick", root, function(btn, state)
	if btn == "left" and state == "down" then
	if mysz(screenW * 0.3563, screenH * 0.5800, screenW * 0.2771, screenH * 0.0722) and okno69 == true then
	triggerServerEvent("RozpocznijSAPD",root,localPlayer)
	removeEventHandler("onClientRender", root, gui)
	okno69 = false
	okno = true
	showCursor(false)
	elseif mysz(screenW * 0.3563, screenH * 0.6633, screenW * 0.2771, screenH * 0.0722) and okno69 == true then
    removeEventHandler("onClientRender", root, gui)
	showCursor(false)
	okno69 = false
		end
	end
end)




--]]