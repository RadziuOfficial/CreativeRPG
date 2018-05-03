	--[[
  Autor: Asper
  Skrypt: Suszarka administracji
  Zakaz uzywania skryptu bez zgody autora!
  Zakaz udostepniania skryptu bez zgody autora!
]]

local screenW, screenH = guiGetScreenSize()

function isPedAiming ( thePedToCheck )
	if isElement(thePedToCheck) then
		if getElementType(thePedToCheck) == "player" or getElementType(thePedToCheck) == "ped" then
			if getPedTask(thePedToCheck, "secondary", 0) == "TASK_SIMPLE_USE_GUN" then
				return true
			end
		end
	end
	return false
end

local wybrana_opcja = 1
local gui_showed = false

local opcje = {
[1] = "Napraw pojazd",
[2] = "Postaw na koła",
[3] = "Oddaj na parking",
[4] = "Zatankuj pojazd",
[5] = "Zaciągnij ręczny",
}

bindKey("mouse_wheel_down", "down", function()
	if gui_showed == true then
		if wybrana_opcja == 1 then
			wybrana_opcja = #opcje
			return
		end
		wybrana_opcja = wybrana_opcja-1
	end
end)

bindKey("mouse_wheel_up", "down", function()
	if gui_showed == true then
		if wybrana_opcja == #opcje then
			wybrana_opcja = 1
			return
		end
		wybrana_opcja = wybrana_opcja+1
	end
end)

local vehicle = false

bindKey("mouse1", "down", function()
	if gui_showed == true then
		triggerServerEvent("suszarka:opcja", localPlayer, vehicle, wybrana_opcja)
	end
end)

local czcionka = dxCreateFont(":crpg_fonty/f.ttf", 15)
if not czcionka then 
	czcionka = "default" 
end

function dxDrawButton(x, y, w, h, color)
  local color2 = tocolor(0,94,254)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x-0.4660164, y + h-1.6, w+1.5, 2, color2, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 3, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 3, color, false)
end

function gui()
	if isElementFrozen(vehicle) ~= true then
		opcje[5] = "Zaciągnij ręczny"
	else
		opcje[5] = "Spuść ręczny"
	end
	local id = getElementData(vehicle, "id") or getElementData(vehicle, "uid") or "brak"
	local paliwo = getElementData(vehicle, "paliwo") or 100
	paliwo = string.format("%1d", paliwo)
	local przebieg = getElementData(vehicle, "przebieg") or 0
	przebieg = string.format("%.2f", przebieg)
	local pojemnosc = getElementData(vehicle, "poj") or 1.2
	local bak = getElementData(vehicle, "bak") or 100
	--local kierowca = getElementData(vehicle, "kierowca") or "brak"
   	dxDrawButton(screenW * 0.3536, screenH * 0.1194, screenW * 0.2927, screenH * 0.1537, tocolor(15,15,15,175), false)
    dxDrawText("Suszarka\n\nOpcja:\n"..opcje[wybrana_opcja], (screenW * 0.3589) + 1, (screenH * 0.1259) + 1, (screenW * 0.4609) + 1, (screenH * 0.2639) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
    dxDrawText("Suszarka\n\nOpcja:\n"..opcje[wybrana_opcja], screenW * 0.3589, screenH * 0.1259, screenW * 0.4609, screenH * 0.2639, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
    dxDrawText("ID: "..id.."\nPaliwo: "..paliwo.."/"..bak.."L\nPrzebieg: "..przebieg.."km\nPojemność "..pojemnosc.."dm³", (screenW * 0.4661) + 1, (screenH * 0.1259) + 1, (screenW * 0.6411) + 1, (screenH * 0.2639) + 1, tocolor(0, 0, 0, 255), 0.8, czcionka, "center", "center", false, false, false, false, false)
    dxDrawText("ID: "..id.."\nPaliwo: "..paliwo.."/"..bak.."L\nPrzebieg: "..przebieg.."km\nPojemność "..pojemnosc.."dm³", screenW * 0.4661, screenH * 0.1259, screenW * 0.6411, screenH * 0.2639, tocolor(255, 255, 255, 255), 0.8, czcionka, "center", "center", false, false, false, false, false)
end

addEventHandler("onClientPlayerTarget", root, function(element)
	if element and isPedAiming(localPlayer) and getElementType(element) == "vehicle" and getPedWeapon(localPlayer) == 22 then
		vehicle = element
		addEventHandler("onClientRender", root, gui)
		gui_showed = true
	else
		if gui_showed ~= true then return end
		gui_showed = false
		vehicle = false
		removeEventHandler("onClientRender", root, gui)
	end
end)

addEventHandler("onClientPlayerWeaponSwitch", root, function(p, n)
	if getPedWeapon(localPlayer, n) == 22 then 
		toggleControl("aim_weapon", true)
		toggleControl("fire", false)
	end
end)