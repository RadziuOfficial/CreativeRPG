

local licz = {}
local t=createElement('text')
setElementData(t,'name',"Policja\nRozpoczynanie służby")
setElementDimension(t, 0)
setElementInterior(t, 0)
setElementPosition(t,-1610.40, 690.04, 1337.95+1)


--[[local t=createElement('text')
setElementData(t,'name','')
setElementPosition(t,1555.50, -1675.62, 16.20)
local t=createElement('text')
setElementData(t,'name','')
setElementPosition(t,-1624.34, 688.91, 1337.95)]]

wejscie = createMarker (1555.50, -1675.62, 17.20-0.5, "arrow", 1.0, 0, 0, 255,0)
wyjscie = createMarker (-1624.34, 688.91, 1338.80, "arrow", 1.0, 0, 0, 255,255)

addEventHandler("onMarkerHit", wejscie, function(el, md)
	if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    setElementDimension(el, 0)
    setElementInterior(el, 0)
    setElementPosition(el, -1624.18, 692.89, 1337.95)
end)

addEventHandler("onMarkerHit", wyjscie, function(el, md)
	if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    setElementDimension(el, 0)
    setElementInterior(el, 0)
    setElementPosition(el, 1546.69, -1675.61, 13.56)
end)

--[[local t=createElement('text')
setElementData(t,'name','Rozpoczęcie służby')
setElementPosition(t,-1610.40, 690.04, 1337.95)

wejscie = createMarker (1878.33, -1718.95, 13198.79, "arrow", 1.0, 0, 0, 255,0)
wyjscie = createMarker (1879.04, -1718.93, 13198.79, "arrow", 1.0, 0, 0, 255,255)

addEventHandler("onMarkerHit", wejscie, function(el, md)
	if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    setElementDimension(el, 0)
    setElementInterior(el, 0)
    setElementPosition(el, 1881.67, -1718.96, 13198.79)
end)

addEventHandler("onMarkerHit", wyjscie, function(el, md)
	if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    setElementDimension(el, 0)
    setElementInterior(el, 0)
    setElementPosition(el, 1874.70, -1719.38, 13198.79)
end)

wejscie = createMarker (-1620.30, 711.21, 22.38, "arrow", 1.0, 0, 0, 255,0)
wyjscie = createMarker (-1577.34, 695.28, 48.88, "arrow", 1.0, 0, 0, 255,255)

addEventHandler("onMarkerHit", wejscie, function(el, md)
	if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    setElementDimension(el, 0)
    setElementInterior(el, 0)
    setElementPosition(el, -1578.93, 695.21, 48.88)
end)

addEventHandler("onMarkerHit", wyjscie, function(el, md)
	if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    setElementDimension(el, 0)
    setElementInterior(el, 0)
    setElementPosition(el, -1620.47, 713.37, 22.38)
end)


local t=createElement('text')
setElementData(t,'name','Wejście\nna dach')
setElementPosition(t,-1620.30, 711.21, 22.38)
local t=createElement('text')
setElementData(t,'name','wejscie do srodka')
setElementPosition(t,-1577.34, 695.28, 48.88)

wejscie = createMarker (1864.34, -1725.87, 13198.79, "arrow", 1.0, 0, 0, 255,0)
wyjscie = createMarker (1815.41, -1709.94, 13230.79, "arrow", 1.0, 0, 0, 255,255)

addEventHandler("onMarkerHit", wejscie, function(el, md)
	if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    setElementDimension(el, 0)
    setElementInterior(el, 0)
    setElementPosition(el, 1811.35, -1709.97, 13230.79)
end)

addEventHandler("onMarkerHit", wyjscie, function(el, md)
	if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    setElementDimension(el, 0)
    setElementInterior(el, 0)
    setElementPosition(el, 1868.08, -1725.92, 13198.79)
end)

local t=createElement('text')
setElementData(t,'name','Wejście\nParking')
setElementPosition(t,1892.03, -1705.43, 13198.79)
local t=createElement('text')
setElementData(t,'name','Powrót na KGP')
setElementPosition(t,1896.33, -1702.31, 6.11)

wejscie = createMarker (1892.03, -1705.43, 13198.79, "arrow", 1.0, 0, 0, 255,0)
wyjscie = createMarker (1896.33, -1702.31, 6.11, "arrow", 1.0, 0, 0, 255,255)

addEventHandler("onMarkerHit", wejscie, function(el, md)
	if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    setElementDimension(el, 0)
    setElementInterior(el, 0)
    setElementPosition(el, 1901.32, -1701.85, 5.78)
end)

addEventHandler("onMarkerHit", wyjscie, function(el, md)
	if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    setElementDimension(el, 0)
    setElementInterior(el, 0)
    setElementPosition(el, 1892.40, -1708.92, 13198.79)
end)

local t=createElement('text')
setElementData(t,'name','Wejście\nDyspozytornia\nSala spotkań\nZarząd')
setElementPosition(t,1867.42, -1723.12, 13198.79)

wejscie = createMarker (1867.42, -1723.12, 13198.79, "arrow", 1.0, 0, 0, 255,0)
wyjscie = createMarker (1867.45, -1721.64, 13198.79, "arrow", 1.0, 0, 0, 255,255)

addEventHandler("onMarkerHit", wejscie, function(el, md)
	if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    setElementDimension(el, 0)
    setElementInterior(el, 0)
    setElementPosition(el, 1867.33, -1719.20, 13198.79)
end)

addEventHandler("onMarkerHit", wyjscie, function(el, md)
	if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    setElementDimension(el, 0)
    setElementInterior(el, 0)
    setElementPosition(el, 1867.54, -1727.15, 13198.79)
end)--]]

