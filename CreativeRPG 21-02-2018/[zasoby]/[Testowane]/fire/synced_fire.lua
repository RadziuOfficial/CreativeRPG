local fireModel = 2023
local fires = {}
addEvent("onFireExtinguished",true)
addEvent("onFireCreate",true)


local function isFireNearby(x,y,z)	-- todo d,i
  local cs=createColSphere(x,y,z,3)
  local obiekty=getElementsWithinColShape(cs, "object")
  destroyElement(cs)
  for i,v in ipairs(obiekty) do
	  if (getElementModel(v)==fireModel) then return true end
  end
  return false
end

function createFire(x,y,z,d,i)
	if (isFireNearby(x,y,z,d,i)) then return nil end
	local fireElem = createObject(fireModel,x,y,z)
	setElementCollisionsEnabled(fireElem,false)
	local col = createColSphere(x,y,z+1,2)
	setElementParent(col, fireElem)
	setElementData(fireElem, "ts", getTickCount(), false)
	setElementData(fireElem,"fire:Endvalue",math.random(40,80)) 
	local blip = createBlipAttachedTo ( fireElem, 0, 2, 0, 0, 0, 255, 0, 275.0, root )
	fires[fireElem] = {fireElem,col,blip}
	addEventHandler("onColShapeHit",col,setFire)
	if (d) then
	  setElementDimension(fireElem, d)
	  setElementDimension(col, d)
	end
	if (i) then
	  setElementInterior(fireElem, i)
	  setElementInterior(col, i)
	end
	return fireElem
end

function setFire(elem,dim)
	if not dim then return end
	if not elem or not isElement(elem) then return end
	if getElementType(elem) == "player" then
		setPedOnFire(elem,true)
	end
end

function setFire(elem,dim)
	if not dim then return end
	if not elem or not isElement(elem) then return end
	if getElementType(elem) == "vehicle" then
		setElementHealth(elem,299)
	end
end

function fireExtinguished(fireElem) 
    if (not fires[fireElem]) then return end
    local firedValue = getElementData(fireElem,"fire:Endvalue")
    setElementData(fireElem,"fire:Endvalue",firedValue-math.random(3,10))  
    if firedValue <= 0 then
    destroyElement(fires[fireElem][1])
	destroyElement(fires[fireElem][3])
    fires[fireElem] = nil
	triggerEvent("onFireExtinguished",client,client)
    end
end
addEvent("fireExtinguished",true)
addEventHandler("fireExtinguished",root,fireExtinguished)



addEventHandler("onDebugMessage", getRootElement(), 
function(message, level, file, line)
if file == "synced_fire" then
cancelEvent()
end
end)

local fireLocations =
{
    {-1148.86,-1031.26,129.22},
	{-1150.14,-1003.85,129.22},
	{-1127.45,-1012.10,129.22},
	{-1133.84,-1026.84,129.22},
	{-1141.36,-1019.60,129.22},
	{-1135.29,-989.61,129.22},
	{-1145.39,-1013.93,129.22},
	{-1122.81,-1017.50,129.22},
	{-1115.16,-994.44,129.22},
	{-2420.11,1218.92,35.81},
	{-2427.68,1229.09,35.57},
	{-2440.35,1236.08,35.30},
	{-2437.95,1216.83,35.23},
	{-2428.14,1222.83,35.78},
	{-2471.34,-2192.19,30.66},
	{-2478.93,-2177.30,33.79},
	{-2461.01,-2180.22,32.27},
	{-2463.48,-2193.12,29.45},
	{-2476.22,-2201.12,29.13},
	{761.20,-1447.59,13.15},
	{760.86,-1459.36,12.83},
	{754.05,-1454.76,11.43},
	{751.33,-1441.07,12.62},
	{740.71,-1431.08,13.52},
	{730.04,-1439.20,13.54},
	{722.05,-1433.85,13.54},
	{710.91,-1422.34,13.53},
	{700.39,-1433.18,13.54},
	{711.93,-1445.95,17.70},
	{722.62,-1441.66,17.70},
	{1039.70,821.49,10.73},
	{1050.50,834.98,11.01},
	{1036.75,841.72,11.31},
	{1023.46,830.03,10.96},
	{1021.67,810.98,10.75},
	{1041.91,808.37,10.72},
	{1066.99,860.38,10.83},
	{1042.56,851.76,11.53},
	{1019.22,839.77,11.19},
	{1008.53,827.07,10.90},
	{1010.79,817.63,10.82},
	{-102.63,1367.40,10.27},
    {-106.56,1374.93,10.27},
	{-101.39,1362.44,10.27},
	{-97.79,1368.82,13.52},
	{-94.41,1379.79,14.49},
	{-89.56,1377.34,13.95},
	{-87.55,1383.03,10.27},
	{-84.14,1368.65,10.27},
	{-89.43,1367.95,14.38},
	{-96.88,1363.98,12.43},
	
	
}
 
function unpackFires ()
    return unpack ( fireLocations [ math.random ( #fireLocations ) ] )
end
 
function scriptCreateFire ( player, command )
 --     destroyElement ( fireBlip )
	  if isFireFighter == false then return end
      local x, y, z = unpackFires() 
      fire = createFire( x, y, z)
end
setTimer(scriptCreateFire, 60000 * 5, 0)



local function extinguishExpiredFires()
  for i,v in ipairs(getElementsByType("object", resourceRoot)) do
    local ts=getElementData(v,"ts")
    if (ts and getTickCount()-ts<1000*3600*6) then
	if isElement(fires[fireElem][1]) then
    destroyElement(fires[fireElem][1])
	end
	if isElement(fires[fireElem][3]) then
	destroyElement(fires[fireElem][3])
	end
    fires[fireElem] = nil
    end
  end
end
setTimer(extinguishExpiredFires, 1000*3600, 0)


function isFireFighter()
local result = false
	for i,element in ipairs(getElementsByType("player")) do
		if (getElementData(element,"player:duty") == "PSP")then
			result = true
		end
   end
return result
end