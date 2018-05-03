--[[
For: Jakub Gryglewicz / SuperMan.
Author: Haze
Skype: zmuda20011
zmuda20011@gmail.com
Wszelkie prawa autorskie naleza do autora, czyli mnie, dalsze rozposzechnianie zasobu jest karalne wedlug prawa polskiego o prawie autorskim.
]]
deska={}
function getPointFromDistanceRotation(x, y, dist, angle)

    local a = math.rad(90 - angle);
 
    local dx = math.cos(a) * dist;
    local dy = math.sin(a) * dist;
 
    return x+dx, y+dy;
 
end

function createDeska(plr, pomocnik, naDesce)
	setElementData(plr, "deskaInterakcja", true)
	setElementData(pomocnik, "deskaInterakcja", true)
	setElementData(naDesce, "deskaInterakcja", true)
	element = createElement("deska")
	x, y, z = getElementPosition(plr)
	_,_,rot = getElementRotation(plr)
	x,y = getPointFromDistanceRotation(x,y,2,-rot)
	deska[plr] = createObject(2146, x,y,z)
	attachElements(deska[plr], plr,0,1.1,0,0,0,90)
	attachElements(pomocnik, plr,0,3.4,0,0,0,180)
	attachElements(naDesce, plr,0,2,1,0,0,0)
	setElementData(element, "deska", deska[plr])
	setElementData(element, "pomocnik", pomocnik)
	setElementData(element, "plr", plr)
	setElementData(element, "naDesce", naDesce)
end


addCommandHandler("deska",function(plr,cmd,pomocnik,kogo)
pomocnik = getPlayerFromName(pomocnik)
naDesce = getPlayerFromName(kogo)
	if pomocnik and naDesce then
		x, y, z = getElementPosition(plr)
		xp, yp, zp = getElementPosition(pomocnik)
		xk, yk, zk = getElementPosition(naDesce)
		if getDistanceBetweenPoints3D (x, y, z, xp, yp, zp) < 10 and getDistanceBetweenPoints3D (x, y, z, xk, yk, zk) < 10 then
			createDeska(plr, pomocnik, naDesce)
		end
	end
end)

addCommandHandler("deskadol",function(plr,cmd)
if getElementData(plr, "deska")
	for k,v in pairs(getElementsByType("deska")) do
		if getElementData(v, "plr") == plr then
			for a,asd in pairs(getAttachedElements(plr)) do
				detachElements(asd, plr)
			end
			destroyElement(v)
			destroyElement(deska[plr])
		end
	end
end)
