--[[
  Autor: Asper
  Dla: .newMode
  Skrypt: Prawo jazdy
]]

setTimer(function()
  local p = localPlayer
  local pojazd = getPedOccupiedVehicle(p)
  if not pojazd then return end
  if getElementData(p, "zdaje") then
    local sx,sy,sz = getElementVelocity(pojazd)
    local km = math.ceil(((sx^2+sy^2+sz^2)^(0.5))*300)
      if km > 25 then
      setElementData(p, "zdaje", getElementData(p, "zdaje")-1)
    end
  end
  if getElementData(p, "zdaje") and getElementData(p, "zdaje") == 0 then 
    setElementData(p, "zdaje", false)   
    triggerServerEvent("zdalEgzamin", resourceRoot, p)
  end
end, 1000, 0)

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

local czcionka = dxCreateFont(":crpg_fonty/f.ttf", 14)
if not czcionka then czcionka = "default-bold" end
local czcionka2 = dxCreateFont(":crpg_fonty/f.ttf", 11)
if not czcionka2 then czcionka2 = "default-bold" end

function dxDrawButton(x, y, w, h, color)
  local color2 = tocolor(0,94,254)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x-0.4660164, y + h-1.6, w+1.5, 2, color2, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 3, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 3, color, false)
end

function gui()
        dxDrawButton(screenW * 0.3792, screenH * 0.2370, screenW * 0.2313, screenH * 0.3346, tocolor(15, 15, 15, 200))
        dxDrawRectangle(screenW * 0.3788, screenH * 0.2360, screenW * 0.2320, screenH * 0.0580, tocolor(0, 94, 254, 200), false)
        dxDrawText("Kurs prawa jazdy", (screenW * 0.3792) + 1, (screenH * 0.2357) + 1, (screenW * 0.6105) + 1, (screenH * 0.2943) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Kurs prawa jazdy", screenW * 0.3792, screenH * 0.2357, screenW * 0.6105, screenH * 0.2943, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
      	if mysz(screenW * 0.3909, screenH * 0.4948, screenW * 0.0996, screenH * 0.0599) then
        	dxDrawButton(screenW * 0.3909, screenH * 0.4948, screenW * 0.0996, screenH * 0.0599, tocolor(0, 94, 254, 175), false)
        else
        	dxDrawButton(screenW * 0.3909, screenH * 0.4948, screenW * 0.0996, screenH * 0.0599, tocolor(15, 15, 15, 175), false)
        end
       	if mysz(screenW * 0.5007, screenH * 0.4948, screenW * 0.0996, screenH * 0.0599) then
        	dxDrawButton(screenW * 0.5007, screenH * 0.4948, screenW * 0.0996, screenH * 0.0599, tocolor(0, 94, 254, 175), false)
        else
        	dxDrawButton(screenW * 0.5007, screenH * 0.4948, screenW * 0.0996, screenH * 0.0599, tocolor(15, 15, 15, 175), false)
        end      
        dxDrawText("Akceptuj", (screenW * 0.3909) + 1, (screenH * 0.4948) + 1, (screenW * 0.4905) + 1, (screenH * 0.5547) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Akceptuj", screenW * 0.3909, screenH * 0.4948, screenW * 0.4905, screenH * 0.5547, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Anuluj", (screenW * 0.5000) + 1, (screenH * 0.4948) + 1, (screenW * 0.5996) + 1, (screenH * 0.5547) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Anuluj", screenW * 0.5000, screenH * 0.4948, screenW * 0.5996, screenH * 0.5547, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
end

local napisy = guiCreateComboBox(0.39, 0.30, 0.21, 0.16, "Wybierz kategorie", true)    
guiSetVisible(napisy, false)

addEvent("oknoEgz", true)
addEventHandler("oknoEgz", root, function()
  if guiGetVisible(napisy) == true then
    guiSetVisible(napisy, false)
    showCursor(false)
    removeEventHandler("onClientPreRender", root, gui)
  else
  	addEventHandler("onClientPreRender", root, gui)
    guiSetVisible(napisy, true)
    showCursor(true, false)
    guiComboBoxClear(napisy)
    local info1 = "Kategoria A"
    local info2 = "Kategoria B"
    local info3 = "Kategoria C"
    guiComboBoxAddItem(napisy, info1)
    guiComboBoxAddItem(napisy, info2)
    guiComboBoxAddItem(napisy, info3)
  end
end)

addEvent("oknoEgzC", true)
addEventHandler("oknoEgzC", root, function()
  if guiGetVisible(napisy) == true then
    guiSetVisible(napisy, false)
    showCursor(false)
    removeEventHandler("onClientPreRender", root, gui)
  end
end)

addEventHandler("onClientClick", root, function(b, s)
	if b ~= "state" and s ~= "down" then return end
	if mysz(screenW * 0.5007, screenH * 0.4948, screenW * 0.0996, screenH * 0.0599) and guiGetVisible(napisy) == true then
		guiSetVisible(napisy, false)
   	 	showCursor(false)
   	 	removeEventHandler("onClientPreRender", root, gui)
	elseif mysz(screenW * 0.3909, screenH * 0.4948, screenW * 0.0996, screenH * 0.0599) and guiGetVisible(napisy) == true then
      local i = guiComboBoxGetSelected(napisy)
      if not i then return end
      removeEventHandler("onClientPreRender", root, gui)
      local id = guiComboBoxGetItemText(napisy, i)
      triggerServerEvent("rozpocznijKurs", resourceRoot, localPlayer, id)
      guiSetVisible(napisy, false)
      showCursor(false)
	end
end)

addEventHandler("onClientRender", root, function()
    if getElementData(localPlayer, "zdaje") then
        if not isPedInVehicle(localPlayer) then return end
        dxDrawButton(screenW * 0.4056, screenH * 0.0130, screenW * 0.1903, screenH * 0.0560, tocolor(15, 15, 15, 175), false)
        dxDrawText("Do zdania egzaminu pozostało:\n "..getElementData(localPlayer, "zdaje").." minut", (screenW * 0.4048) + 1, (screenH * 0.0104) + 1, (screenW * 0.5959) + 1, (screenH * 0.0690) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka2, "center", "center", false, false, false, false, false)
        dxDrawText("Do zdania egzaminu pozostało:\n "..getElementData(localPlayer, "zdaje").." minut", screenW * 0.4048, screenH * 0.0104, screenW * 0.5959, screenH * 0.0690, tocolor(255, 255, 255, 255), 1.00, czcionka2, "center", "center", false, false, false, false, false)
    end
end)