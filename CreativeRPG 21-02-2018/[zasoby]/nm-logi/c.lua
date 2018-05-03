--[[
Autor: Asper
Dla: .newMode
Skrypt: Logi serwera w gui
Typ: Client
]]

local okno = guiCreateWindow(0.10, 0.06, 0.80, 0.89, "Logi serwerowe", true)
local lista = guiCreateGridList(0.01, 0.04, 0.98, 0.88, true, okno)
local button = guiCreateButton(0.01, 0.92, 0.29, 0.06, "Zamknij panel logów", true, okno)
guiGridListAddColumn(lista, "ID", 0.05)
guiGridListAddColumn(lista, "NICK", 0.05)
guiGridListAddColumn(lista, "TRESC", 0.41)
guiGridListAddColumn(lista, "SERIAL", 0.25)
guiGridListAddColumn(lista, "DATA", 0.15)
guiGridListAddColumn(lista, "TYP", 0.15)
guiSetVisible(okno, false)

addEvent("lLogow", true)
addEventHandler("lLogow", root, function(s)
  guiSetVisible(okno, true)
  showCursor(true, false)
  guiGridListClear(lista)
  if not s then return end
  for _, p in pairs(s) do
    local spr = guiGridListAddRow(lista)
    guiGridListSetItemText(lista, spr, 1, p["id"], false, false)
    guiGridListSetItemText(lista, spr, 2, p["nick"], false, false)
    guiGridListSetItemText(lista, spr, 3, p["tresc"], false, false)
    guiGridListSetItemText(lista, spr, 4, p["serial"], false, false)
    guiGridListSetItemText(lista, spr, 5, p["data"], false, false)
    guiGridListSetItemText(lista, spr, 6, p["typ"], false, false)
  end
 end)

addEventHandler("onClientGUIClick", button, function()
	showCursor(false)
	guiSetVisible(okno, false)
end)

local ignorowaneTexty = {
["Toggle"] = true,
["pm"] = true,
["przelej"] = true,
["duty"] = true,
["report"] = true,
["logi"] = true,
["cl"] = true,
["a"] = true,
["g"] = true,
["v"] = true,
["organizacja"] = true,
["admin"] = true,
["restart"] = true,
["start"] = true,
["stop"] = true,
["refresh"] = true,
["say"] = true, 
["debugscript"] = true,
}

addEventHandler("onClientConsole", root, function(text)
	if ignorowaneTexty[text] then return end
	if string.find(text, "say") or string.find(text, " ") then
			return
		end
 	triggerServerEvent("dodajLogi", localPlayer, text, "inne")
end)

addEvent("dodajLogi", true)
addEventHandler("dodajLogi", root, function(tresc, tryb)
  triggerServerEvent("dodajLogi", source, tresc, tryb)
end)