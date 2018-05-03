--[[
	Autor: Asper
	Dla servera: .newMode
	Skrypt: Duty administracji
]]

local screenW, screenH = guiGetScreenSize()
local font = dxCreateFont(":crpg_fonty/f.ttf", 11) or "default-bold"

local text = {}

function roundedRectangle(x, y, w, h, color)
  exports["nm-blur"]:dxDrawBluredRectangle(x, y, w, h, tocolor(255,255,255), false)
  exports["nm-blur"]:dxDrawBluredRectangle(x + 2, y - 1, w - 4, 1, tocolor(255,255,255), false)
  exports["nm-blur"]:dxDrawBluredRectangle(x + 2, y + h, w - 4, 1, tocolor(255,255,255), false)
  exports["nm-blur"]:dxDrawBluredRectangle(x - 1, y + 2, 1, h - 4, tocolor(255,255,255), false)
  exports["nm-blur"]:dxDrawBluredRectangle(x + w, y + 2, 1, h - 4, tocolor(255,255,255), false)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x + 2, y + h, w - 4, 1, color, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 4, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 4, color, false)
end

function shadowText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x+1,y+1,w+1,h+1,tocolor(0,0,0),size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
end

addEventHandler("onClientRender", root, function()
	if getElementData(localPlayer, "duty") and not getElementData(localPlayer, "ucho") then
		local r_text = ""
		for i,v in ipairs(text) do
			r_text = r_text.."\n"..v[1]
		end
		shadowText("Lista reportów\n"..r_text, screenW * 0.7100, screenH * 0.3500, screenW * 0.9861, screenH * 0.6875, tocolor(255, 255, 255), 1.00, font, "right", "top", false, true, false, false, false)
	end
end)

addEvent("dRaps", true)
addEventHandler("dRaps", root, function(tekst, gracz)
  	if #text > 10 then
		table.remove(text, 1)
  	end
   	table.insert(text, {tekst, gracz})
end)

addEvent("uRaps", true)
addEventHandler("uRaps", root, function(gracz)
	for i=#text,1,-1 do
		if text[i][2] == tonumber(gracz) then
	  		table.remove(text, i)
		end
	end
end)

local ltext = {}

addEventHandler("onClientRender", root, function()
	if getElementData(localPlayer, "duty") and not getElementData(localPlayer, "ucho") then
		local l_text = ""
		for i,v in ipairs(ltext) do
			l_text = l_text.."\n"..v
		end
		shadowText("Lista logów\n"..l_text, screenW * 0.0100, screenH * 0.3500, screenW * 0.9861, screenH * 0.6875, tocolor(255, 255, 255), 1.00, font, "left", "top", false, true, false, false, false)
	end
end)

addEvent("dLogi", true)
addEventHandler("dLogi", root, function(tekst)
  	if #ltext > 10 then
		table.remove(ltext, 1)
  	end
   	table.insert(ltext, tekst)
end)

addCommandHandler("ucho", function()
	local duty = getElementData(localPlayer, "duty")
	if duty then
		setElementData(localPlayer, "ucho", not getElementData(localPlayer, "ucho"))
	end
end)

-- banicje etc

local okno = guiCreateWindow(0.00, 0.00, 1.00, 1.00, "Zostałeś zbanowany na tym serwerze!", true)
guiWindowSetMovable(okno, false)
guiSetAlpha(okno, 1.00)
local napisy = guiCreateLabel(0.32, 0.38, 0.36, 0.24, "Zostałeś zbanowany na tym serwerze!\n\nBan został nałożony na serial:\nBan został nałożony na IP:\nBan został nałożony na nick:\nBan jest aktywny do:\nNick admina banującego:\n\nOd kary możesz zaapelować na forum http://sunnyrpg.pe.hu/", true, okno)
guiLabelSetHorizontalAlign(napisy, "center", false)
guiLabelSetVerticalAlign(napisy, "center")
local przycisk = guiCreateButton(0.33, 0.65, 0.34, 0.15, "Wyjdź z serwera", true, okno) 
guiSetVisible(okno, false)

