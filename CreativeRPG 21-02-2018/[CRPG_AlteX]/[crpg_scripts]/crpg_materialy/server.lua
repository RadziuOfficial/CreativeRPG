--[[
		Autor: AlteX
		Dla: Creative RPG
		Skrypt: Praca Dorywcza
		Masz jakiś problem kurwa do nas to spierdalaj i nie graj u nas i nie pierdol farmazonów o naszej ekipie.
]]

function outputChatBox_(text,gracz)
	exports["crpg_powiadomienia"]:noti(text,gracz)
end

local vehicles = {
{ -2385.40, -2217.80, 33.43, 359.7, 0.0, 216.7},
}

for _,v in ipairs(vehicles) do
	local vehicle = createVehicle(414,v[1],v[2],v[3],v[4],v[5],v[6])
	setElementFrozen(vehicle,true)
	setVehicleLocked(vehicle,true)
	setVehicleVariant(vehicle,2,2)
	setElementData(vehicle,"pojazdpracy",true)
	setVehicleColor(vehicle,0, 0, 0, 0, 0, 0)
end

object = {}
veh = {}

addEvent("giveObject:buildingjob",true)
addEventHandler("giveObject:buildingjob",root,function(plr)
	if plr then
		object[plr] = createObject(2912,0,0,0,0,0,0)
		setElementCollisionsEnabled(object[plr],false)
		setElementDoubleSided(object[plr],true)
		setObjectScale(object[plr],0.8)
		attachElements(object[plr],plr,0-0.03,0.6,0.32,0,0,0,0)
		setTimer(setPedAnimation,50,1,plr,"CARRY","crry_prtial",1)
	end
end)

addEvent("destroyElement:buildingjob",true)
addEventHandler("destroyElement:buildingjob",root,function(plr)
	if plr then
		if object[plr] and isElement(object[plr]) then
			destroyElement(object[plr])
		end
		setPedAnimation(plr,"CARRY","crry_prtial",1,true,false,true,false)
	end
end)

addEventHandler("onVehicleStartEnter",resourceRoot,function(plr,seat)
	if seat == 0 then
		cancelEvent()
	end
end)

t1 = {}
t2 = {}
t3 = {}

local pv = {
{-2372.88, -2194.67, 33.53, 0.6, 359.7, 295.2}, 
}

addEvent("stworzpojazdkurier",true)
addEventHandler("stworzpojazdkurier",root,function(plr)
	if plr then
		local rnd = math.random(1,#pv)
		veh[plr] = createVehicle(505,pv[rnd][1],pv[rnd][2],pv[rnd][3],pv[rnd][4],pv[rnd][5],pv[rnd][6],"Kurierek")
		setVehicleVariant(veh[plr],2,2)
		setVehicleColor(veh[plr],0, 0, 0, 0, 0, 0)
		setVehicleLocked(veh[plr],true)
		fadeCamera(plr,false)
		warpPedIntoVehicle(plr,veh[plr])
		t1[plr] = setTimer(function()
			fadeCamera(plr,true)
			setElementFrozen(plr,false)
		end,2000,1)
		outputChatBox_("Pomyślnie załadowano wszystkie skrzynie, dostarcz ładunek do kopalni. (PUNKT C NA MAPIE)",plr,0,255,0,true)
	end
end)

addEvent("destroyVehicle:buildingjob",true)
addEventHandler("destroyVehicle:buildingjob",root,function(plr)
	if plr then
		if veh[plr] and isElement(veh[plr]) then
			t2[plr] = setTimer(function()
				destroyElement(veh[plr])
				if t2[plr] and isTimer(t2[plr]) then killTimer(t2[plr]) end
			end,1000,1)
		end
		setElementData(plr,"player:job:materialy:etap",false)
		setElementData(plr,"player:job",false)
	end
end)



addEventHandler("onPlayerQuit",root,function()
	if getElementData(source,"login") == getPlayerName(source) then
		triggerEvent("destroyElement:buildingjob",source,source)
	end
end)


function isVehicleEmpty(vehicle)
	if not isElement(vehicle) or getElementType(vehicle) ~= "vehicle" then return true end
	local passengers = getVehicleMaxPassengers(vehicle)
	if type(passengers) == "number" then
		for seat = 0, passengers do
			if getVehicleOccupant(vehicle,seat) then return false end
		end
	end
	return true
end

setTimer(function()
	for _,v in ipairs(getElementsByType("vehicle",resourceRoot)) do
		if isVehicleEmpty(v) then
			if getElementData(v,"pojazdpracy") == false then
				destroyElement(v)
			end
		end
	end
end,15000,0)

addEventHandler("onVehicleExit",resourceRoot,function(plr,seat)
	if seat == 0 then
		if veh[plr] and isElement(veh[plr]) and isVehicleEmpty(veh[plr]) then
			destroyElement(veh[plr])
			setElementData(plr,"player:job",false)
			setElementData(plr,"player:job:materialy:etap",false)
		end
	end
end)