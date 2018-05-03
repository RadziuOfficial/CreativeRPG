


function getVehicleHandlingProperty ( element, property )
if isElement ( element ) and getElementType ( element ) == "vehicle" and type ( property ) == "string" then
local handlingTable = getVehicleHandling ( element )
local value = handlingTable[property]
if value then
return value
end
end
return false
end
local Kolory = {
	[1]= {
     {59,59,59},
	},
	[2]= {
     {0,0,0},
	},
	[3]= {
     {255,255,255},
	},
	[4]= {
     {255,0,0},
	},
	[5]= {
     {0,0,255},
	},
	[6]= {
     {100,100,0},
	},

}

local miejsca = {1,2,3,4,5,6}



local pojazdy = { ----- KEDECI RADIOLE
		{426,1526.62,-1643.97,5.63,0.0,360.0,178.5,},
		{604,1545.08,-1658.85,5.71,0.1,0.0,88.3},
		{426,1530.65,-1643.86,5.63,0.0,0.0,179.7},
		{482,1534.66,-1643.93,6.01,359.2,0.0,180.2},
		{560,1538.67,-1643.64,5.60,359.9,360.0,180.2},
		{421,1545.23,-1651.07,5.77,0.0,360.0,90.1},
		{421,1545.22,-1655.04,5.77,360.0,360.0,89.3},
		{597,1601.78,-1683.85,5.66,359.7,0.0,89.0},
		{597,1601.78,-1687.91,5.66,359.7,0.0,89.1},
		{597,1601.78,-1692.03,5.66,359.7,0.0,89.7},
		{597,1601.78,-1695.97,5.66,359.7,360.0,90.1},
		{598,1601.84,-1700.20,5.70,360.0,0.0,88.5},
		{598,1601.83,-1704.24,5.70,360.0,0.0,89.3},
		{598,1595.43,-1710.86,5.70,360.0,0.0,359.4},
		------ BOA
		{579,1062.62,-1775.45,13.28,359.4,0.2,269.8},
		{579,1062.54,-1769.64,13.30,359.3,0.2,270.0},
		{427,1083.33,-1772.61,13.48,0.0,0.2,269.5},
		{601,1083.44,-1754.90,13.15,359.9,0.2,270.3},
		{490,1062.81,-1763.72,13.52,0.3,0.3,269.8},
		{490,1062.83,-1757.88,13.54,0.2,0.3,270.2},
		{487,1061.99,-1786.04,13.81,0.3,359.8,89.4},-- Maxerick
		{418,1062.60,-1752.00,13.54,359.9,0.3,270.1},
		{418,1062.48,-1746.16,13.55,0.0,0.1,270.4},
		{560,1062.25,-1740.24,13.18,360.0,0.2,270.4},
		{604,1098.61,-1769.71,13.16,0.1,360.0,91.4},
		{490,1544.81,-1663.26,6.02,0.4,360.0,90.4},
		{482,1098.89,-1763.79,13.47,359.2,360.0,90.1}--Burek
}

