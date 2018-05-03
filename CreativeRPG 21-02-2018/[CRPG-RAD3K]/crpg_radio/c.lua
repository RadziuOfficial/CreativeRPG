--[[
Autor: Asper
Zakaz udostepniania bez zgody autora!
Zakaz uzywania bez zgody autora!
--]]

local screenW, screenH = guiGetScreenSize()

local wybrana_opcja = 0
local alpha = 0
local music = false

local opcjeNumber = {
[1] = {"Radio PARTY", "https://radioparty.pl/play/glowny.m3u"},
[2] = {"RMF MAXXX", "http://files.kusmierz.be/rmf/rmfmaxxx.pls"},
[3] = {"Energy Remix", "http://s1.slotex.pl:7352/listen.pls"},
[4] = {"RMF FM", "http://www.rmfon.pl/n/rmffm.pls"},
[5] = {"Radio wyłączone", false},
}

local minwybor, maxwybor = 1,#opcjeNumber

local font = dxCreateFont(":crpg_fonty/f.ttf", 15)
if not font then
	font = "default"
end

local tick = getTickCount()

function opcjaPrawo()
	wybrana_opcja = wybrana_opcja -1

	local veh = getPedOccupiedVehicle(localPlayer)
	if(wybrana_opcja < minwybor)then
		wybrana_opcja = maxwybor
	end

	if music ~= false then
		destroyElement(music)
		music = false
	end
	if opcjeNumber[wybrana_opcja][2] == false then return end
	music = playSound(opcjeNumber[wybrana_opcja][2])
	setSoundVolume(music, 1)
end

function opcjaLewo()
	local veh = getPedOccupiedVehicle(localPlayer)
	wybrana_opcja = wybrana_opcja +1

	if(wybrana_opcja > maxwybor)then
		wybrana_opcja = minwybor
	end

	if music ~= false then
		destroyElement(music)
		music = false
	end
	if opcjeNumber[wybrana_opcja][2] == false then return end
	music = playSound(opcjeNumber[wybrana_opcja][2])
	setSoundVolume(music, 1)
end

bindKey("mouse_wheel_up", "down", function()
	if not getPedOccupiedVehicle(localPlayer) then return end
	opcjaPrawo() 
	if alpha ~= 255 then
		alpha = 255
		tick = getTickCount()
	end
end)

bindKey("mouse_wheel_down", "down", function()
	if not getPedOccupiedVehicle(localPlayer) then return end
	opcjaLewo()
	if alpha ~= 255 then
		alpha = 255
		tick = getTickCount()
	end
end)

addEventHandler("onClientRender", root, function()
	local veh = getPedOccupiedVehicle(localPlayer)
	if music ~= false and not veh then
		destroyElement(music)
		music = false
	end
	if veh then
		local now_time = getTickCount()
		if tick ~= 0 and now_time > tick+2000 then
			local Progress = (now_time-tick)/10000
			alpha = interpolateBetween(alpha,0,0,0,0,0,Progress,"InOutQuad")
		end
		if alpha < 1 then return end
        dxDrawBorderedText(opcjeNumber[wybrana_opcja][1], screenW * 0.0000, screenH * 0.0625, screenW * 1.0000, screenH * 0.1289, tocolor(255, 255, 255, 255), 1, font, "center", "center", false, false, false, false, false)
	end
end)

addEventHandler("onClientVehicleExit", root, function(player, seat)
	if player ~= localPlayer then return end
	if music ~= false then
		destroyElement(music)
		music = false
	end
end)

addEventHandler("onClientVehicleEnter", root, function(player, seat)
	if player ~= localPlayer then return end
	if alpha ~= 255 then
		alpha = 255
		tick = getTickCount()
	end
	if wybrana_opcja == 0 then
		wybrana_opcja = #opcjeNumber
	end
	if opcjeNumber[wybrana_opcja][2] == false then return end
	music = playSound(opcjeNumber[wybrana_opcja][2])
	setSoundVolume(music, 1)
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