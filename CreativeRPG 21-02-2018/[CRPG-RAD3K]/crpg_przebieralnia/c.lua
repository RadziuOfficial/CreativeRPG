--[[
Autor: Asper
Dla: .newMode
Skrypt: Przebieralnia
Typ: Client
]]

local aktualnySkin = 1
local meskie = {0, 2, 7, 15, 16, 17, 19, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33, 34, 35, 37, 43, 44,  46, 47, 48, 49, 50, 51, 57, 59, 60, 61, 62, 66, 67, 68, 70, 72, 73, 78, 79, 80, 81, 94, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 118, 120, 121, 122, 123, 124, 125, 126, 127, 128, 132, 133, 134, 142, 143, 144, 146, 147, 153, 154, 155, 156, 158, 159, 161, 162, 163, 164, 165, 166, 168, 170, 171, 173, 174, 175, 176, 177, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 200, 202, 203, 206, 212, 213, 217, 220, 221, 223, 228, 230, 234, 235, 239, 240, 241, 242, 247, 248, 249, 250, 252, 253, 254, 255, 258, 259, 260, 261, 262, 270, 290, 291, 292, 293, 294, 295, 296, 297, 299, 300, 302, 303, 305, 306, 308, 309, 311, 312}
local damskie = {9, 11, 12, 13, 31, 39, 40, 54, 55, 56, 63, 64, 69, 75, 76, 77, 85, 87, 89, 90, 91, 92, 93, 129, 130, 131, 141, 145, 150, 151, 152, 157, 169, 172, 178, 190, 191, 192, 193, 194, 195, 196, 197, 199, 211, 214, 216, 218, 219, 225, 226, 231, 232, 233, 237, 238, 243, 244, 245, 246, 251, 256, 263, 298, 304}
local premium = {140, 139, 138, 136, 135, 117, 96, 95, 88, 84, 83, 82, 58, 53, 52, 45, 41, 38, 36, 20, 1}

local ped = false

local screenW, screenH = guiGetScreenSize()

local czcionka = dxCreateFont(":crpg_fonty/f.ttf", 10)
if not czcionka then czcionka = "default-bold" end

local panel = false
local tryb = 2

function dxDrawButton(x, y, w, h, color)
  local color2 = tocolor(0,94,254)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x-0.4660164, y + h-1.6, w+1.5, 2, color2, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 3, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 3, color, false)
end

function gui()
        dxDrawButton(screenW * 0.3741, screenH * 0.0182, screenW * 0.1830, screenH * 0.0742, tocolor(15, 15, 15, 175))
        dxDrawText("Aby zmienić skin użyj strzałek\nAby zapisać zmiane skin użyj entera\nAby anulować zmiane skina użyj spacji", (screenW * 0.2965) + 1, (screenH * 0.0104) + 1, (screenW * 0.6406) + 1, (screenH * 0.0977) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Aby zmienić skin użyj strzałek\nAby zapisać zmiane skin użyj entera\nAby anulować zmiane skina użyj spacji", screenW * 0.2965, screenH * 0.0104, screenW * 0.6406, screenH * 0.0977, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawButton(screenW * 0.2020, screenH * 0.0208, screenW * 0.1501, screenH * 0.0716, tocolor(15, 15, 15, 175))
       	local trybN = "Męskie"
       	if tryb == 2 then
       		trybN = "Męskie"
       	elseif tryb == 1 then
       		trybN = "Damskie"
       	elseif tryb == 3 then
       		trybN = "Premium"
       	end
        dxDrawText("Skiny: "..trybN, (screenW * 0.2013) + 1, (screenH * 0.0208) + 1, (screenW * 0.3521) + 1, (screenH * 0.0924) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Skiny: "..trybN, screenW * 0.2013, screenH * 0.0208, screenW * 0.3521, screenH * 0.0924, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
end

local marker = createMarker(213.64, -41.60, 1002.02-1, "cylinder", 1.5, 255, 0, 0, 100)
setElementInterior(marker, 1)

addEventHandler("onClientMarkerHit", marker, function(hit)
	if hit ~= localPlayer then return end
	panel = true
	addEventHandler("onClientPreRender", root, gui)
	aktualnySkin = 1
	ped = createPed(0, 209.79, -34.01, 1001.93, 137)
	setElementInterior(ped, 1)
	setElementFrozen(hit, true)
	setCameraMatrix(208.45280456543, -39.377201080322, 1002.9429931641, 208.6943359375, -38.409664154053, 1002.8685913086)
end)

bindKey("enter", "down", function()
	if panel ~= true then return end
	exports["nm-noti"]:noti("Zapisano zmiane skina.")
	triggerServerEvent("zSkin", resourceRoot, localPlayer, getElementModel(ped))
	destroyElement(ped)
	aktualnySkin = 1
	panel = false
	setElementFrozen(localPlayer, false)
	setCameraTarget(localPlayer)
	removeEventHandler("onClientPreRender", root, gui)
end)

bindKey("space", "down", function()
	if panel ~= true then return end
	exports["nm-noti"]:noti("Anulowano zmiane skina.")
	destroyElement(ped)
	aktualnySkin = 1
	panel = false
	setElementFrozen(localPlayer, false)
	setCameraTarget(localPlayer)
	removeEventHandler("onClientPreRender", root, gui)
end)

bindKey("arrow_l", "both", function(k, s)
	if s ~= "down" then return end
	if panel ~= true then return end
	if aktualnySkin == 1 then return end
	aktualnySkin = aktualnySkin-1
	if tryb == 1 then
		setElementModel(ped, damskie[aktualnySkin])
	elseif tryb == 2 then
		setElementModel(ped, meskie[aktualnySkin])
	elseif tryb == 3 then
		setElementModel(ped, premium[aktualnySkin])
	end
end)

bindKey("arrow_r", "both", function(k, s)
	if s ~= "down" then return end
	if panel ~= true then return end
	if tryb == 1 and aktualnySkin ~= 82 then
		aktualnySkin = aktualnySkin+1
		setElementModel(ped, damskie[aktualnySkin])
	elseif tryb == 2 and aktualnySkin ~= 227 then
		aktualnySkin = aktualnySkin+1
		setElementModel(ped, meskie[aktualnySkin])
	elseif tryb == 3 and aktualnySkin ~= 43 then
		aktualnySkin = aktualnySkin+1
		setElementModel(ped, premium[aktualnySkin])
	end
end)

bindKey("arrow_d", "both", function(k, s)
	if s ~= "down" then return end
	if panel ~= true then return end
	if tryb == 1 then return end
	tryb = tryb-1
	aktualnySkin = 1
	setElementModel(ped, 0)
end)

bindKey("arrow_u", "both", function(k, s)
	if s ~= "down" then return end
	if panel ~= true then return end
	local maxwybor = 2
	if getElementData(localPlayer, "premium") then
		maxwybor = 3
	end
	if tryb == maxwybor then return end
	tryb = tryb+1
	aktualnySkin = 1
	setElementModel(ped, 0)
end)