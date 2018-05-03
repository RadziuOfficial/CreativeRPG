--[[
Autor: Asper
Zakaz udostepniania bez zgody autora!
Zakaz uzywania bez zgody autora!
--]]

local screenW, screenH = guiGetScreenSize()

local wybrana_opcja = 0
local minwybor, maxwybor = 1,4
local minwybor2, maxwybor2 = 1,3
local tick = getTickCount()

local opcjeNumber = {
[1] = {"1", 100},
[2] = {"2", 100},
[3] = {"3", 100},
[4] = {"4", 100},
}

local rowery = {
["Bike"] = true,
["Mountainbike"] = true,
["BMX"] = true,	
}

local font = dxCreateFont(":crpg_fonty/f.ttf", 15)
if not font then
	font = "default"
end

function opcjaPrawo()
	wybrana_opcja = wybrana_opcja -1

	local veh = getPedOccupiedVehicle(localPlayer)
	if getElementData(veh, "zawieszenie") then
		if(wybrana_opcja < minwybor)then
			wybrana_opcja = maxwybor
		end
	else
		if(wybrana_opcja < minwybor2)then
			wybrana_opcja = maxwybor2
		end
	end
	tick = getTickCount()
end

function opcjaLewo()
	local veh = getPedOccupiedVehicle(localPlayer)
	wybrana_opcja = wybrana_opcja +1

	if getElementData(veh, "zawieszenie") then
		if(wybrana_opcja > maxwybor)then
			wybrana_opcja = minwybor
		end
	else
		if(wybrana_opcja > maxwybor2)then
			wybrana_opcja = minwybor2
		end
	end
	tick = getTickCount()
end

bindKey("arrow_u", "down", function()
	if panelWyboruOpcji == true then
		opcjaPrawo() 
	end
end)

bindKey("arrow_d", "down", function()
	if panelWyboruOpcji == true  then
		opcjaLewo()
	end
end)

bindKey("mouse_wheel_up", "down", function()
	if panelWyboruOpcji == true then
		opcjaPrawo() 
	end
end)

bindKey("mouse_wheel_down", "down", function()
	if panelWyboruOpcji == true  then
		opcjaLewo()
	end
end)

function dxDrawButton(x, y, w, h, color)
  local color2 = tocolor(0,94,254)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x-0.4660164, y + h-1.6, w+1.5, 2, color2, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 3, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 3, color, false)
end

local n = {}
n[1] = {screenW * 0.8150, screenH * 0.4067, screenW * 0.2208, screenH * 0.0486, screenH * 0.4300, screenW * 0.9400}
n[2] = {screenW * 0.8150, screenH * 0.4667, screenW * 0.2208, screenH * 0.0486, screenH * 0.4900, screenW * 0.9400}
n[3] = {screenW * 0.8150, screenH * 0.5267, screenW * 0.2208, screenH * 0.0486, screenH * 0.5500, screenW * 0.9400}
n[4] = {screenW * 0.8150, screenH * 0.5867, screenW * 0.2208, screenH * 0.0486, screenH * 0.6100, screenW * 0.9400}

local r,g,b = 15,15,15
local max = 3

