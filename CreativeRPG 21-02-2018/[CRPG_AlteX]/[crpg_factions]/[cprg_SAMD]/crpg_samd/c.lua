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

local czcionka = dxCreateFont(":crpg_fonty/f.ttf", 10)
if not czcionka then czcionka = "default-bold" end

function gui()
        roundedRectangle(screenW * 0.2813, screenH * 0.2567, screenW * 0.4569, screenH * 0.4733, tocolor(0, 0, 0, 180), false)
        roundedRectangle(screenW * 0.2813, screenH * 0.2167, screenW * 0.4569, screenH * 0.0511, tocolor(78, 174, 1, 253), false)
        dxDrawText("Przebieralnia", screenW * 0.2806, screenH * 0.2167, screenW * 0.7382, screenH * 0.2678, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawImage(screenW * 0.2882, screenH * 0.2789, screenW * 0.1132, screenH * 0.1856, "1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(screenW * 0.4562, screenH * 0.2789, screenW * 0.1132, screenH * 0.1856, "2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(screenW * 0.6181, screenH * 0.2789, screenW * 0.1132, screenH * 0.1856, "3.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(screenW * 0.2882, screenH * 0.4989, screenW * 0.1132, screenH * 0.1856, "4.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText("Kliknij na skin aby go założyć", screenW * 0.3236, screenH * 0.6867, screenW * 0.6799, screenH * 0.7300, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
end

okno = false

local marker = createMarker(1183.59, -1349.84, 714.27-1, "cylinder", 2, 65, 105, 225, 0)
createPickup ( 1183.59, -1349.84, 714.27, 3, 1275)

addEventHandler("onClientMarkerHit", marker, function(el, md)
         if not md or getElementType(el) ~= "player" then return end
         if el ~= localPlayer then return end
         if getElementData(localPlayer,"frakcja") == "SAMD" then
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
      triggerServerEvent("dajskinSAMD1", localPlayer)
      wyszedl()
    elseif isMouseIn(screenW * 0.4562, screenH * 0.2789, screenW * 0.1132, screenH * 0.1856) and okno == true then
      triggerServerEvent("dajskinSAMD2", localPlayer)
      wyszedl()
    elseif isMouseIn(screenW * 0.6181, screenH * 0.2789, screenW * 0.1132, screenH * 0.1856) and okno == true then
      triggerServerEvent("dajskinSAMD3", localPlayer)
      wyszedl()
    elseif isMouseIn(screenW * 0.2882, screenH * 0.4989, screenW * 0.1132, screenH * 0.1856) and okno == true then
      triggerServerEvent("dajskinSAMD4", localPlayer)
      wyszedl()
    end
  end
end)

-- BAGAŻNIK!!!!!!!!!!!!!!!

function gui2()
        roundedRectangle(screenW * 0.3826, screenH * 0.2544, screenW * 0.2229, screenH * 0.4689, tocolor(0, 0, 0, 180), false)
        roundedRectangle(screenW * 0.3826, screenH * 0.2133, screenW * 0.2229, screenH * 0.0522, tocolor(78, 174, 1, 255), false)
        if isMouseIn(screenW * 0.4035, screenH * 0.3033, screenW * 0.1764, screenH * 0.0500) then
        roundedRectangle(screenW * 0.4035, screenH * 0.3033, screenW * 0.1764, screenH * 0.0500, tocolor(78, 174, 1, 155), false)
        else
        roundedRectangle(screenW * 0.4035, screenH * 0.3033, screenW * 0.1764, screenH * 0.0500, tocolor(78, 174, 1, 255), false)
        end
        if isMouseIn(screenW * 0.4035, screenH * 0.3700, screenW * 0.1764, screenH * 0.0500) then
        roundedRectangle(screenW * 0.4035, screenH * 0.3700, screenW * 0.1764, screenH * 0.0500, tocolor(78, 174, 1, 155), false)
        else
        roundedRectangle(screenW * 0.4035, screenH * 0.3700, screenW * 0.1764, screenH * 0.0500, tocolor(78, 174, 1, 255), false)
        end
        if isMouseIn(screenW * 0.4035, screenH * 0.4378, screenW * 0.1764, screenH * 0.0500) then
        roundedRectangle(screenW * 0.4035, screenH * 0.4378, screenW * 0.1764, screenH * 0.0500, tocolor(78, 174, 1, 155), false)
        else
        roundedRectangle(screenW * 0.4035, screenH * 0.4378, screenW * 0.1764, screenH * 0.0500, tocolor(78, 174, 1, 255), false)
        end
        if isMouseIn(screenW * 0.4035, screenH * 0.6567, screenW * 0.1764, screenH * 0.0500) then
        roundedRectangle(screenW * 0.4035, screenH * 0.6567, screenW * 0.1764, screenH * 0.0500, tocolor(78, 174, 1, 155), false)
        else
        roundedRectangle(screenW * 0.4035, screenH * 0.6567, screenW * 0.1764, screenH * 0.0500, tocolor(78, 174, 1, 255), false)
        end
        dxDrawText("Ekwipunek", screenW * 0.3819, screenH * 0.2133, screenW * 0.6056, screenH * 0.2656, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        dxDrawText("Deska ort", screenW * 0.4035, screenH * 0.3033, screenW * 0.5799, screenH * 0.3533, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        dxDrawText("Piła", screenW * 0.4035, screenH * 0.3700, screenW * 0.5799, screenH * 0.4200, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        dxDrawText("Torba R1", screenW * 0.4035, screenH * 0.4378, screenW * 0.5799, screenH * 0.4878, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        dxDrawText("Zamknij", screenW * 0.4035, screenH * 0.6567, screenW * 0.5799, screenH * 0.7067, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
end

okno2 = false

addCommandHandler("eq", function()
if getElementData(localPlayer, "frakcja") == "SAMD" then
local veh = getPedOccupiedVehicle(localPlayer)
local x1, y1, z1 = getElementPosition ( veh )
marker2 = createMarker(x1,y1,z1-1.0, "cylinder", 1.0, 255, 0, 0, 255)
attachElements(marker2, veh, -1.5, 0, -1)
end
--
addEventHandler("onClientMarkerHit", marker2, function(el,md)
         if not md or getElementType(el) ~= "player" then return end
         if el ~= localPlayer then return end
         if getElementData(localPlayer,"frakcja") == "SAMD" then
         okno2 = true
         addEventHandler("onClientRender", root, gui2)
         showCursor(true)
         end
--
addEventHandler("onClientClick", root, function(btn, state)
if btn == "left" and state == "down" then
if isMouseIn(screenW * 0.4035, screenH * 0.3033, screenW * 0.1764, screenH * 0.0500) and okno2 == true then
triggerServerEvent("dajdeskaort",localPlayer)
elseif isMouseIn(screenW * 0.4035, screenH * 0.3700, screenW * 0.1764, screenH * 0.0500) and okno2 == true then
triggerServerEvent("dajPile",localPlayer)
elseif isMouseIn(screenW * 0.4035, screenH * 0.4378, screenW * 0.1764, screenH * 0.0500) and okno2 == true then
triggerServerEvent("torbaR1",localPlayer)
elseif isMouseIn(screenW * 0.4035, screenH * 0.6567, screenW * 0.1764, screenH * 0.0500) and okno2 == true then
zamknijokienko()
end
end
end)
end)
end)

function zamknijokienko()
removeEventHandler("onClientRender", root, gui2)
okno2 = false
showCursor(false)
end