--[[
ZAKAZ UŻYWANIA PONIŻSZEGO KODU
@WSZELKIE PRAWA ZASTRZEŻONE, CREATIVERPG.
AUTHOR:
- RAD3K @2018
- ALTEX @2018
ZAKAZ UŻYWANIA BEZ ZGODY AUTORA!
]]--

local screenW, screenH = guiGetScreenSize()
local sx, sy = guiGetScreenSize()

local font = dxCreateFont(":crpg_fonty/f.ttf", 10)
if not font then
	font = "default"
end

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

function gui()
        dxDrawBorderedText("Cena naprawy pojazdu wyniesie "..getElementData(localPlayer, "cena:naprawy").." PLN.\nAby naprawi pojazd kliknij przycisk 'Napraw'.", screenW * 0.3397, screenH * 0.3099, screenW * 0.6596, screenH * 0.5378, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, true, false, false, false)	
	    exports["buttons"]:createCustomButton("NAPRAW", screenW * 0.4250, screenH * 0.4475, screenW * 0.1500, screenH * 0.0515)		
end

addEventHandler("onClientMarkerHit", resourceRoot, function(el)
if el~=localPlayer then return end
local cuboid = getElementData(source, "cuboid")
if getPedOccupiedVehicle(el) then return end
if not cuboid then return end
local vehicles = getElementsWithinColShape(cuboid, "vehicle")
if #vehicles < 1 then
exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Na stanowisku naprawczym nie znajduje się pojazd!", el)	
return
end
if #vehicles > 1 then
exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Na stanowisku naprawczym znajduje się zbyt duża ilość pojazdów!", el)	
return
end
isVehicles = vehicles[1]
addEventHandler("onClientRender", getRootElement(), gui)
showCursor(true, false)
local zycie = getElementHealth(isVehicles)
if zycie > 30 and zycie <= 250 then
ceny = 500
elseif zycie > 250 and zycie <= 500 then
ceny = 250
elseif zycie > 500 and zycie <= 750 then
ceny = 150
elseif zycie > 750 and zycie <= 850 then
ceny = 100
elseif zycie > 850 and zycie <= 1000 then
ceny = 50
end
setElementData(el, "cena:naprawy", ceny)
end)

addEventHandler("onClientMarkerLeave", resourceRoot, function(el)
if el~=localPlayer then return end
if getElementData(localPlayer, "cena:naprawy") then
removeEventHandler("onClientRender", getRootElement(), gui)
showCursor(false)
setElementData(el, "cena:naprawy", false)
end
end)

function naprawa()
woz = isVehicles
triggerServerEvent("naprawa", localPlayer, woz)
removeEventHandler("onClientRender", getRootElement(), gui)
showCursor(false)
end

addEventHandler("onClientClick", root, function(btn, state)
if btn == "left" and state == "down" then
if isMouseIn(screenW * 0.4250, screenH * 0.4475, screenW * 0.1500, screenH * 0.0515) and getElementData(localPlayer, "cena:naprawy") then
naprawa(localPlayer)
end
end
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