function isPlayerInPoliceFaction(plr)
 local uid=getElementData(plr,'player:uid')
 if not uid then return end

 local result=exports['ogrpg-db']:dbGet('SELECT 1 FROM ogrpg_factions WHERE code=? AND uid=? LIMIT 1;', "Policja", uid)
 if result[1] then
  return true
 else
  return false
 end
end


addEvent("RozpocznijSAPD",true)
addEventHandler("RozpocznijSAPD",root,function(el)
	if isPlayerInPoliceFaction(el) then
		if not getElementData(el,'player:duty') then
			setElementHealth(el,100)
			giveWeapon(el,4)
			--setElementModel(el,277)
			--setPlayerNametagColor(el,0,0,255)
			exports['frakcja']:rozpocznijnaliczanie(el)
			setElementData(el,'player:duty','Policja')
			local rank = exports['frakcja']:getPlayerFactionRank(el,'Policja')
			setElementData(el,"player:rank",rank)
		    exports["noti"]:noti("Rozpoczynasz służbę", el)

		    -------------------- nie dotykać 
		    			    local uid=getElementData(el,"player:uid")
		    exports['ogrpg-db']:dbSet('UPDATE ogrpg_factions set actived=NOW() WHERE code=? AND uid=? LIMIT 1;', "Policja", uid)


		    ------------------------------------------------------


		else
			exports['frakcja']:zatrzymajnaliczanie(el)
			takeWeapon(el,4)
			removeElementData(el, 'player:duty')
			removeElementData(el,"player:rank")
			local skin=getElementData(el,"player:skin")
			exports["noti"]:noti("Zakonczyłeś służbę", el)
			setPlayerNametagColor(el, 255,255,255)
			setElementModel(el, skin)
		end
	else
		exports["noti"]:noti("Nie należysz do Policji", el)
	end
end)



--trigg
function naliczanie(el)
	if isElement(el) then
   local x = getElementData(el,"player:workinjob") or 0
   setElementData(el,"player:workinjob",x+1)
   else
	if isTimer(licz[el]) then
	killTimer(licz[el])
	licz[el] = nil
	end
   end
end

