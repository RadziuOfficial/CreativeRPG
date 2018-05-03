function findPlayer(plr, cel)
	local target = nil
	if (tonumber(cel) ~= nil) then
		target = getElementByID("p"..cel)
	else
		for _,thePlayer in ipairs(getElementsByType("player")) do
			if string.find(string.gsub(getPlayerName(thePlayer):lower(),"#%x%x%x%x%x%x", ""), cel:lower(), 1, true) then
				if (target) then
					outputChatBox("Znaleziono wiecej niz jednego gracza o pasujacym nicku, podaj wiecej liter.", plr)
					return nil
				end
				target=thePlayer
			end
		end
	end
	return target
end



kaj = {}

function zalozkaj(plr, cmd, target)
        if not target then return end
	local gracz = findPlayer(plr, target)
	if getElementData(plr, "kajdanki") == false then
		if getElementData(plr, "frakcja") == "KGP" then
			local gracz = getPlayerName(gracz)
			local gracz = getPlayerFromName(gracz)
			local x2,y2,z2 = getElementPosition(gracz)
				local x,y,z = getElementPosition(plr)
				if (getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)<20) then
					toggleControl(gracz, "enter_exit", false)
					toggleControl(gracz, "enter_passenger", false)
					attachElements(gracz, plr, 0,0.4,0)
					setElementPosition(gracz, x,y,z)
					local graczz = getPlayerName(gracz)
					kaj[plr] = {}
					kaj[plr] = {graczz}
					setElementData(plr,"kajdanki", true)
--setPedAnimation ( gracz, "FAT", "IDLE_tired", -1, true, false )
					outputChatBox(""..getPlayerName(plr).." zakuwa cię w kajdanki.",gracz, 255,255,255,true)
					outputChatBox("Zakładasz kajdanki graczowi "..graczz..".",plr,255,255,255,true)
				end
		    end
	else
		outputChatBox("Nie możesz założyć kajdanek dwóm osobom na raz.",plr,255,255,255, true)
	end
end
addCommandHandler("zakuj",zalozkaj)

addEventHandler("onVehicleEnter",root,
function(plr)
	if getElementData(plr, "kajdanki") then
		local peds = kaj[plr][1]
		local ped = getPlayerFromName(peds)
		local veh = getPedOccupiedVehicle(plr)
		local atta = getAttachedElements(plr)
			for i,v in pairs(atta)do
				detachElements(v, plr)
			end
		warpPedIntoVehicle(ped, veh, 3)
		outputChatBox(""..getPlayerName(plr).." wsadza cię do radiowozu.",ped, 255,255,255,true)
		outputChatBox("Wsadzasz do radiowozu gracza "..getPlayerName(ped)..".",plr,255,255,255,true)
	end
end)

addEventHandler("onVehicleStartExit",root,
function(plr)
	if getElementData(plr, "kajdanki") then
		local ped = kaj[plr][1]
		local ped = getPlayerFromName(ped)
		local x,y,z = getElementPosition(plr)
		removePedFromVehicle(ped)
		attachElements(ped, plr, 0,0.4,0)
		outputChatBox(""..getPlayerName(plr).." wyciąga cię z radiowozu.",ped, 255,255,255,true)
		outputChatBox("Wyciągasz z radiowozu gracza "..getPlayerName(ped)..".",plr,255,255,255,true)
	end
end)

function sciagnijkaj(plr, cmd, target)
        if not target then return end
	local gracz = findPlayer(plr, target)
	if getElementData(plr, "kajdanki") then
		if getElementData(plr, "frakcja") == "KGP" then
			local gracz = getPlayerName(gracz)
			local gracz = getPlayerFromName(gracz)
			local x2,y2,z2 = getElementPosition(gracz)
				local x,y,z = getElementPosition(plr)
					if (getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)<20) then
					local atta = getAttachedElements(plr)
					toggleControl(gracz, "enter_exit", true)
					toggleControl(gracz, "enter_passenger", true)
						for i,v in pairs(atta)do
							detachElements(v, plr)
						end
					setElementPosition(gracz, x+2,y,z)
					setElementData(plr,"kajdanki", false)
					kaj[plr] = {}
					outputChatBox(""..getPlayerName(plr).." odkuwa cię.",gracz, 255,255,255,true)
					outputChatBox("Ściągasz kajdanki graczowi "..getPlayerName(gracz)..".",plr,255,255,255,true)
				end
			end
	else
		outputChatBox("Nie załozyłeś nikomu kajdanek.",plr,255,255,255, true)
	end
end
addCommandHandler("odkuj",sciagnijkaj)