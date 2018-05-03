local code="Zrzut"
local jobOnline=true -- czy praca włączona
local jobMarker=createMarker(1348.49, 1259.03, 10.82-1, "cylinder", 1.2, 255, 0, 0, 40) -- marker
createBlip(1348.49, 1259.03, 10.82, 46,2,0,0,0,0,0,275)
local jobVehicle={593, 1278.93, 1324.53, 11.28, 359.5, 360.0, 270} -- gdzie ma być spawnowany pojazd 
local zone = createColCuboid(1265.6603, 1312.3411, 9.5703125, 24.5, 24.5, 5.25)

local jobText=createElement("text")
setElementPosition(jobText, 1348.49, 1259.03, 10.82)
setElementData(jobText, "name", "Zrzut spadochroniarzy\nWymagania: 1500RP, kat. L!")

addCommandHandler("rozpocznij", function(plr,cmd)
	if not isElementWithinMarker(plr,jobMarker) then return end
	if jobOnline == false then
		exports["1"]:outputNotificationBox (plr, "#cc0000Praca jest wyłączona!")
		return
	end
	
	if getElementData(plr,"player:job") then
		exports["1"]:outputNotificationBox (plr, "#cc0000Posiadasz aktywną pracę!")
		return
	end
	
	 if getElementData(plr,"player:license:pjL") ~= 1 then
		exports["1"]:outputNotificationBox (plr, "#cc0000Aby tu pracować musisz mieć licencję pilota!")
		return
	end
	
	if getElementData(plr,"player:reputation") < 1500 then
		exports["1"]:outputNotificationBox (plr, "#cc0000Aby tu pracować musisz mieć 1500RP!")
		return
	end

	if #getElementsWithinColShape(zone,"vehicle") >= 1 then 
		exports["1"]:outputNotificationBox (plr, "#cc0000Miejsce spawnu zajęte!") 
		return 
	end
	
	local veh=createVehicle(jobVehicle[1], jobVehicle[2], jobVehicle[3], jobVehicle[4], jobVehicle[5], jobVehicle[6], jobVehicle[7])
	setElementData(veh,"vehicle:desc","Zrzut spadochroniarzy")
	setElementData(veh,"vehicle:mileage", 1500)
	setElementData(veh,"vehicle:fuel",100)
	warpPedIntoVehicle(plr,veh)
	setElementData(plr, "player:job", code)
	triggerClientEvent(plr, "startJob", resourceRoot, veh)
end)

addEventHandler("onMarkerHit", jobMarker, function(el,md)
	if getElementType(el) == "player" then
		if isPedInVehicle(el) then return end
		exports["1"]:outputNotificationBox (el, "#00cc00Aby rozpocząć pracę wpisz #00cccc/rozpocznij")
	end
end)








addEvent("DropPed",true)
addEventHandler("DropPed", resourceRoot, function(veh)
local thePed = getElementData(veh,"ped")
if not thePed then return end
removePedFromVehicle(thePed)
giveWeapon(thePed,46,1,true)
setElementHealth(thePed,1)
setElementCollisionsEnabled(thePed,false)
setTimer(function(thePed) if isElement(thePed) then destroyElement(thePed)  end end,3000,1)
end)
addEventHandler("onPedWasted", resourceRoot, function() destroyElement(source) end)

addEvent("DestroyPed",true)
addEventHandler("DestroyPed", resourceRoot, function(veh)
local thePed = getElementData(veh,"ped")
if not ThePed then return end
destroyElement(thePed)
end)


addEventHandler("onVehicleExplode", resourceRoot, function()
	if getElementModel(source) ~= 593 then return end
	destroyElement(source)
end)

addEventHandler("onElementDestroy",resourceRoot,function() 
  if getElementType(source) == "vehicle" then
   if getVehicleOccupant(source,1) then
		destroyElement(getVehicleOccupant(source,1))
		end
   end
end)



addEventHandler ( "onVehicleStartEnter", resourceRoot, function(p,s,_) 
if s ~= 0 then cancelEvent()
return end
end)