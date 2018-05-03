--[[
Autor: Asper
Dla: .newMode
Skrypt: Przebieralnia
Typ: Client
]]

addEvent("zSkin", true)
addEventHandler("zSkin", root, function(l, i)
	if not l and not i then return end
	setElementModel(l, i)
	setElementData(l, "skin", i)
end)