local t=createElement('text')
setElementData(t,'name','Policja\nSkin: Posterunkowy')
setElementDimension(t, 0)
setElementInterior(t, 0)
setElementPosition(t,-1651.52,712.85,1337.95+1)	
	
local dutyPickup = createPickup(  -1651.52,712.85,1337.95,3,1275,1000 )
local fractionSkin = 275
addEventHandler("onPickupHit",dutyPickup,function (hit)
if hit and getElementType(hit)=="player" then
if getElementData(hit,"player:duty")=="Policja" then
if not getElementData(hit,"player:duty") then
	else
		setElementModel(hit,280)
		setElementData(hit,"temp:fractionduty",fractionVehiclePrefix)
		exports["noti"]:noti("Zmieniasz ubranie służbowe na: Posterunkowy", hit)
	end
else
    exports["noti"]:noti("Zakończ służbę innej frkacji lub pracy urzędowej.")
end
else
    exports["noti"]:noti("Nie należysz do tej frakcji.")

end
end)	




local t=createElement('text')
setElementData(t,'name','Policja\nSkin: OPP')
setElementDimension(t, 0)
setElementInterior(t, 0)
setElementPosition(t,-1648.87,708.96,1337.95+1)	
	
local dutyPickup = createPickup(  -1648.87,708.96,1337.95,3,1275,1000 )
local fractionSkin = 275
addEventHandler("onPickupHit",dutyPickup,function (hit)
if hit and getElementType(hit)=="player" then
if getElementData(hit,"player:duty")=="Policja" then
if not getElementData(hit,"player:duty") then
	else
		setElementModel(hit,281)
		setElementData(hit,"temp:fractionduty",fractionVehiclePrefix)
		exports["noti"]:noti("Zmieniasz ubranie służbowe na: OPP", hit)
	end
else
    exports["noti"]:noti("Zakończ służbę innej frkacji lub pracy urzędowej.")
end
else
    exports["noti"]:noti("Nie należysz do tej frakcji.")

end
end)


local t=createElement('text')
setElementData(t,'name','Policja\nSkin: Kamizelka')
setElementDimension(t, 0)
setElementInterior(t, 0)
setElementPosition(t,-1640.56,709.06,1337.95+1)	
	
local dutyPickup = createPickup(  -1640.56,709.06,1337.95,3,1275,1000 )
local fractionSkin = 275
addEventHandler("onPickupHit",dutyPickup,function (hit)
if hit and getElementType(hit)=="player" then
if getElementData(hit,"player:duty")=="Policja" then
if not getElementData(hit,"player:duty") then
	else
		setElementModel(hit,282)
		setElementData(hit,"temp:fractionduty",fractionVehiclePrefix)
		exports["noti"]:noti("Zmieniasz ubranie służbowe na: Kamizelka", hit)
	end
else
    exports["noti"]:noti("Zakończ służbę innej frkacji lub pracy urzędowej.")
end
else
    exports["noti"]:noti("Nie należysz do tej frakcji.")

end
end)


local t=createElement('text')
setElementData(t,'name','Policja\nSkin: BOA')
setElementDimension(t, 0)
setElementInterior(t, 0)
setElementPosition(t,-1631.04,709.12,1337.95+1)	
	
local dutyPickup = createPickup(  -1631.04,709.12,1337.95,3,1275,1000 )
local fractionSkin = 275
addEventHandler("onPickupHit",dutyPickup,function (hit)
if hit and getElementType(hit)=="player" then
if getElementData(hit,"player:duty")=="Policja" then
if not getElementData(hit,"player:duty") then
	else
		setElementModel(hit,283)
		setElementData(hit,"temp:fractionduty",fractionVehiclePrefix)
		exports["noti"]:noti("Zmieniasz ubranie służbowe na: BOA", hit)
	end
else
    exports["noti"]:noti("Zakończ służbę innej frkacji lub pracy urzędowej.")
end
else
    exports["noti"]:noti("Nie należysz do tej frakcji.")

end
end)