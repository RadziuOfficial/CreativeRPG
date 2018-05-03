
-- Settings
local thePed
local missionBlip
local missionMarker    
local missionVehicle
local money = 2000
local code="Transport spadochroniarzy"
local missionPoints={ 
   {1019, 2648, 200},
{69, 800, 200},
{2671, 941, 200},
{2823, 2783, 200},
{-924, 2677, 200},
}



local missionZaladunek=createMarker(1303.3, 1300.68, 10.82-1,"cylinder",5,0,255,255,20)

local jobText=createElement("text")
setElementPosition(jobText, 1303.3, 1300.68, 10.82)
setElementData(jobText, "name", "Odbiór spadochroniarzy")

function finishJob(plr,value1,value2)
	if plr ~= getLocalPlayer() then return end
	if getElementData(localPlayer,"player:job") ~= code then return end
	if value1 == true then
		if isElement(missionMarker) and missionMarker then
			destroyElement(missionMarker)
			missionMarker=nil
		end
		if isElement(missionBlip) and missionBlip then
			destroyElement(missionBlip)
			missionBlip=nil
		end
	end
	if value2 == true then
		if isElement(missionVehicle) and missionVehicle then
			triggerServerEvent("destroyVehicle", root, missionVehicle)
			missionVehicle=nil
		end
	end
end

function showNextPoint(el,md)
	if not md or el~=localPlayer then return end
	local veh=getPedOccupiedVehicle(el)
	if not veh then return end
	if getVehicleController(veh) ~= localPlayer then return end
	finishJob(el,true,false)
	exports["1"]:outputNotificationBox ("#00ccccSpadochroniarz skacze")
	triggerServerEvent("DropPed",resourceRoot,veh)
	setTimer(function()
		finishJob(el,true,false)
		exports["1"]:outputNotificationBox ("#00cc00Możesz teraz zakończyć pracę lub wrócić po kolejnego skoczka!")
		addEventHandler("onClientRender",root,render1)  
		triggerServerEvent("givePlayerMoney", el, money, 5)
		rnd=math.random(1,10)
		repek = getElementData(el,"player:reputation")
		repka=repek+rnd
		setElementData(el,"player:reputation",repka)
		exports["1"]:outputNotificationBox ("#00cc00Za dostarczenie skoczka w wyznaczone miejsce otrzymujesz #00cccc"..money.."#00cc00 PLN oraz #00cccc"..rnd.."#00cc00 RP!")
		triggerServerEvent("DestroyPed",root,source)
	end, 5000, 1)
end

function showMarker()
	
	
	local losuj = math.random(2, #missionPoints)
	rnd=missionPoints
	missionMarker=createMarker(rnd[losuj][1], rnd[losuj][2], rnd[losuj][3]-1, "ring", 5, 255, 0, 0, 255)
	missionBlip=createBlipAttachedTo(missionMarker, 12)
	addEventHandler("onClientMarkerHit", missionMarker, showNextPoint)
end
	




addEventHandler("onClientMarkerHit", missionZaladunek, function(el,md)
	if not md or el~=localPlayer then return end
	local veh=getPedOccupiedVehicle(el)
	if not veh then return end
	if getVehicleController(veh) ~= localPlayer then return end
	if getElementModel(veh) ~= 593 then return end
	if isElement(missionMarker) or isElement(missionBlip) then
		exports["1"]:outputNotificationBox ("#cc0000Możesz transportować maksymalnie jednego spadochroniarza!")
		exports["1"]:outputNotificationBox ("#cc0000Samolot pełny!")
		return
	end
	setElementFrozen(veh,true)
	exports["1"]:outputNotificationBox ("#00ccccSpadochroniarz wsiada do samolotu")
	triggerServerEvent("CreatePed",resourceRoot,veh)
	setTimer(function()
		playSound(":ogrpg-misc/misc/point.wav")
		showMarker()
		setElementFrozen(veh,false)
		exports["1"]:outputNotificationBox ("#00cc00Dostarcz go w wyznaczone miejsce!")
		exports["1"]:outputNotificationBox ("#00cc00Spadochroniarz jest już w samolocie!")
	end, 5000, 1)
end)

addEventHandler("onClientPlayerQuit", root, function()
	if seat~=0 then return end
	if plr~=localPlayer then return end
	finishJob(plr, true,true)
	triggerServerEvent("DestroyPed",root,source)
	setElementData(plr,"player:job",false)
	finishJob(source,false,true)
end)

addEventHandler("onClientPlayerWasted", root, function()
	finishJob(source,true,true)
end)

addEventHandler("onClientVehicleExit", resourceRoot, function(plr,seat)
	if seat~=0 then return end
	if plr~=localPlayer then return end
	finishJob(plr, true,true)
	triggerServerEvent("DestroyPed",root,source)
	setElementData(plr,"player:job",false)
	exports["1"]:outputNotificationBox ("#cc0000Zakończyłeś pracę!")
end)

addEventHandler("onClientVehicleExplode", resourceRoot, function()
	if getElementModel(source) ~= 593 then return end
	local plr=getVehicleController(source)
	if plr~=localPlayer then return end
	finishJob(plr, true,true)
	setElementData(plr,"player:job",false)
	triggerServerEvent("DestroyPed",root,source)
	exports["1"]:outputNotificationBox ("#cc0000Zakończyłeś pracę!")
end)

addEvent("startJob", true)
addEventHandler("startJob", resourceRoot, function(veh)
	missionVehicle=veh
	setElementData(localPlayer,"player:job",code)
	exports["1"]:outputNotificationBox ("#00cc00Odbierz skoczka w punkcie obok")
	exports["1"]:outputNotificationBox ("#00cc00Zrzut spadochroniarzy")
	exports["1"]:outputNotificationBox ("#00cc00Rozpoczynasz pracę:")
end)

addEventHandler("onClientResourceStop", resourceRoot, function()
	if getElementData(localPlayer, "player:job")==code then
		setElementFrozen(localPlayer, false)
		setElementData(localPlayer, "player:job", false)
	end
end,false,"high")





addCommandHandler("start", function(cmd)
	plr=localPlayer
	if isPedInVehicle(plr) then return end
	if not isElementWithinMarker(plr,jobMarker) then return end
	if jobOnline == false then
		exports["1"]:outputNotificationBox ("#cc0000Praca jest wyłączona")
		return
	end
	if getElementData(plr,"player:job") then
		exports["1"]:outputNotificationBox ("#cc0000Posiadasz aktywną pracę!")
		return
	end
	setElementData(plr,"player:job", code)
	triggerServerEvent("startJobS", root,localPlayer)
end)

addEventHandler("onClientMarkerHit", jobMarker, function(el,md)
	if el~=localPlayer then return end
	if getElementType(el) == "player" then
		if isPedInVehicle(el) then return end
		exports["1"]:outputNotificationBox ("#cc0000test")
	end
end)
















