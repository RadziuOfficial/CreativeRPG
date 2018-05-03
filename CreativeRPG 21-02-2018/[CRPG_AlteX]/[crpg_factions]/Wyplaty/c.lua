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

function shadowText(text, x, y, w, h, color, size, font, xx, yy)
	dxDrawText(text, x+1, y+1, w+1, h+1, tocolor(0,0,0), size, font, xx, yy, false)
	dxDrawText(text, x, y, w, h, color, size, font, xx, yy, false)
end

oknowyplat = false

local dxfont0_cz = dxCreateFont(":nm-login/cz.ttf", 18)
local dxfont1_cz = dxCreateFont(":nm-login/cz.ttf", 20)
local dxfont2_cz = dxCreateFont(":nm-login/cz.ttf", 12)

function gui()
exports["nm-blur"]:dxDrawBluredRectangle(screenW * 0.3294, screenH * 0.2331, screenW * 0.3419, screenH * 0.5352, tocolor(150, 150, 150, 255))
        dxDrawRectangle(screenW * 0.3294, screenH * 0.2331, screenW * 0.3419, screenH * 0.5352, tocolor(0, 0, 0, 128), false)
        dxDrawRectangle(screenW * 0.3294, screenH * 0.2331, 44, 411, tocolor(255, 0, 0, 255), false)
        shadowText("W\nY\nP\nŁ\nA\nT\nY", screenW * 0.3316, screenH * 0.2383, screenW * 0.3580, screenH * 0.7630, tocolor(255, 255, 255, 255), 1.00, dxfont0_cz, "center", "center", false, false, false, false, false)
        shadowText("Tutaj odbierzesz wypłate z frakcji SAPD, LSFD, SAMC.\n\nTwoja słuzba wynosi: "..getElementData(localPlayer,"wyplata").." minut/a", screenW * 0.3675, screenH * 0.2357, screenW * 0.6640, screenH * 0.6016, tocolor(255, 255, 255, 255), 1.00, dxfont2_cz, "center", "center", false, false, false, false, false)
        if isMouseIn(screenW * 0.3690, screenH * 0.6094, screenW * 0.2950, screenH * 0.0664) then
        dxDrawRectangle(screenW * 0.3690, screenH * 0.6094, screenW * 0.2950, screenH * 0.0664, tocolor(255, 0, 0, 155), false)
        else
        dxDrawRectangle(screenW * 0.3690, screenH * 0.6094, screenW * 0.2950, screenH * 0.0664, tocolor(255, 0, 0, 255), false)
        end
        if isMouseIn(screenW * 0.3690, screenH * 0.6888, screenW * 0.2950, screenH * 0.0664) then
        dxDrawRectangle(screenW * 0.3690, screenH * 0.6888, screenW * 0.2950, screenH * 0.0664, tocolor(255, 0, 0, 155), false)
        else
        dxDrawRectangle(screenW * 0.3690, screenH * 0.6888, screenW * 0.2950, screenH * 0.0664, tocolor(255, 0, 0, 255), false)
        end
        shadowText("Wypłać", screenW * 0.3734, screenH * 0.6094, screenW * 0.6567, screenH * 0.6758, tocolor(255, 255, 255, 255), 1.00, dxfont1_cz, "center", "center", false, false, false, false, false)
        shadowText("Zamknij", screenW * 0.3734, screenH * 0.6888, screenW * 0.6567, screenH * 0.7552, tocolor(255, 255, 255, 255), 1.00, dxfont1_cz, "center", "center", false, false, false, false, false)
end


local marker = createMarker(-2690.74, 255.29, 4.33-1,"cylinder", 1.5, 255, 255, 255, 50)

addEventHandler("onClientMarkerHit", marker, function(player)
	if player ~= localPlayer then return end
    addEventHandler("onClientRender", root, gui)
    oknowyplat = true
    showCursor(true)
--
addEventHandler("onClientClick", root, function(btn, state)
	if btn == "left" and state == "down" then
		if isMouseIn(screenW * 0.3690, screenH * 0.6094, screenW * 0.2950, screenH * 0.0664) and oknowyplat == true then
			local pieniadze = getElementData(localPlayer,"pieniadze")
			local wyplata = getElementData(localPlayer,"wyplata")*200
			local minut = getElementData(localPlayer,"wyplata")
			if minut < 1 then return exports["crpg_powiadomienia"]:noti("Musisz posiadać minimum 1 minute na służbie aby odebrać wypłate.") end
			setElementData(localPlayer,"pieniadze", pieniadze+wyplata)
			exports["crpg_powiadomienia"]:noti("Odebrałeś "..wyplata.." PLN za "..minut.." minut.")
			removeEventHandler("onClientRender", root, gui)
                        oknowyplat = false
                        showCursor(false)
                        setElementData(localPlayer,"wyplata", 0)
		elseif isMouseIn(screenW * 0.3690, screenH * 0.6888, screenW * 0.2950, screenH * 0.0664) and oknowyplat == true then
			removeEventHandler("onClientRender", root, gui)
                        oknowyplat = false
                        showCursor(false)
		end
	end
end)
end)