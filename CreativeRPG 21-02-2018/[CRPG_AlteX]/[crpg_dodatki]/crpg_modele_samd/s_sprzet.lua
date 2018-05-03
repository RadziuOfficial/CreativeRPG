
addEvent("PRszyny",true)
addEventHandler("PRszyny",root,function(el)
		if not getElementData(el,"prm:item:szyny") then
		local x,y,z = getElementPosition( el )
		local object = createObject(3911,x,y,z)
		exports.bone_attach:attachElementToBone(object,el,12,0,0,0.22,180,0)
		setElementData(el,"prm:item:szyny",object)
		exports["noti"]:noti("Wyciągasz szyny kramera z ambulansu.", el)
	else
		destroyElement(getElementData(el,"prm:item:szyny"))
		exports["noti"]:noti("Chowasz szyny kramera do ambulansu.", el)
		setElementData(el,"prm:item:szyny",nil)
	end
end)




addEvent("PRtorba",true)
addEventHandler("PRtorba",root,function(el)
		if not getElementData(el,"prm:item:torba") then
		local x,y,z = getElementPosition( el )
		local object = createObject(1248,x,y,z)
		exports.bone_attach:attachElementToBone(object,el,12,0.02,0.1,0.3,0,180,0)
		setElementData(el,"prm:item:torba",object)
		exports["noti"]:noti("Wyciągasz torbę medyczną z ambulansu.", el)
	else
		destroyElement(getElementData(el,"prm:item:torba"))
		exports["noti"]:noti("Chowasz torbę medyczną do ambulansu.", el)
		setElementData(el,"prm:item:torba",nil)
	end
end)

addEvent("PRdeska",true)
addEventHandler("PRdeska",root,function(el)
		if not getElementData(el,"prm:item:deska") then
		local x,y,z = getElementPosition( el )
		local object = createObject(1998,x,y,z)
		
		exports.bone_attach:attachElementToBone(object,el,12,0.2,-0.1,0.4,90,90,90)
		setElementData(el,"prm:item:deska",object)
		setElementScale(el,0.8)
		exports["noti"]:noti("Wyciągasz z karetki deskę ortopedyczną.", el)
	else
		destroyElement(getElementData(el,"prm:item:deska"))
		exports["noti"]:noti("Chowasz deskę ortopedyczną do ambulansu.", el)
		setElementData(el,"prm:item:deska",nil)
	end
end)


--out
addEvent("PRnosze",true)
addEventHandler("PRnosze",root,function(el)
		if not getElementData(el,"prm:item:nosze") then
		local x,y,z = getElementPosition( el )
		local object = createObject(1943,x,y,z)
		attachElements ( object, el, 0, 1, -1,0,0,180)
        setElementData(object,"prm:item:nosze",el)
		setElementData(el,"prm:item:nosze",object)
		setElementScale(object,1.3)
		exports["noti"]:noti("Wysuwasz nosze z ambulansu.", el)
	else
		destroyElement(getElementData(el,"prm:item:nosze"))
		exports["noti"]:noti("Chowasz nosze do ambulansu.", el)
		setElementData(el,"prm:item:nosze",nil)
	end
end)




local PacjeciNaDesce = {}


function onPoliceQuit(veh)
if getElementData(source,"temp:tased") then
removePedFromVehicle( getElementData(source,"temp:tased") )
attachElements(getElementData(source,"temp:tased"),source,1,0,0,0,0,0)
end
end
  
function naNosze(taseplayer2,client,pomocnik)
	if not PacjeciNaDesce[taseplayer2] and not PacjeciNaDesce[pomocnik] then
	local object = createObject(1998,0,0,0)
	setElementData(taseplayer2,"prm:item:deskaNA",object)
	PacjeciNaDesce[taseplayer2] = true
	PacjeciNaDesce[pomocnik] = true

    rot1,rot2,rot3 = getElementRotation(client)
	attachElementToElement(object, client,0,0.9,-0.3,0,0,90)
	attachElementToElement(pomocnik, client,0,3,0,0,0,180)
	attachElementToElement(taseplayer2, client,0,1.2,0.9,0,0,0)
	setElementData(client,"temp:tased",taseplayer2)
	setElementCollisionsEnabled( taseplayer2, false )
	exports["noti"]:noti("Przenosisz gracza na nosze.", client)
	exports["noti"]:noti("Zostałeś przeniesiony na nosze przez ratownika medycznego.", taseplayer2)
	setPedAnimation ( taseplayer2, "CRACK", "crckidle4", -1, true, false )
else
	PacjeciNaDesce[taseplayer2] = false
	detachElements( taseplayer2 )
	PacjeciNaDesce[pomocnik] = false
	detachElements( pomocnik )
	setElementData(client,"temp:tased",nil)
	setElementCollisionsEnabled( taseplayer2, true )
	setPedAnimation(taseplayer2)
	destroyElement(getElementData(taseplayer2,"prm:item:deskaNA"))
    exports["noti"]:noti("Chowasz deskę ortopedyczną do ambulansu.", taseplayer2)
    setElementData(taseplayer2,"prm:item:deskaNA",nil)
end
end

