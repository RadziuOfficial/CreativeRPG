--[[
Autor: Malentas
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

function roundedRectangle(x, y, w, h, color)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x + 2, y + h, w - 4, 1, color, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 4, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 4, color, false)
end

local czcionka = dxCreateFont(":nm-login/cz.ttf", 10)
if not czcionka then czcionka = "default-bold" end

function gui()
        roundedRectangle(screenW * 0.2813, screenH * 0.2567, screenW * 0.4569, screenH * 0.4733, tocolor(0, 0, 0, 180), false)
        roundedRectangle(screenW * 0.2813, screenH * 0.2167, screenW * 0.4569, screenH * 0.0511, tocolor(78, 174, 1, 253), false)
        dxDrawText("Przebieralnia", screenW * 0.2806, screenH * 0.2167, screenW * 0.7382, screenH * 0.2678, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawImage(screenW * 0.2882, screenH * 0.2789, screenW * 0.1132, screenH * 0.1856, "1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(screenW * 0.4562, screenH * 0.2789, screenW * 0.1132, screenH * 0.1856, "2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(screenW * 0.6181, screenH * 0.2789, screenW * 0.1132, screenH * 0.1856, "3.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(screenW * 0.2882, screenH * 0.4989, screenW * 0.1132, screenH * 0.1856, "4.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(screenW * 0.4562, screenH * 0.4989, screenW * 0.1132, screenH * 0.1856, "5.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(screenW * 0.6181, screenH * 0.4989, screenW * 0.1132, screenH * 0.1856, "6.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText("Kliknij na skin aby go założyć", screenW * 0.3236, screenH * 0.6867, screenW * 0.6799, screenH * 0.7300, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
end

okno = false

local marker = createMarker(-2441.45, 3768.62, 300.57-1, "cylinder", 2, 65, 105, 225, 0)
createPickup ( -2441.45, 3768.62, 300.57, 3, 1275)

addEventHandler("onClientMarkerHit", marker, function(el, md)
         if not md or getElementType(el) ~= "player" then return end
         if el ~= localPlayer then return end
         if getElementData(localPlayer,"frakcja") == "SAPD" then
         okno = true
         addEventHandler("onClientRender", root, gui)
         showCursor(true)
end
end)

function wyszedl()
removeEventHandler("onClientRender", root, gui)
okno = false
showCursor(false)
end

addEventHandler("onClientClick", root, function(btn, state)
  if btn == "left" and state == "down" then
    if isMouseIn(screenW * 0.2882, screenH * 0.2789, screenW * 0.1132, screenH * 0.1856) and okno == true then
      triggerServerEvent("dajskinSAPD1", localPlayer)
      wyszedl()
    elseif isMouseIn(screenW * 0.4562, screenH * 0.2789, screenW * 0.1132, screenH * 0.1856) and okno == true then
      triggerServerEvent("dajskinSAPD2", localPlayer)
      wyszedl()
    elseif isMouseIn(screenW * 0.6181, screenH * 0.2789, screenW * 0.1132, screenH * 0.1856) and okno == true then
      triggerServerEvent("dajskinSAPD3", localPlayer)
      wyszedl()
    elseif isMouseIn(screenW * 0.2882, screenH * 0.4989, screenW * 0.1132, screenH * 0.1856) and okno == true then
      triggerServerEvent("dajskinSAPD4", localPlayer)
      wyszedl()
    elseif isMouseIn(screenW * 0.4562, screenH * 0.4989, screenW * 0.1132, screenH * 0.1856) and okno == true then
      triggerServerEvent("dajskinSAPD5", localPlayer)
      wyszedl()
    elseif isMouseIn(screenW * 0.6181, screenH * 0.4989, screenW * 0.1132, screenH * 0.1856) and okno == true then
      triggerServerEvent("dajskinSAPD6", localPlayer)
      wyszedl()
    end
  end
end)

local markerx = createMarker(1545.34, -1627.48, 13.38-1,"cylinder",8,0,0,255,0)
function naprawa()
if getElementData(localPlayer,"frakcja") then
fixVehicle(getPedOccupiedVehicle(localPlayer))
end
end
addEventHandler("onClientMarkerHit",markerx, naprawa)