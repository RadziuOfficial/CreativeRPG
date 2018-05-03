--[[
ZAKAZ UŻYWANIA PONIŻSZEGO KODU
@WSZELKIE PRAWA ZASTRZEŻONE, CREATIVERPG.
AUTHOR:
- RAD3K @2018
- ALTEX @2018
ZAKAZ UŻYWANIA BEZ ZGODY AUTORA!
]]--

local punkty_napraw = {
-- GARCIA SF
{-2272.41, 3.51, 35.33, -2279.54, 1.15, 35.33},
{-2272.21, 11.84, 35.32, -2278.80, 9.36, 35.32},
-- DOHERTY SF
{-2059.05, 175.92, 28.80, -2051.68, 178.80, 28.80},
{-2059.08, 167.84, 28.80, -2051.10, 170.31, 28.80},
-- PILGRIM LV
{2457.45, 1762.34, 10.82, 2454.44, 1754.38, 10.82},
{2444.99, 1761.70, 10.82, 2442.15, 1754.32, 10.82},
}

local frakcyjne = createMarker(-2046.943359375, 147.65234375, 28.8359375, "corona", 3, 0, 255, 0, 255)

addEventHandler("onMarkerHit", frakcyjne, function(hit)
	if not hit then return end
	if getElementType(hit) ~= "player" then return end
	local veh = getPedOccupiedVehicle(hit)
	if not veh then return end
	if getVehicleController(veh) ~= hit then return end
	if not getElementData(hit, "user:faction") then return end
	if getElementData(veh, "veh:uid") then return end
	fixVehicle(veh)
	outputChatBox("Pojazd frakcyjny został naprawiony.", hit, 255, 255, 255)
end)

for _,v in ipairs(punkty_napraw)do
	local marker = createMarker(v[1], v[2], v[3]-1, "cylinder", 1.2, 0, 94, 254, 50)
	local cuboid = createColSphere(v[4], v[5], v[6], 3.5)
	setElementData(marker, "cuboid", cuboid)
	local blip = createBlip(-2282.93, 13.97, 35.32, 27,2,255,0,0,255,0,100) -- GARCIA SF
	local blip = createBlip(-2055.29, 174.55, 33.50, 27,2,255,0,0,255,0,100) -- DOHERTY	SF
	local blip = createBlip(2457.45, 1762.34, 10.82, 27,2,255,0,0,255,0,100) -- PILGRIM LV	
	napis = createElement("text")
	setElementPosition(napis, v[1], v[2], v[3]-0.5)
	setElementData(napis, "text", "Naprawa\nPojazdów")
end

addEvent("naprawa", true)
addEventHandler("naprawa", root, function(woz)
local zycie = getElementHealth(woz)
if tonumber(zycie) > 30 and tonumber(zycie) <= 250 then
ceny = 500
elseif tonumber(zycie) > 250 and tonumber(zycie) <= 500 then
ceny = 250
elseif tonumber(zycie) > 500 and tonumber(zycie) <= 750 then
ceny = 150
elseif tonumber(zycie) > 750 and tonumber(zycie) <= 850 then
ceny = 100
elseif tonumber(zycie) > 850 and tonumber(zycie) <= 1000 then
ceny = 50
end
local kasa = getElementData(source, "pieniadze")
local all = getElementData(source, "cena:naprawy")
local czystac = kasa >= all
if czystac then
    setElementData(source, "pieniadze", kasa-all)
	fixVehicle(woz)
	exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Naprawiłeś swój pojazd za "..ceny.." PLN", source)	
	setElementData(source, "cena:naprawy", false)
	setElementData(source, "jest:pojazd", false)
else
	exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Nie stać cię na naprawe pojazdu!", source)	
end
end)
