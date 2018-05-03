--[[
	Autor: Asper
	Praca: Koparek
	Nie masz prawa użyć tego kodu bez mojej zgody
]]

local screenW, screenH = guiGetScreenSize()
local started = 0
local praca = false
local praca2 = false
local praca3 = false
local tekst = "Oddawanie pojazdu na parking..."
local czcionka = dxCreateFont(":crpg_fonty/f.ttf", 15)
if not czcionka then czcionka = "default-bold" end

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

function dxDrawLoading (x, y, width, height, x2, y2, size, second)
    local now = getTickCount()
    local seconds = second or 5000
	local color = tocolor(15,15,15,222)
	local color2 = tocolor(0,94,254,125)
	local size = size or 1.00
    local with = interpolateBetween(0,0,0,width,0,0, (now - started) / ((started + seconds) - started), "Linear")
    local text = interpolateBetween(0,0,0,100,0,0,(now - started) / ((started + seconds) - started),"Linear")
    dxDrawButton(x, y ,width ,height -10, color)
    roundedRectangle(x, y, with ,height -10, color2)
    dxDrawText(tekst.." - "..math.floor(text).."%", x2+1, y2+1, width+1, height+1, tocolor(0,0,0), 1, czcionka)
    dxDrawText(tekst.." - "..math.floor(text).."%", x2, y2, width, height, tocolor(255,255,255), 1, czcionka)
end

local blips = {}

function start()
	if getElementData(localPlayer, "praca") ~= 2 then return end
	if getElementData(localPlayer, "praca:pojazd") then return end
	triggerServerEvent("giveHolownik", localPlayer)
	rozpocznijPrace(localPlayer)
	if praca ~= true then
		praca = true
	end
end
addEventHandler("onPlayerAccountLogin", root, start)
addEventHandler("onPlayerStartJob", root, start)

local pojazdy_random = {541,415,480,562,565,560,506,451,558}
local pojazdy_xyz = {
{2308.93, 1390.24, 29.82, 359.9, 0.0, 0.2},
{1588.09, 1964.73, 10.62, 359.3, 359.9, 244.4},
{1511.93, 774.59, 10.58, 359.8, 360.0, 270.0},
{2451.86, 1229.59, 10.62, 359.9, 0.0, 1.1},	
{2621.69, 1660.51, 10.57, 359.8, 360.0, 45.2},
{2230.73, 1948.86, 9.62, 359.8, 0.0, 359.8},
{2242.75, 2791.83, 10.58, 359.8, 360.0, 202.9},
{1422.78, 2814.04, 10.58, 0.2, 359.5, 304.5},
{988.46, 1083.17, 10.58, 0.4, 359.9, 332.2},
{1707.17, 1059.29, 10.63, 360.0, 0.0, 115.8},	
}

