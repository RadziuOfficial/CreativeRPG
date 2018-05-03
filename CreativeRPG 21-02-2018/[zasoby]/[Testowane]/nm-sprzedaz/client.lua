--[[
  Autor: Asper
  Dla: .newMode
  Skrypt: Sprzedaz pojazdow
]]

local window = guiCreateWindow(0.24, 0.21, 0.52, 0.58, "Sprzedaż pojazdów", true)
local lista = guiCreateGridList(0.01, 0.05, 0.72, 0.92, true, window)
local sprzedaj = guiCreateButton(0.75, 0.67, 0.23, 0.13, "Sprzedaj", true, window)
local zamknij = guiCreateButton(0.75, 0.83, 0.23, 0.13, "Zamknij", true, window)
local cena = guiCreateEdit(0.75, 0.54, 0.23, 0.11, "", true, window)
local ncena = guiCreateLabel(0.75, 0.45, 0.23, 0.09, "Cena", true, window)
guiLabelSetHorizontalAlign(ncena, "center", false)
guiLabelSetVerticalAlign(ncena, "center")
local gracz = guiCreateEdit(0.75, 0.31, 0.23, 0.11, "", true, window)
local nnick = guiCreateLabel(0.75, 0.23, 0.23, 0.09, "Nick osoby", true, window)
guiLabelSetHorizontalAlign(nnick, "center", false)
guiLabelSetVerticalAlign(nnick, "center")
local ninfo = guiCreateLabel(0.76, 0.05, 0.23, 0.15, "(( Administracja servera nie\nponosi winy za oszukania\nprzy wymianie pojazdów ))", true, window)
guiLabelSetHorizontalAlign(ninfo, "center", false)
guiLabelSetVerticalAlign(ninfo, "center")
guiSetVisible(window, false)
guiGridListAddColumn(lista, "ID", 0.2)
guiGridListAddColumn(lista, "Model", 0.2)


addEventHandler("onClientGUIClick", sprzedaj, function()
  local wybral = guiGridListGetSelectedItem(lista) or 0
  local id = guiGridListGetItemText(lista, wybral, 1)
  local pp = guiGridListGetItemText(lista, wybral, 2)
  if wybral < 0 then return end
  local c = guiGetText(cena)
  local n = guiGetText(gracz)
  if c:len() < 2 then
    outputChatBox("Podana cena musi mieć minimum 2 znaki.")
    return
  end
  if n:len() < 3 then
    outputChatBox("Podany nick musi mieć minimum 3 znaki.")
    return
  end
  triggerServerEvent("sprzedaz", resourceRoot, localPlayer, c, n, pp, id)
end)

addEventHandler("onClientGUIClick", zamknij, function()
  showCursor(false)
  guiSetVisible(window, false)
end)

addEvent("lista", true)
addEventHandler("lista", root, function(s)
  guiSetVisible(window, true)
  showCursor(true, false)
  guiGridListClear(lista)
  if not s then return end
  for _, p in pairs(s) do
    local spr = guiGridListAddRow(lista)
    guiGridListSetItemText(lista, spr, 1, p["id"], false, false)
    guiGridListSetItemText(lista, spr, 2, getVehicleNameFromModel(p["model"]), false, false)
  end
end)

addEvent("oknoSell", true)
addEventHandler("oknoSell", root, function()
  guiSetVisible(window, false)
  showCursor(false)
end)