addEvent("oknoZbanowany", true)
addEventHandler("oknoZbanowany", root, function(g, i, s, d, a, n)
	guiSetVisible(okno, true)
	guiSetText(napisy, "Zostałeś zbanowany na tym serwerze!\n\nBan został nałożony na serial: "..s.."\nBan został nałożony na IP: "..i.."\nBan został nałożony na nick: "..n.."\nBan jest aktywny do: "..d.."\nNick admina banującego: "..a.."\n\nOd kary możesz zaapelować na forum http://sunnyrpg.pe.hu/")
end)

local wFont = dxCreateFont(":crpg_fonty/f.ttf",10) or "default-bold"
local wFont2 = dxCreateFont(":crpg_fonty/f.ttf",9) or "default-bold"

local text = false

local screenW, screenH = guiGetScreenSize()

function gui()
		roundedRectangle(screenW * 0.2430, screenH * 0.9219, screenW * 0.2943, screenH * 0.0651, tocolor(0, 0, 0, 180))
        dxDrawText(text, (screenW * 0.2438) + 1, (screenH * 0.9193) + 1, (screenW * 0.5373) + 1, (screenH * 0.9870) + 1, tocolor(0, 0, 0, 255), 1.00, wFont2, "center", "center", false, true, false, false, false)
        dxDrawText(text, screenW * 0.2438, screenH * 0.9193, screenW * 0.5373, screenH * 0.9870, tocolor(255, 0, 0, 255), 1.00, wFont2, "center", "center", false, true, false, false, false)
end

addEvent("notiAdmin", true)
addEventHandler("notiAdmin", root, function(t)
	addEventHandler("onClientPreRender", root, gui)
	text = t
	setTimer(function()
		removeEventHandler("onClientPreRender", root, gui)
		text = false
	end, 7500, 1)
end)

addEventHandler("onClientGUIClick", przycisk, function()
	triggerServerEvent("banWyrzuc", localPlayer)
end)

local wtext = false
local tick = getTickCount()

function gui2()
		local r,g,b = interpolateBetween(0,0,0,255,0,0,(getTickCount()-tick)/2500,"SineCurve")
		roundedRectangle(0,0,screenW,screenH, tocolor(r,g,b, 180))
        dxDrawText("Otrzymałeś ostrzeżenie od "..wtext.kto, (screenW * 0.2965) + 1, (screenH * 0.2057) + 1, (screenW * 0.7035) + 1, (screenH * 0.2721) + 1, tocolor(0, 0, 0, 255), 1.00, wFont, "center", "center", false, false, false, false, false)
        dxDrawText("Otrzymałeś ostrzeżenie od "..wtext.kto, screenW * 0.2965, screenH * 0.2057, screenW * 0.7035, screenH * 0.2721, tocolor(255, 255, 255, 255), 1.00, wFont, "center", "center", false, false, false, false, false)
        dxDrawText("Powód: "..wtext.powod.."\n\n\n\nNie stosowanie się do ostrzeżenia może skutkować kickiem lub banem.", (screenW * 0.3199) + 1, (screenH * 0.3333) + 1, (screenW * 0.6852) + 1, (screenH * 0.7174) + 1, tocolor(0,0,0), 1.00, wFont, "center", "center", false, false, false, false, false)
        dxDrawText("Powód: "..wtext.powod.."\n\n\n\nNie stosowanie się do ostrzeżenia może skutkować kickiem lub banem.", screenW * 0.3199, screenH * 0.3333, screenW * 0.6852, screenH * 0.7174, tocolor(255, 255, 255), 1.00, wFont, "center", "center", false, false, false, false, false)
end

addEvent("warnPlayer", true)
addEventHandler("warnPlayer", root, function(t)
	addEventHandler("onClientPreRender", root, gui2)
	wtext = t
	setTimer(function()
		tick = getTickCount()
		removeEventHandler("onClientPreRender", root, gui2)
		wtext = false
	end, 7500, 1)
end)

addCommandHandler("camera", function()
local x, y, z, lx, ly, lz = getCameraMatrix()
outputChatBox(x..", "..y..", "..z..", "..lx..", "..ly..", "..lz)
end)

local sx, sy = guiGetScreenSize()
local screenW, screenH = guiGetScreenSize()

