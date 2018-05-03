--[[
Autor: Asper
Nie masz prawa użyć tego kodu bez mojej zgody
]]

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

local gui = false

addEvent("onPlayerStartJob", true)
addEvent("onPlayerResign", true)
addEvent("onClientPlayerPayday", true)

addEvent("createJobsWindow", true)
addEventHandler("createJobsWindow", root, function(det)
	ustawienia = det
	if getElementData(localPlayer, "praca") == ustawienia[3] then
		addEventHandler("onClientRender", root, guiPrace2)
	else
		addEventHandler("onClientRender", root, guiPrace)
	end
	showCursor(true, false)
	gui = true
end)

addEvent("destroyJobsWindow", true)
addEventHandler("destroyJobsWindow", root, function()
	if getElementData(localPlayer, "praca") == ustawienia[3] then
		removeEventHandler("onClientRender", root, guiPrace2)
	else
		removeEventHandler("onClientRender", root, guiPrace)
	end
	showCursor(false)
	gui = false
end)

function roundedRectangle(x, y, w, h, color)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x + 2, y + h, w - 4, 1, color, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 4, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 4, color, false)
end

local foncik = dxCreateFont(":crpg_fonty/f.ttf", 15)
if not foncik then
	foncik = "default"
end
local napis = false
local napis2 = false

function dxDrawButton(x, y, w, h, color)
  local color2 = tocolor(0,94,254)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x-0.4660164, y + h-1.6, w+1.5, 2, color2, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 3, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 3, color, false)
end

function guiPrace2()
	if getElementData(localPlayer, "praca") == ustawienia[3] then
		napis = "Odbierz wypłatę"
	else
		napis = "Zatrudnij się"
	end

    roundedRectangle(screenW * 0.3656, screenH * 0.2870, screenW * 0.2693, screenH * 0.4259, tocolor(15,15,15,222), false)
    roundedRectangle(screenW * 0.3656, screenH * 0.2870, screenW * 0.2693, screenH * 0.0481, tocolor(0,94,254, 125), false)
    dxDrawText("Panel pracy", (screenW * 0.3651) + 1, (screenH * 0.2870) + 1, (screenW * 0.6349) + 1, (screenH * 0.3352) + 1, tocolor(0, 0, 0, 255), 1, foncik, "center", "center", false, false, false, false, false)
    dxDrawText("Panel pracy", screenW * 0.3651, screenH * 0.2870, screenW * 0.6349, screenH * 0.3352, tocolor(255, 255, 255, 255), 1, foncik, "center", "center", false, false, false, false, false)
    dxDrawText(ustawienia[2], (screenW * 0.3776) + 1, (screenH * 0.3509) + 1, (screenW * 0.6240) + 1, (screenH * 0.5463) + 1, tocolor(0, 0, 0, 255), 0.7, foncik, "center", "center", false, true, false, false, false)
    dxDrawText(ustawienia[2], screenW * 0.3776, screenH * 0.3509, screenW * 0.6240, screenH * 0.5463, tocolor(255, 255, 255, 255), 0.7, foncik, "center", "center", false, true, false, false, false)
    if isMouseIn(screenW * 0.4167, screenH * 0.5685, screenW * 0.1667, screenH * 0.0546) then
        dxDrawButton(screenW * 0.4167, screenH * 0.5685, screenW * 0.1667, screenH * 0.0546, tocolor(0,94,254, 125), false)
    else
        dxDrawButton(screenW * 0.4167, screenH * 0.5685, screenW * 0.1667, screenH * 0.0546, tocolor(30,30,30,100), false)
   	end
   	if isMouseIn(screenW * 0.4167, screenH * 0.6324, screenW * 0.1667, screenH * 0.0546) then
        dxDrawButton(screenW * 0.4167, screenH * 0.6324, screenW * 0.1667, screenH * 0.0546, tocolor(0,94,254, 125), false)
    else
        dxDrawButton(screenW * 0.4167, screenH * 0.6324, screenW * 0.1667, screenH * 0.0546, tocolor(30,30,30,100), false)
    end
    dxDrawText(napis, (screenW * 0.4161) + 1, (screenH * 0.5685) + 1, (screenW * 0.5833) + 1, (screenH * 0.6231) + 1, tocolor(0, 0, 0, 255), 1, foncik, "center", "center", false, true, false, false, false)
    dxDrawText(napis, screenW * 0.4161, screenH * 0.5685, screenW * 0.5833, screenH * 0.6231, tocolor(255, 255, 255, 255), 1, foncik, "center", "center", false, true, false, false, false)
    dxDrawText("Zwolnij się", (screenW * 0.4161) + 1, (screenH * 0.6950) + 1, (screenW * 0.5833) + 1, (screenH * 0.6231) + 1, tocolor(0, 0, 0, 255), 1, foncik, "center", "center", false, false, false, false, false)
    dxDrawText("Zwolnij się", screenW * 0.4161, screenH * 0.6950, screenW * 0.5833, screenH * 0.6231, tocolor(255, 255, 255, 255), 1, foncik, "center", "center", false, false, false, false, false)
end