function rozpocznijPrace()
	local r = math.random(1, #pojazdy_xyz)
	local model = math.random(1,#pojazdy_random)
	blips["vehicle"] = createVehicle(pojazdy_random[model], pojazdy_xyz[r][1], pojazdy_xyz[r][2]+getElementData(localPlayer, "id"), pojazdy_xyz[r][3], pojazdy_xyz[r][4], pojazdy_xyz[r][5], pojazdy_xyz[r][6])
	blips["blip"] = createBlipAttachedTo(blips["vehicle"], 41)
	praca2 = blips["vehicle"]
	praca3 = true
	if praca ~= true then
		praca = true
	end
end

addEventHandler("onClientMarkerHit", resourceRoot, function(hit)
	if hit ~= localPlayer then return end
	if source ~= blips["marker"] then return end
	local vehicle = getPedOccupiedVehicle(hit)
	if not vehicle then return end
	setElementFrozen(vehicle, true)
	fadeCamera(false)
    function dxLoad()
	local now = getTickCount()
    dxDrawLoading(screenW * 0.3135, screenH * 0.4593, screenW * 0.3729, screenH * 0.0815, screenW * 0.4200, screenH * 0.4825, 1,5000)
    if now > started + 5000 then
		started = getTickCount()
		removeEventHandler("onClientRender", root, dxLoad)
		fadeCamera(true)
		praca2 = false
		exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Pojazd został oddany na parking!")
		setElementFrozen(vehicle, false)
		destroyElement(getVehicleTowedByVehicle(vehicle))
		blips["vehicle"] = false
		destroyElement(blips["marker"])
		destroyElement(blips["blip2"])
		blips["marker"] = false
		blips["blip2"] = false
		local hajs = math.random(300,400)
		local hajs2 = getElementData(localPlayer, "pracamoney") or 0
		setElementData(localPlayer, "pracamoney", hajs2+hajs)
		exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Za wykonanie zlecenia otrzymujesz "..hajs.." PLN, wypłate możesz odebrać u pracodawcy!")
		rozpocznijPrace()
	end
end
started = getTickCount()
addEventHandler("onClientRender", root, dxLoad)
end)

addEventHandler("onClientRender", root, function()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if not vehicle then return end
	if not praca then return end
	if not getVehicleTowedByVehicle(vehicle) or getVehicleTowedByVehicle(vehicle) ~= blips["vehicle"] then
		if blips["marker"] then
   			destroyElement(blips["marker"])
   			destroyElement(blips["blip2"])
   			blips["blip2"] = false
   			blips["marker"] = false
   		end 
   		if not blips["blip"] or not isElement(blips["blip"]) then
   			blips["blip"] = createBlipAttachedTo(blips["vehicle"], 41)
   			praca3 = true
   		end
		dxDrawButton(screenW * 0.4056, screenH * 0.0130, screenW * 0.1903, screenH * 0.0560, tocolor(15,15,15,222), false)
        dxDrawBorderedText("Udaj się do czerwonego punktu na mapie!", screenW * 0.4048, screenH * 0.0104, screenW * 0.5959, screenH * 0.0690, tocolor(255, 255, 255, 255), 0.7, czcionka, "center", "center", false, false, false, false, false)
    elseif getVehicleTowedByVehicle(vehicle) and getVehicleTowedByVehicle(vehicle) == praca2 and praca3 == true then
    	blips["marker"] = createMarker(1024.18, 2109.74, 10.82-1, "cylinder",6,255,0,0,100)
    	blips["blip2"] = createBlipAttachedTo(blips["marker"], 41)
    	destroyElement(blips["blip"])
   		blips["blip"] = false
   		praca3 = false
   	elseif getVehicleTowedByVehicle(vehicle) and getVehicleTowedByVehicle(vehicle) == blips["vehicle"] then
   		dxDrawButton(screenW * 0.4056, screenH * 0.0130, screenW * 0.1903, screenH * 0.0560, tocolor(15,15,15,222), false)
        dxDrawBorderedText("Odwieź pojazd na parking!", screenW * 0.4048, screenH * 0.0104, screenW * 0.5959, screenH * 0.0690, tocolor(255, 255, 255, 255), 0.7, czcionka, "center", "center", false, false, false, false, false)
	end
end)

addEventHandler("onClientPlayerPayday", root, function(money)
	koniec()
end)

function koniec()
	if getElementData(localPlayer, "praca") ~= 2 then return end
	if isPedInVehicle(localPlayer) then return end
	setElementData(localPlayer, "praca:pojazd", false)
	if blips["vehicle"] and isElement(blips["vehicle"]) then
		destroyElement(blips["vehicle"])
		blips["vehicle"] = false
	end
	if blips["blip"] and isElement(blips["blip"]) then
		destroyElement(blips["blip"])
		blips["blip"] = false
	end
	if blips["marker"] and isElement(blips["marker"]) then
		destroyElement(blips["marker"])
		blips["vehicle"] = false
		destroyElement(blips["blip2"])
		blips["blip2"] = false
	end
	praca = false
	praca2 = false
	praca3 = false
end
addEventHandler("onPlayerResign", root, koniec)

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

addEvent("stop:holownik", true)
addEventHandler("stop:holownik", root, function()
	koniec()
end)