addCommandHandler("devmode", function (cmd)
   if not getElementData(localPlayer, "duty") then return end
   setDevelopmentMode(true)
end)

--[[function putPlayerInPosition(timeslice)
    local cx,cy,cz,ctx,cty,ctz = getCameraMatrix()
    ctx,cty = ctx-cx,cty-cy
    timeslice = timeslice*0.1
    local tx, ty, tz = getWorldFromScreenPosition(sx / 2, sy / 2, 10)
    if isChatBoxInputActive() or isConsoleActive() or isMainMenuActive () or isTransferBoxActive () then return end
    if getKeyState("lctrl") then timeslice = timeslice*4 end
    if getKeyState("lalt") then timeslice = timeslice*0.25 end
    local mult = timeslice/math.sqrt(ctx*ctx+cty*cty)
    ctx,cty = ctx*mult,cty*mult
    if getKeyState("2") then abx,aby = abx+ctx,aby+cty end
    if getKeyState("w") then abx,aby = abx+ctx,aby+cty end
    if getKeyState("s") then abx,aby = abx-ctx,aby-cty end
    if getKeyState("a") then  abx,aby = abx-cty,aby+ctx end
    if getKeyState("d") then abx,aby = abx+cty,aby-ctx end
    if getKeyState("space") then  abz = abz+timeslice end
    if getKeyState("lshift") then   abz = abz-timeslice end
    local xxd,yxd = 100,200
    dxDrawText("Pozycja gracza:\nX: "..abx.."\nY: "..aby.."\nZ: "..abz, screenW * 0.7430, screenH * 0.6029, screenW * 0.9788, screenH * 0.7435, tocolor(255, 255, 255, 255), 1.00, font, "left", "top", false, false, false, false, false)


    if isPedInVehicle ( getLocalPlayer( ) ) then
    local vehicle = getPedOccupiedVehicle( getLocalPlayer( ) )
    local angle = getPedCameraRotation(getLocalPlayer ( ))
    setElementPosition(vehicle,abx,aby,abz)
    setElementRotation(vehicle,0,0,-angle)
    else
    local angle = getPedCameraRotation(getLocalPlayer ( ))
    setElementRotation(getLocalPlayer ( ),0,0,angle)
    setElementPosition(getLocalPlayer ( ),abx,aby,abz)
    end
end

function toggleAirBrakec()
	--if getElementData(localPlayer, "duty") then
    if not getElementData(localPlayer, "duty") then return end
	toggleAirBrake()
end


function toggleAirBrake()
    air_brake = not air_brake or nil
    if air_brake then

        if isPedInVehicle ( getLocalPlayer( ) ) then
        local vehicle = getPedOccupiedVehicle( getLocalPlayer( ) )
        abx,aby,abz = getElementPosition(vehicle)
        Speed,AlingSpeedX,AlingSpeedY = 0,1,1
        OldX,OldY,OldZ = 0
        setElementCollisionsEnabled ( vehicle, false )
        setElementFrozen(vehicle,true)
        setElementAlpha(getLocalPlayer(),0)
        addEventHandler("onClientPreRender",root,putPlayerInPosition)
    else
        abx,aby,abz = getElementPosition(localPlayer)
        Speed,AlingSpeedX,AlingSpeedY = 0,1,1
        OldX,OldY,OldZ = 0
        setElementCollisionsEnabled ( localPlayer, false )
        addEventHandler("onClientPreRender",root,putPlayerInPosition)
    end


    else
    if isPedInVehicle ( getLocalPlayer( ) ) then
        local vehicle = getPedOccupiedVehicle( getLocalPlayer( ) )
        abx,aby,abz = nil
        setElementFrozen(vehicle,false)
        setElementCollisionsEnabled ( vehicle, true )
        setElementAlpha(getLocalPlayer(),255)
        removeEventHandler("onClientPreRender",root,putPlayerInPosition)
        else
        abx,aby,abz = nil
        setElementCollisionsEnabled ( localPlayer, true )
        removeEventHandler("onClientPreRender",root,putPlayerInPosition)
        end
    end
end
bindKey("0","down",toggleAirBrakec)]]