addCommandHandler("deska",function (client,cmd,target,pomocnik)
	if getElementData(client,"player:duty")=="PR" or getElementData(client,"player:duty")=="PSP" then 
	if target and getPlayerFromName(target) and pomocnik and getPlayerFromName(pomocnik) then
		target = getPlayerFromName( target )
		pomocnik = getPlayerFromName( pomocnik )
		if not PacjeciNaDesce[target] then
		    removePedFromVehicle( target )
			removePedFromVehicle( pomocnik )
			naNosze(target,client,pomocnik)
			addEventHandler("onPlayerVehicleEnter",client,onPoliceEnter,false)
			addEventHandler("onPlayerVehicleExit",client,onPoliceQuit,false)
		else
			naNosze(target,client,pomocnik)
			removeEventHandler("onPlayerVehicleEnter",client,onPoliceEnter,false)
			removeEventHandler("onPlayerVehicleExit",client,onPoliceQuit,false)
		end
	end
	end

	end)

---------------------------
---------------------------
local PacjeciNaNoszach = {}


  
function tasePlayer2(taseplayer2,client)
	if not PacjeciNaNoszach[taseplayer2] then
	PacjeciNaNoszach[taseplayer2] = true
	setElementFrozen(taseplayer2)
    rot1,rot2,rot3 = getElementRotation(client)
	attachElementToElement( taseplayer2, client, 0, 1, 1,0,0,180)
	setElementData(client,"temp:tased",taseplayer2)
	setElementCollisionsEnabled( taseplayer2, false )
	exports["noti"]:noti("Przenosisz gracza na nosze.", client)
	exports["noti"]:noti("Zostałeś przeniesiony na nosze przez ratownika medycznego.", taseplayer2)
	setPedAnimation ( taseplayer2, "CRACK", "crckidle4", -1, true, false )
else
	PacjeciNaNoszach[taseplayer2] = false
	detachElements( taseplayer2 )
	setElementData(client,"temp:tased",nil)
	setElementCollisionsEnabled( taseplayer2, true )
	setPedAnimation(taseplayer2)
end
end

addCommandHandler("nosze",function (client,cmd,target)
	if getElementData(client,"player:duty")=="PR" or getElementData(client,"player:duty")=="PSP" then 
	if target and getPlayerFromName(target) then
		target = getPlayerFromName( target )
		if not PacjeciNaNoszach[target] then
		    removePedFromVehicle( target )
			tasePlayer2(target,client)
			addEventHandler("onPlayerVehicleEnter",client,onPoliceEnter,false)
			addEventHandler("onPlayerVehicleExit",client,onPoliceQuit,false)
		else
			tasePlayer2(target,client)
			removeEventHandler("onPlayerVehicleEnter",client,onPoliceEnter,false)
			removeEventHandler("onPlayerVehicleExit",client,onPoliceQuit,false)
		end
	end
	end

	end)
	---------------------------------
	---------------------------------
	
	
local t=createElement('text')
setElementData(t,'name','Pogotowie ratunkowe\nSkin: Ratownik medyczny')
setElementDimension(t, 0)
setElementInterior(t, 0)
setElementPosition(t,1147.29,-1308.18,13.6+1)	
	
local dutyPickup = createPickup(  1147.29,-1308.18,13.68,3,1275,1000 )
local fractionSkin = 275
addEventHandler("onPickupHit",dutyPickup,function (hit)
if hit and getElementType(hit)=="player" then
if getElementData(hit,"player:duty")=="PR" then
if not getElementData(hit,"player:duty") then
	else
		setElementModel(hit,275)
		setElementData(hit,"temp:fractionduty",fractionVehiclePrefix)
		exports["noti"]:noti("Zmieniasz ubranie służbowe na: Ratownik medyczny", hit)
	end
else
    exports["noti"]:noti("Zakończ służbę innej frkacji lub pracy urzędowej.")
end
else
    exports["noti"]:noti("Nie należysz do tej frakcji.")

end
end)	
	
	
---------------------------

local t=createElement('text')
setElementData(t,'name','Pogotowie ratunkowe\nSkin: Lekarz pogotowia')
setElementDimension(t, 0)
setElementInterior(t, 0)
setElementPosition(t,1147.32,-1304.65,13.67+1)	
	
local dutyPickup = createPickup(  1147.32,-1304.65,13.67,3,1275,1000 )
local fractionSkin = 275
addEventHandler("onPickupHit",dutyPickup,function (hit)
if hit and getElementType(hit)=="player" then
if getElementData(hit,"player:duty")=="PR" then
if not getElementData(hit,"player:duty") then
	else
		setElementModel(hit,267)
		setElementData(hit,"temp:fractionduty",fractionVehiclePrefix)
		exports["noti"]:noti("Zmieniasz ubranie służbowe na: Lekarz pogotowia", hit)
	end
else
    exports["noti"]:noti("Zakończ służbę innej frkacji lub pracy urzędowej.")
end
else
    exports["noti"]:noti("Nie należysz do tej frakcji.")

end
end)
	
	
local t=createElement('text')
setElementData(t,'name','Pogotowie ratunkowe\nSkin: Lekarz SOR')
setElementDimension(t, 0)
setElementInterior(t, 0)
setElementPosition(t,1149.29,-1299.87,13.69+1)	
	
local dutyPickup = createPickup( 1149.29,-1299.87,13.69,3,1275,1000 )
local fractionSkin = 275
addEventHandler("onPickupHit",dutyPickup,function (hit)
if hit and getElementType(hit)=="player" then
if getElementData(hit,"player:duty")=="PR" then
if not getElementData(hit,"player:duty") then
	else
		setElementModel(hit,70)
		setElementData(hit,"temp:fractionduty",fractionVehiclePrefix)
		exports["noti"]:noti("Zmieniasz ubranie służbowe na: Lekarz SOR", hit)
	end
else
    exports["noti"]:noti("Zakończ służbę innej frkacji lub pracy urzędowej.")
end
else
    exports["noti"]:noti("Nie należysz do tej frakcji.")

end
end)	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	