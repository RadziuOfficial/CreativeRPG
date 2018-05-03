--[[
ZAKAZ UŻYWANIA PONIŻSZEGO KODU
@WSZELKIE PRAWA ZASTRZEŻONE, CREATIVERPG.
AUTHOR:
- RAD3K @2018
- ALTEX @2018
ZAKAZ UŻYWANIA BEZ ZGODY AUTORA!
]]--

local m1 = createMarker(2790.45,1252.34,11.3-1, "cylinder", 1.5, 0, 255, 255,20)
createBlip(2790.45,1252.34,11.3,46,2,255,0,0,255,0,100)	

local textPraca = createElement("text")
setElementPosition(textPraca, 2790.45,1252.34,11.3-0.5)
setElementData(textPraca, "text", "Praca dorywcza\n>autobusy<")

local vehs = {}
local code = "Autobusy"
local zone = createColSphere(2824.32, 1248.74, 10.76, 6)
addEventHandler("onMarkerHit", m1, function(el, md)
if getElementData(el, "praca:pojazd") then
    return
end
if getElementData(el,"prawko_c") ~= 1 then
exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Aby tu pracować musisz mieć prawo jazdy KAT. C!", el)					
    return
end	
if not md or getElementType(el) ~= "player" or getPedOccupiedVehicle(el) then return end
if getElementData(el,"praca") then
exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Posiadasz aktywną pracę wpisz /resign!", el)			
    return
end
	if #getElementsWithinColShape(zone,"vehicle") >= 1 then exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Miejsce spawnu zajęte!", el) return end
    local x,y,z = getElementPosition(el)
    local autobus = createVehicle(437,2824.69, 1248.90, 10.90, 0.0, 359.9, 359.6)
	setElementFrozen(el,true)
	setElementData(autobus,"nametag","Praca dorywcza\nAutobus")
    setElementData(autobus, "praca:pojazd", el)
    setElementData(autobus, "przebieg", math.random(10000,80000))
    setVehicleHandling(autobus, "maxVelocity", 75.0)
	setElementData(el,"praca",code)
    setTimer(warpPedIntoVehicle,200,1,el,autobus)
    setTimer(setElementFrozen,1000,1,el, false)
    triggerClientEvent(el, "STARTJobBus", resourceRoot, autobus)
    vehs[el] = autobus
end)

addEvent("STOPJobBus", true)
addEventHandler("STOPJobBus", resourceRoot, function()
    local pojazd = getPedOccupiedVehicle(localPlayer)
    if pojazd then
        destroyElement(pojazd)
    end
end)

addEvent("destroyVeh", true)
addEventHandler("destroyVeh", getRootElement(),
function()
     if vehs[source] then
          if isElement(vehs[source]) then destroyElement(vehs[source]) end
     end
end)

addEvent("onPlayerQuit", true)
addEventHandler ( "onPlayerQuit", getRootElement(), function()
     if vehs[source] then
          if isElement(vehs[source]) then destroyElement(vehs[source]) end
    end
end)