function guiPrace()
	if getElementData(localPlayer, "praca") == ustawienia[3] then
		napis2 = "Odbierz wypłatę"
	else
		napis2 = "Zatrudnij się"
	end
    roundedRectangle(screenW * 0.3656, screenH * 0.2870, screenW * 0.2693, screenH * 0.4259, tocolor(15,15,15,222), false)
    roundedRectangle(screenW * 0.3656, screenH * 0.2870, screenW * 0.2693, screenH * 0.0481, tocolor(0,94,254, 125), false)
    dxDrawText("Panel pracy", (screenW * 0.3651) + 1, (screenH * 0.2870) + 1, (screenW * 0.6349) + 1, (screenH * 0.3352) + 1, tocolor(0, 0, 0, 255), 1, foncik, "center", "center", false, false, false, false, false)
    dxDrawText("Panel pracy", screenW * 0.3651, screenH * 0.2870, screenW * 0.6349, screenH * 0.3352, tocolor(255, 255, 255, 255), 1, foncik, "center", "center", false, false, false, false, false)
    dxDrawText(ustawienia[2], (screenW * 0.3776) + 1, (screenH * 0.3509) + 1, (screenW * 0.6240) + 1, (screenH * 0.5463) + 1, tocolor(0, 0, 0, 255), 0.7, foncik, "center", "center", false, true, false, false, false)
    dxDrawText(ustawienia[2], screenW * 0.3776, screenH * 0.3509, screenW * 0.6240, screenH * 0.5463, tocolor(255, 255, 255, 255), 0.7, foncik, "center", "center", false, true, false, false, false)
    if isMouseIn(screenW * 0.4167, screenH * 0.5685, screenW * 0.1667, screenH * 0.0546) then
        dxDrawButton(screenW * 0.4167, screenH * 0.5685, screenW * 0.1667, screenH * 0.0546, tocolor(0,94,254, 125), false)
    else
        dxDrawButton(screenW * 0.4167, screenH * 0.5685, screenW * 0.1667, screenH * 0.0546, tocolor(30,30,30,100), false)
   	end
    dxDrawText(napis2, (screenW * 0.4161) + 1, (screenH * 0.5685) + 1, (screenW * 0.5833) + 1, (screenH * 0.6231) + 1, tocolor(0, 0, 0, 255), 1, foncik, "center", "center", false, true, false, false, false)
    dxDrawText(napis2, screenW * 0.4161, screenH * 0.5685, screenW * 0.5833, screenH * 0.6231, tocolor(255, 255, 255, 255), 1, foncik, "center", "center", false, true, false, false, false)
end

addEventHandler("onClientClick", root, function(btn, state)
	if btn ~= "state" and state ~= "down" then return end
	if isMouseIn(screenW * 0.4167, screenH * 0.5685, screenW * 0.1667, screenH * 0.0546) and gui == true then
		acceptJob(localPlayer)
	elseif isMouseIn(screenW * 0.4167, screenH * 0.6324, screenW * 0.1667, screenH * 0.0546) and gui == true and getElementData(localPlayer, "praca") == ustawienia[3] then
		endpraca(localPlayer)
	end
end)

function acceptJob()
	if getElementData(localPlayer, "praca") == ustawienia[3] then
		local money = getElementData(localPlayer, "pracamoney")
        money = tonumber(money)
		if money < 1 then
			exports["crpg_powiadomienia"]:noti("Nie posiadasz wynagrodzenia do odebrania.")
		else
			exports["crpg_powiadomienia"]:noti("Odbierasz wynagrodzenie w wysokości "..string.format("%d", money).." PLN")
			setElementData(localPlayer, "pracamoney", 0)
			setElementData(localPlayer, "pieniadze", getElementData(localPlayer, "pieniadze") + string.format("%.2f", money))
			triggerEvent("onClientPlayerPayday", localPlayer, money)
			triggerServerEvent("onPlayerPayday", getRootElement(), localPlayer, money)
		end
	elseif not getElementData(localPlayer, "praca") or getElementData(localPlayer, "praca") == 0 then
		if ustawienia[5] and (getElementData(localPlayer, "prawko_"..ustawienia[5]) < 1) then
			exports["crpg_powiadomienia"]:noti("Nie posiadasz prawa jazdy kategorii "..ustawienia[5])
			return
		end
		exports["crpg_powiadomienia"]:noti("Zatrudniasz się jako "..ustawienia[4])
		setElementData(localPlayer, "praca", ustawienia[3])
		triggerEvent("onPlayerStartJob", localPlayer, ustawienia[3])
		triggerServerEvent("onPlayerStartJob", localPlayer, ustawienia[3])
	else
		exports["crpg_powiadomienia"]:noti("Posiadasz już inną pracę, aby się z niej zwolnij wpisz /resign")
	end
    removeEventHandler("onClientRender", root, guiPrace2)
    removeEventHandler("onClientRender", root, guiPrace)
	showCursor(false)
	gui = false
end
addEvent("acceptJob", true)
addEventHandler("acceptJob", getRootElement(), acceptJob)

function endpraca()
	triggerServerEvent("playerResign", localPlayer, localPlayer, true)
end
addEvent("jobResign", true)
addEventHandler("jobResign", getRootElement(), endpraca)