for i,v in pairs(pojazdy) do
	local vehicle=createVehicle(v[1], v[2], v[3],v[4],v[5],v[6],v[7])

	setVehicleEngineState(vehicle, false)
	setElementFrozen(vehicle, true)
	setElementData(vehicle,"vehicle:police", true)
	setVehiclePlateText(vehicle,"N 00"..i)
	--setElementData(vehicle,"vehicle:desc",v[8] or "")
	local nzwa = math.random(1,#miejsca)
	local allKolory = Kolory[nzwa]
        if v[1] == 604 or v[1] == 418 or v[1] == 487 or v[1] == 490 or v[1] == 601 or v[1] == 482 or v[1] == 579 then
	setVehicleColor(vehicle,0,0,0,0,0,0)
	setVehiclePlateText(vehicle,"SA134"..i)
	end
	if v[2] == 1098.89 then
	setVehiclePlateText(vehicle,"SA134"..i)
	end
	if v[1] == 597 then
	setVehicleColor(vehicle,59,59,59,59,59,59)
	setVehicleHandling(vehicle, "maxVelocity", getVehicleHandling ( vehicle ).maxVelocity + 300 )
    setVehicleHandling(vehicle, "mass", getVehicleHandling ( vehicle ).mass + 500 )
    setVehicleHandling(vehicle, "driveType", "awd")
	setVehicleHandling(vehicle, "ABS")
    setVehicleHandling(vehicle,"engineAcceleration",15)
	end
	if v[1] == 490 then
	setVehicleColor(vehicle,59,59,59,59,59,59)
		local engineacc = getVehicleHandlingProperty(vehicle,"engineAcceleration")
    setVehicleHandling(vehicle,"engineAcceleration",tonumber(engineacc)+2)
	setVehicleHandling(vehicle, "maxVelocity", getVehicleHandling ( vehicle ).maxVelocity + 300 )
    setVehicleHandling(vehicle, "driveType", "awd")
	setVehicleHandling(vehicle, "ABS")
    setVehicleHandling(vehicle,"engineAcceleration",15)
	end
	
	
	
	
	if v[1] == 598 then
	setVehicleColor(vehicle,59,59,59,59,59,59)
	setVehicleHandling(vehicle, "maxVelocity", getVehicleHandling ( vehicle ).maxVelocity + 200 )
    setVehicleHandling(vehicle, "driveType", "awd")
    setVehicleHandling(vehicle,"engineAcceleration",13)
	end  --507
	if v[1] == 421 then
	for key, value in ipairs(allKolory) do
	setVehicleColor(vehicle,value[1],value[2],value[3])
    end
	setVehicleHandling(vehicle, "maxVelocity", getVehicleHandling ( vehicle ).maxVelocity + 300 )
    setVehicleHandling(vehicle, "mass", getVehicleHandling ( vehicle ).mass + 700 )
    setVehicleHandling(vehicle, "driveType", "awd")
    setVehicleHandling(vehicle,"engineAcceleration",17)
	setVehicleHandling(vehicle,"tractionMultiplier",1)
	
	end
	if v[1] == 426 then
	for key, value in ipairs(allKolory) do
	setVehicleColor(vehicle,value[1],value[2],value[3])
    end
	setVehicleHandling(vehicle, "maxVelocity", getVehicleHandling ( vehicle ).maxVelocity + 300 )
    setVehicleHandling(vehicle, "mass", getVehicleHandling ( vehicle ).mass + 500 )
    setVehicleHandling(vehicle, "driveType", "awd")
    setVehicleHandling(vehicle,"engineAcceleration",16)
	end --404
	if v[2] == 1534.66 then
	for key, value in ipairs(allKolory) do
	setVehicleColor(vehicle,value[1],value[2],value[3])
    end
	setVehicleHandling(vehicle, "maxVelocity", getVehicleHandling ( vehicle ).maxVelocity + 300 )
    setVehicleHandling(vehicle, "mass", getVehicleHandling ( vehicle ).mass + 500 )
    setVehicleHandling(vehicle, "driveType", "awd")
    setVehicleHandling(vehicle,"engineAcceleration",16)
	setVehicleHandling(vehicle, "ABS")	

	

	end --404
	if v[2] == 1538.67 then
	for key, value in ipairs(allKolory) do
	setVehicleColor(vehicle,value[1],value[2],value[3])
    end
	local engineacc = getVehicleHandlingProperty(vehicle,"engineAcceleration")
local velocity = getVehicleHandlingProperty(vehicle,"maxVelocity")
setVehicleHandling(vehicle,"maxVelocity",tonumber(velocity)+600)
setVehicleHandling(vehicle,"engineAcceleration",tonumber(engineacc)+9)
 	setVehicleHandling(vehicle, "mass", getVehicleHandling ( vehicle ).mass + 1000 )
setVehicleHandling(vehicle, "ABS")	
setVehicleHandling(vehicle, "driveType","awd")	
setElementData(vehicle,"SAPD:EMC",true)
	end
	if v[2] == 1062.25 then
	setVehicleColor(vehicle,0,0,0)
	local engineacc = getVehicleHandlingProperty(vehicle,"engineAcceleration")
local velocity = getVehicleHandlingProperty(vehicle,"maxVelocity")
setVehicleHandling(vehicle,"maxVelocity",tonumber(velocity)+600)
setVehicleHandling(vehicle,"engineAcceleration",tonumber(engineacc)+7)
 	setVehicleHandling(vehicle, "mass", getVehicleHandling ( vehicle ).mass + 500 )
setVehicleHandling(vehicle, "ABS")	
setVehicleHandling(vehicle, "driveType","awd")	
	end
	
end

addEventHandler("onVehicleEnter", resourceRoot, function(plr,seat,jacked)
	if seat == 0 then
		setElementFrozen(source,false)
		setElementData(source,"use:player",true)
		triggerClientEvent(plr,"onClientAddNotification",plr,"Zostawianie pojazdów frakcyjnych może skutować banicją konta!","info")
		triggerClientEvent(plr,"onClientAddNotification",plr,"Wszedłeś/aś do pojazdu frakcyjnego, dbaj o niego i odstaw na miejsce!","info")
	end
end)

setTimer(function()
 	for i,vehicle in pairs(getElementsByType("vehicle", resourceRoot)) do
		local x,y,z = getElementPosition(vehicle)
		local r1,r2,r3 = getElementRotation(vehicle)
		setVehicleRespawnPosition(vehicle,x,y,z,r1,r2,r3)
		toggleVehicleRespawn(vehicle,true)
		setVehicleIdleRespawnDelay(vehicle,3600000)
		setVehicleHandling(vehicle, "driveType", "awd")
		setElementData(vehicle,"vehicle:duty","Policja")
								 setElementData(vehicle, "vehicle:fuel", 300)
		 setElementData(vehicle, "vehicle:BezynaWloczone", true)
           			setElementData(vehicle,"vehicle:bak",300) 
  	end
end,1000,1)





-- Zsynchronizowana do licznika przez ~Yolos
function setElementSpeed(element, speed)
	if (speed == nil) then speed = 0 end
	speed = tonumber(speed)
	local vx,vy,vz = getElementVelocity(element)
	local acSpeed = ((vx^2+vy^2+vz^2)^(0.5))*180
	local diff = speed/acSpeed
	if diff ~= diff then return end -- if the number is a 'NaN' return end.
	local x,y,z = getElementVelocity(element)
	setElementVelocity(element,x*diff,y*diff,z*diff)
	return true
end

function policeslow(el,md)
	if getElementType ( el ) ~= "vehicle" then return end
	if not getVehicleOccupant(el, 0) then return end
	setElementSpeed(el, 5)
	setElementFrozen(el,true)
end


function bindHoron( player)
    if isPedInVehicle( player ) then
		if getElementData(getPedOccupiedVehicle(player),"vehicle:police") then
			setElementData(getPedOccupiedVehicle(player),"vehicle:desc", "ZATRZYMAJ SIĘ POLICJA!\nSTOP POLICE!")
			local theMarker = createMarker ( 0, 0, 0, "cylinder", 7, 0, 255, 0, 25 )
			attachElements(theMarker, getPedOccupiedVehicle(player), 0, -7.3, -2)
			addEventHandler("onMarkerHit", theMarker, policeslow)
			setTimer(function()
			destroyElement (theMarker)
			end, 2000, 1)
        end
    end
end

function bindHoron2( player)
    if isPedInVehicle( player ) then
		if getElementData(getPedOccupiedVehicle(player),"vehicle:police") then
            removeElementData(getPedOccupiedVehicle(player),"vehicle:desc")
        end
    end
end
-- odmrażamy pojazdy pociagniete holownikiem!
function detachTrailer(theTruck)
    setElementFrozen(source, false)
 end
addEventHandler("onTrailerAttach", getRootElement(), detachTrailer)