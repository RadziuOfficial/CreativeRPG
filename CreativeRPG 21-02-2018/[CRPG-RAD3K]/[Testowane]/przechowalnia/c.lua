--[[
Autor: Asperek
]]

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

function dxDrawButton(x, y, w, h, color)
  local color2 = tocolor(0,94,254)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x-0.4660164, y + h-1.6, w+1.5, 2, color2, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 3, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 3, color, false)
end

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

local wybieralka = guiCreateGridList(0.37, 0.25, 0.27, 0.37, true)   
guiGridListAddColumn(wybieralka, "ID", 0.2) 
guiGridListAddColumn(wybieralka, "Model", 0.3) 
guiGridListAddColumn(wybieralka, "Organizacja", 0.4) 
guiSetVisible(wybieralka, false)

local f = dxCreateFont(":crpg_fonty/f.ttf", 12) or "default-bold"

function gui()
  dxDrawButton(screenW * 0.3551, screenH * 0.1758, screenW * 0.2899, screenH * 0.6484, tocolor(15, 15, 15, 200), false)
  dxDrawRectangle(screenW * 0.3551, screenH * 0.1758, screenW * 0.2899, screenH * 0.0612, tocolor(0, 94, 254, 200), false)
  dxDrawBorderedText("Odbiór pojazdów", screenW * 0.3551, screenH * 0.1758, screenW * 0.6442, screenH * 0.2370, tocolor(255, 255, 255, 255), 1.00, f, "center", "center", false, false, false, false, false)
  if mysz(screenW * 0.3799, screenH * 0.6510, screenW * 0.2416, screenH * 0.0638) then
    dxDrawButton(screenW * 0.3799, screenH * 0.6510, screenW * 0.2416, screenH * 0.0638, tocolor(0, 94, 254, 175), false)
  else
    dxDrawButton(screenW * 0.3799, screenH * 0.6510, screenW * 0.2416, screenH * 0.0638, tocolor(15, 15, 15, 175), false)
  end
  if mysz(screenW * 0.3799, screenH * 0.7279, screenW * 0.2416, screenH * 0.0638) then
    dxDrawButton(screenW * 0.3799, screenH * 0.7279, screenW * 0.2416, screenH * 0.0638, tocolor(0, 94, 254, 175), false)
  else
    dxDrawButton(screenW * 0.3799, screenH * 0.7279, screenW * 0.2416, screenH * 0.0638, tocolor(15, 15, 15, 175), false)
  end
  dxDrawBorderedText("Odbierz pojazd", screenW * 0.3799, screenH * 0.6510, screenW * 0.6215, screenH * 0.7148, tocolor(255, 255, 255, 255), 1.00, f, "center", "center", false, false, false, false, false)
  dxDrawBorderedText("Zamknij panel", screenW * 0.3799, screenH * 0.7279, screenW * 0.6215, screenH * 0.7917, tocolor(255, 255, 255, 255), 1.00, f, "center", "center", false, false, false, false, false)
end

guiSetVisible(wybieralka, false)

addEvent("pojazdy", true)
addEventHandler("pojazdy", root, function(spr)
  if guiGetVisible(wybieralka) == true then
    removeEventHandler("onClientRender", root, gui)
    showCursor(false)
    panel = false
    guiSetVisible(wybieralka, false)
  else
    guiSetVisible(wybieralka, true)
    showCursor(true, false)
    addEventHandler("onClientRender", root, gui)
    guiGridListClear(wybieralka)
    for i, v in pairs(spr) do
		if v["organizacja"]:len() < 2 then
			v["organizacja"] = "brak"
		end
		local row = guiGridListAddRow(wybieralka)
		guiGridListSetItemText(wybieralka, row, 1, v["id"], false, false)
		guiGridListSetItemText(wybieralka, row, 2, getVehicleNameFromModel(v["model"]), false, false)
		guiGridListSetItemText(wybieralka, row, 3, v["organizacja"], false, false)
	end
  end
end)

addEventHandler("onClientClick", root, function(b, s)
  if b ~= "state" and s ~= "down" then return end
  if mysz(screenW * 0.3799, screenH * 0.6510, screenW * 0.2416, screenH * 0.0638) and guiGetVisible(wybieralka) == true then
    local i = guiGridListGetSelectedItem(wybieralka)
    if not i then return end
    local id = guiGridListGetItemText(wybieralka, i, 1)
    triggerServerEvent("wyjmij", resourceRoot, localPlayer, id)
	guiGridListRemoveRow(wybieralka, i)
    guiSetVisible(wybieralka, false)
    showCursor(false)
    removeEventHandler("onClientRender", root, gui)
  elseif mysz(screenW * 0.3799, screenH * 0.7279, screenW * 0.2416, screenH * 0.0638) and guiGetVisible(wybieralka) == true then
    guiSetVisible(wybieralka, false)
    showCursor(false)
    removeEventHandler("onClientRender", root, gui)
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

addEvent("oknoPrzecho", true)
addEventHandler("oknoPrzecho", root, function(hit)
  removeEventHandler("onClientRender", root, gui)
  showCursor(false)
  guiSetVisible(wybieralka, false)
end)