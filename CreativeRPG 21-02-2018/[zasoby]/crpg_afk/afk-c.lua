--[[
Autor: Asper
Dla: .newMode
Skrypt: Anty AFK system
Typ: Client
]]

local screenW, screenH = guiGetScreenSize()

local czcionka = dxCreateFont(":crpg_fonty/f.ttf", 10)
 
function afk()
exports["nm-blur"]:dxDrawBluredRectangle(screenW * 0.2734, screenH * 0.1191, screenW * 0.4313, screenH * 0.1553, tocolor(150, 150, 150, 255))
dxDrawRectangle(screenW * 0.2734, screenH * 0.1191, screenW * 0.4313, screenH * 0.0254, tocolor(78, 174, 1, 255), false)
dxDrawText("Anty AFK", (screenW * 0.2719) + 1, (screenH * 0.1191) + 1, (screenW * 0.7047) + 1, (screenH * 0.1445) + 1, tocolor(0, 0, 0, 255), 1, czcionka, "center", "center", false, false, false, false, false)
dxDrawText("Anty AFK", screenW * 0.2719, screenH * 0.1191, screenW * 0.7047, screenH * 0.1445, tocolor(255, 255, 255, 255), 1, czcionka, "center", "center", false, false, false, false, false)
dxDrawText("Twoja postac jest AFK!", (screenW * 0.2734) + 1, (screenH * 0.1445) + 1, (screenW * 0.7047) + 1, (screenH * 0.1855) + 1, tocolor(0, 0, 0, 255), 1, czcionka, "center", "center", false, false, false, false, false)
dxDrawText("Twoja postac jest AFK!", screenW * 0.2734, screenH * 0.1445, screenW * 0.7047, screenH * 0.1855, tocolor(255, 255, 255, 255), 1, czcionka, "center", "center", false, false, false, false, false)
dxDrawText("Rusz sie aby nie dostać kicka!", (screenW * 0.2734) + 1, (screenH * 0.1855) + 1, (screenW * 0.7047) + 1, (screenH * 0.2324) + 1, tocolor(0, 0, 0, 255), 1, czcionka, "center", "center", false, false, false, false, false)
dxDrawText("Rusz sie aby nie dostać kicka!", screenW * 0.2734, screenH * 0.1855, screenW * 0.7047, screenH * 0.2324, tocolor(255, 255, 255, 255), 1, czcionka, "center", "center", false, false, false, false, false)
dxDrawText("Nie stosowanie się do ostrzeżenia może skutkować kickiem lub banem.", screenW * 0.2742 + 1, screenH * 0.2324 + 1, screenW * 0.7047 + 1, screenH * 0.2744 + 1, tocolor(0, 0, 0, 255), 1, czcionka, "center", "center", false, false, false, false, false)
dxDrawText("Nie stosowanie się do ostrzeżenia może skutkować kickiem lub banem.", screenW * 0.2742, screenH * 0.2324, screenW * 0.7047, screenH * 0.2744, tocolor(255, 255, 255, 255), 1, czcionka, "center", "center", false, false, false, false, false)
end

addEvent("afk", true)
addEventHandler("afk", root, function()
	addEventHandler("onClientPreRneder", root, afk)
	setTimer(function()
		removeEventHandler("onClientPreRneder", root, afk)
	end, 10000, 1)
end)