function WyborySPW()
	local veh = getPedOccupiedVehicle(localPlayer)
	if veh then

		if isElementFrozen(veh) == true then
			opcjeNumber[3][1] = "Spuść ręczny"
		else
			opcjeNumber[3][1] = "Zaciągnij ręczny"
		end

		local silnik = getVehicleEngineState(veh)
    	if silnik == true then
       		opcjeNumber[2][1] = "Wyłącz silnik"
    	else
        	opcjeNumber[2][1] = "Uruchom silnik"
    	end
        
    	if getVehicleOverrideLights(veh) ~= 2 then
        	opcjeNumber[1][1] = "Uruchom lampy"
    	else
        	opcjeNumber[1][1] = "Wyłącz lampy"
    	end

		if getElementData(veh, "zawieszenie") == 2 then
			opcjeNumber[4][1] = "Zawieszenie miejskie"
		elseif getElementData(veh, "zawieszenie") == 1 then
			opcjeNumber[4][1] = "Zawieszenie terenowe"
		elseif getElementData(veh, "zawieszenie") == 3 then
			opcjeNumber[4][1] = "Zawieszenie sportowe"
		end

		if getElementData(veh, "zawieszenie") then
			max = 4
		else
			max = 3
		end

		for i=1,max do
			if wybrana_opcja == i and opcjeNumber[i][2] == 100 then
				opcjeNumber[i][2] = 175
			elseif wybrana_opcja ~= i and opcjeNumber[i][2] == 175 then
				opcjeNumber[i][2] = 100
			end
			if i == wybrana_opcja then
				local nn = interpolateBetween(n[i][1]+(n[i][1]/5), 0, 0, n[i][1], 0, 0, (getTickCount()-tick)/250, "OutBack") 
        		dxDrawButton(nn, n[i][2], n[i][3], n[i][4], tocolor(r,g,b,opcjeNumber[i][2]), false)
        		--dxDrawImage(n[i][1], n[i][2], screenW * 0.0500, n[i][4], "icon.png", 180, 0, 0, white, false)
				dxDrawText(opcjeNumber[i][1], n[i][1]+1, n[i][5]+(1), screenW * 1.0000+1, n[i][5]+(1), tocolor(0, 0, 0, 255), 1, font, "center", "center", false, false, false, false, false)
        		dxDrawText(opcjeNumber[i][1], n[i][1], n[i][5], screenW * 1.0000, n[i][5], tocolor(255, 255, 255, 255), 1, font, "center", "center", false, false, false, false, false)
        	else
        		dxDrawButton(n[i][6], n[i][2], n[i][6], n[i][4], tocolor(r,g,b,opcjeNumber[i][2]), false)
        		--dxDrawImage(n[i][6], n[i][2], screenW * 0.0500, n[i][4], "icon.png", 0, 0, 0, white, false)
        	end
        end
	end
end

panelWyboruOpcji = false

function onPanelInterkcja()
	local veh = getPedOccupiedVehicle(localPlayer)
	if veh then
		if rowery[getVehicleName(veh)] then return end
		if getVehicleController(veh) == localPlayer then
			if panelWyboruOpcji == false then
				addEventHandler("onClientRender",root,WyborySPW)
				tick = getTickCount()
				wybrana_opcja=1
				panelWyboruOpcji = true
			end
		end
	end
end

function offPanelInterkcja()
	local veh = getPedOccupiedVehicle(localPlayer)
	if veh then
		if getVehicleController(veh) == localPlayer then
			if panelWyboruOpcji == true then
				local wybrana_opcja=tonumber(wybrana_opcja)
				if wybrana_opcja == 3 then
					triggerServerEvent("onInterakcjeReczny", localPlayer)
				end
				if wybrana_opcja == 2 then
					triggerServerEvent("onInterakcjeSlinik", localPlayer)
				end
				if wybrana_opcja == 1 then
					triggerServerEvent("onInterakcjeSwiatla", localPlayer)
				end
				if wybrana_opcja == 4 then
					triggerServerEvent("onInterakcjeZawieszenie", localPlayer, getElementData(veh, "zawieszenie"))
				end
				removeEventHandler("onClientRender",root,WyborySPW)
				panelWyboruOpcji = false
			end
		end
	end
end

bindKey ("lshift", "down", onPanelInterkcja)
bindKey ("lshift", "up", offPanelInterkcja)

bindKey("arrow_l", "both", function(k, s)
	if s ~= "down" then return end
	if panelWyboruOpcji ~= true then return end
	if wybrana_opcja ~= 4 then return end
	local pojazd = getPedOccupiedVehicle(localPlayer)
	if not pojazd then return end
	local zawieszenie = getElementData(pojazd, "zawieszenie")
	if zawieszenie == 1 then return end
	setElementData(pojazd, "zawieszenie", zawieszenie-1)
end)

bindKey("arrow_r", "both", function(k, s)
	if s ~= "down" then return end
	if panelWyboruOpcji ~= true then return end
	if wybrana_opcja ~= 4 then return end
	local pojazd = getPedOccupiedVehicle(localPlayer)
	if not pojazd then return end
	local zawieszenie = getElementData(pojazd, "zawieszenie")
	if zawieszenie == 3 then return end
	setElementData(pojazd, "zawieszenie", zawieszenie+1)
end)

addEventHandler("onClientVehicleExit", root, function(plr, seat)
    if seat == 0 then
        if plr == localPlayer then
             offPanelInterkcja()
             panelWyboruOpcji = false
        end
    end
end)