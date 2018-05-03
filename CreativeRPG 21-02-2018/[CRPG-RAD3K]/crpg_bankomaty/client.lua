--[[
Autor: Asper
Skrypt: Bankomaty
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

function roundedRectangle(x, y, w, h, color)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x + 2, y + h, w - 4, 1, color, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 4, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 4, color, false)
end

function dxDrawButton(x, y, w, h, color)
  local color2 = tocolor(0,94,254)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x-0.4660164, y + h-1.6, w+1.5, 2, color2, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 3, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 3, color, false)
end

local f = dxCreateFont(":crpg_fonty/f.ttf", 15)
local showed = false

function gui()
  local hajs = string.format("%d", getElementData(localPlayer, "bkasa"))
        roundedRectangle(screenW * 0.3625, screenH * 0.3167, screenW * 0.2750, screenH * 0.3676, tocolor(15,15,15,222), false)
        roundedRectangle(screenW * 0.3625, screenH * 0.3167, screenW * 0.2750, screenH * 0.0500, tocolor(0,94,254,125), false)
        dxDrawText("Bankomat", (screenW * 0.3620) + 1, (screenH * 0.3157) + 1, (screenW * 0.6375) + 1, (screenH * 0.3667) + 1, tocolor(0, 0, 0, 255), 1.00, f, "center", "center", false, false, false, false, false)
        dxDrawText("Bankomat", screenW * 0.3620, screenH * 0.3157, screenW * 0.6375, screenH * 0.3667, tocolor(255, 255, 255, 255), 1.00, f, "center", "center", false, false, false, false, false)
        if mysz(screenW * 0.3781, screenH * 0.6102, screenW * 0.1016, screenH * 0.0528) then
        	dxDrawButton(screenW * 0.3781, screenH * 0.6102, screenW * 0.1016, screenH * 0.0528, tocolor(0,94,254,125), false)
        else
        	dxDrawButton(screenW * 0.3781, screenH * 0.6102, screenW * 0.1016, screenH * 0.0528, tocolor(30,30,30,225), false)
        end
        if mysz(screenW * 0.5182, screenH * 0.6102, screenW * 0.1016, screenH * 0.0528) then
        	dxDrawButton(screenW * 0.5182, screenH * 0.6102, screenW * 0.1016, screenH * 0.0528, tocolor(0,94,254,125), false)
        else
        	dxDrawButton(screenW * 0.5182, screenH * 0.6102, screenW * 0.1016, screenH * 0.0528, tocolor(30,30,30,225), false)
        end
        dxDrawText("Wpłać", (screenW * 0.3781) + 1, (screenH * 0.6102) + 1, (screenW * 0.4797) + 1, (screenH * 0.6630) + 1, tocolor(0, 0, 0, 255), 1.00, f, "center", "center", false, false, false, false, false)
        dxDrawText("Wpłać", screenW * 0.3781, screenH * 0.6102, screenW * 0.4797, screenH * 0.6630, tocolor(255, 255, 255, 255), 1.00, f, "center", "center", false, false, false, false, false)
        dxDrawText("Wypłać", (screenW * 0.5182) + 1, (screenH * 0.6102) + 1, (screenW * 0.6198) + 1, (screenH * 0.6630) + 1, tocolor(0, 0, 0, 255), 1.00, f, "center", "center", false, false, false, false, false)
        dxDrawText("Wypłać", screenW * 0.5182, screenH * 0.6102, screenW * 0.6198, screenH * 0.6630, tocolor(255, 255, 255, 255), 1.00, f, "center", "center", false, false, false, false, false)
        dxDrawText("Saldo konta: "..hajs.." PLN", (screenW * 0.3979) + 1, (screenH * 0.3731) + 1, (screenW * 0.6062) + 1, (screenH * 0.4176) + 1, tocolor(0, 0, 0, 255), 1.00, f, "center", "center", false, false, false, false, false)
        dxDrawText("Saldo konta: "..hajs.." PLN", screenW * 0.3979, screenH * 0.3731, screenW * 0.6062, screenH * 0.4176, tocolor(255, 255, 255, 255), 1.00, f, "center", "center", false, false, false, false, false)
end

addEventHandler("onClientClick", root, function(b, s)
  if b ~= "state" and s ~= "down" then return end
  if mysz(screenW * 0.3781, screenH * 0.6102, screenW * 0.1016, screenH * 0.0528) and showed == true then
    wplac()
  elseif mysz(screenW * 0.5182, screenH * 0.6102, screenW * 0.1016, screenH * 0.0528) and showed == true then
    wyplac()
  end
end)

function wplac()
  local ilosc = exports["dxedits"]:editbox_text("wBank")
  if ilosc:len() < 1 then return end
  ilosc = math.abs(ilosc)
  ilosc = tonumber(ilosc)
  triggerServerEvent("oBank", localPlayer, "zapisz", ilosc, "wp")
end

function wyplac()
  local ilosc = exports["dxedits"]:editbox_text("wBank2")
  if ilosc:len() < 1 then return end
  ilosc = math.abs(ilosc)
  ilosc = tonumber(ilosc)
  triggerServerEvent("oBank", localPlayer, "zapisz", ilosc, "wy")
end

addEvent("bOkno", true)
addEventHandler("bOkno", root, function()
  addEventHandler("onClientPreRender", root, gui)

  exports["dxedits"]:editbox_create("", "Kwota wpłaty...", screenW * 0.4256, screenH * 0.4269, screenW * 0.5880, screenH * 0.4852,  screenW * 0.4156, screenH * 0.4287, screenW * 0.1724, screenH * 0.0565, "wBank")
  exports["dxedits"]:editbox_create("", "Kwota wypłaty..", screenW * 0.4256, screenH * 0.4926, screenW * 0.5880, screenH * 0.5509,  screenW * 0.4156, screenH * 0.4944, screenW * 0.1724, screenH * 0.0565, "wBank2")

  triggerServerEvent("oBank", localPlayer, "zaladuj")
  showCursor(true, false)
  showed = true
end)

addEvent("vOkno", true)
addEventHandler("vOkno", root, function()
  removeEventHandler("onClientPreRender", root, gui)
  showCursor(false)
  exports["dxedits"]:editbox_destroy("wBank")
  exports["dxedits"]:editbox_destroy("wBank2")
  showed = false
end)
