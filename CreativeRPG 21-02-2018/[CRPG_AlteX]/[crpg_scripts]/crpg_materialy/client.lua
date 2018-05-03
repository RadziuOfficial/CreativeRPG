--[[
		Autor: AlteX
		Dla: Creative RPG
		Skrypt: Praca Dorywcza
		Masz jakiś problem kurwa do nas to spierdalaj i nie graj u nas i nie pierdol farmazonów o naszej ekipie.
]]

local screenW, screenH = guiGetScreenSize()
local sw,sh = guiGetScreenSize()
local elements = {}

function isEventHandlerAdded(sEventName,pElementAttachedTo,func)
	if type(sEventName)=='string' and isElement(pElementAttachedTo) and type(func)=='function' then local aAttachedFunctions = getEventHandlers(sEventName,pElementAttachedTo)
	if type(aAttachedFunctions)=='table' and #aAttachedFunctions > 0 then for i,v in ipairs(aAttachedFunctions) do if v==func then return true end end end
	end return false
end
local napisy = createElement("text")
setElementData(napisy, "text", "Rozpoczęcie pracy Dostawcy")
setElementPosition(napisy, 1712.97, 913.63, 10.82)
local markerROZP = createMarker(-2409.46, -2189.69, 34.04-1.2,"cylinder",1,0,102,204,255)

function outputChatBox_(text)
	exports["crpg_powiadomienia"]:noti(text)
end

addEventHandler("onClientMarkerHit",markerROZP,function(pcl,cmd)
	if not isPedInVehicle(localPlayer) then
		if not getElementData(localPlayer,"player:job") then
			if pcl == localPlayer then
				if getElementData(localPlayer,"zdl") == true then
					outputChatBox_("Posiadasz nałożony zakaz prowadzenia pojazdów (kat. A/B/C)! Od kary możesz zaapelować na forum! Więcej informacji: zaloguj się ponownie (chat).",255,0,0,true)
					return
				end
				startkurier(localPlayer)
			end
		end
end
end)

local maxpoints = 5
local playerpoints = 0

local pointsNEXT = {
{-2007.02, -1523.24, 85.56},
{-2232.35, -1360.34, 278.73},
}

function endkurier(plr)
	if (plr==localPlayer) then
		if point and isElement(point) then destroyElement(point) end
		if blip and isElement(blip) then destroyElement(blip) end
		if marker and isElement(marker) then destroyElement(marker) end
		if markern and isElement(markern) then destroyElement(markern) end
		setElementData(plr,"DM:unlock",false)
	end
end

function startkurier(plr)
	if (plr==localPlayer) then
		if not getElementData(plr,"player:job") then
			if not isPedInVehicle(plr) then
				if getElementData(plr,"prawko_c") ~= 1 then
					outputChatBox_("Nie posiadasz prawa jazdy kat. C!",255,0,0,true)
					setElementData(plr,"player:job:materialy:etap",false)
					return
				end
				playerpoints = 0
				setElementData(plr,"player:job",true)
				setElementData(plr,"player:job:materialy:etap",1)
				outputChatBox_("Praca kuriera została rozpoczęta!")
				startkurierEtap(plr)
				setElementData(plr,"DM:unlock",false)
				outputChatBox_("Załaduj 5 skrzyń z materiałami na pakę po czym dostarcz je do kopalni.",90,255,0)
				addEventHandler("onClientRender", root, gui)
			else
				outputChatBox_("Na początku wysiądź z pojazdu!",255,0,0,true)
			end
		else
			outputChatBox_("Na początku zakończ aktualną pracę!",255,0,0,true)
		end
	end
end

local screenW, screenH = guiGetScreenSize()
local dxfont0_cz = dxCreateFont(":crpg_fonty/f.ttf", 20)

createBlip(-2409.46, -2189.69, 34.04, 46)

function gui()
exports["nm-blur"]:dxDrawBluredRectangle(screenW * 0.6808, screenH * 0.0130, screenW * 0.1816, screenH * 0.0625, tocolor(150, 150, 150, 255))
        dxDrawRectangle(screenW * 0.6808, screenH * 0.0130, screenW * 0.1816, screenH * 0.0625, tocolor(15,15,15,222), false)
        dxDrawRectangle(screenW * 0.6808, screenH * 0.0130, screenW * 0.0073, screenH * 0.0625, tocolor(15,15,15,222), false)
        dxDrawRectangle(screenW * 0.8551, screenH * 0.0130, screenW * 0.0073, screenH * 0.0625, tocolor(15,15,15,222), false)
        dxDrawText("Załadunek: "..playerpoints.."/5", (screenW * 0.6918) +1, (screenH * 0.0130) +1, (screenW * 0.8521) +1, (screenH * 0.0729) +1, tocolor(0, 0, 0, 255), 1.00, dxfont0_cz, "center", "center", false, false, false, false, false)
        dxDrawText("Załadunek: "..playerpoints.."/5", screenW * 0.6918, screenH * 0.0130, screenW * 0.8521, screenH * 0.0729, tocolor(255, 255, 255, 255), 1.00, dxfont0_cz, "center", "center", false, false, false, false, false)
end

timerrrrr={}

function startkurierEtap(plr)
	if (plr==localPlayer) then
		if getElementData(plr,"player:job:materialy:etap") == 1 then
			if playerpoints >= maxpoints then
				setElementData(plr,"player:job:materialy:etap",2)
				startkurierEtap(plr)
				return
			end
			marker = createMarker(-2387.89, -2214.85, 33.29-1.2,"cylinder",1.5,74,204,0,255)
			addEventHandler("onClientMarkerHit",marker,function(plr)
				if (plr==localPlayer) then
					if getElementData(plr,"player:job") then
						toggleControl("sprint",false)
						toggleControl("enter_exit",false)
						toggleControl("jump",false)
						triggerServerEvent("giveObject:buildingjob",plr,plr)
						destroyElement(marker)
						
						markern = createMarker( -2376.18, -2196.18, 33.34-1.2,"cylinder",1.5,255,255,0,150)
						addEventHandler("onClientMarkerHit",markern,function(plr)
							if (plr==localPlayer) then
								if getElementData(plr,"player:job") then
									if not isPedInVehicle(plr) then 
										triggerServerEvent("destroyElement:buildingjob",plr,plr)
										
										destroyElement(markern)
										playerpoints = tonumber(playerpoints) + 1
										
										toggleControl("sprint",true)
										toggleControl("enter_exit",true)
										toggleControl("jump",true)
										
										startkurierEtap(plr)
									end
								end
							end
						end)
					end
				end
			end)
		end
		if getElementData(plr,"player:job:materialy:etap") == 2 then
			setElementFrozen(plr,true)
			setTimer(function()
				removeEventHandler("onClientRender", root, gui)
				triggerServerEvent("stworzpojazdkurier",plr,plr)
				local rnd = math.random(1,#pointsNEXT)
				point = createMarker(pointsNEXT[rnd][1],pointsNEXT[rnd][2],pointsNEXT[rnd][3]-2,"cylinder",4,0,0,255,150)
				blip = createBlipAttachedTo(point,12)
				addEventHandler("onClientMarkerHit",point,function(plr)
					if (plr==localPlayer) then
						if getElementData(plr,"player:job") then
							if isPedInVehicle(plr) then
								setElementData(plr,"player:job",false)
								setElementData(plr,"player:job:materialy:etap",false)
								triggerServerEvent("destroyElement:buildingjob",plr,plr)
								triggerServerEvent("destroyVehicle:buildingjob",plr,plr)
								endkurier(plr)
								setElementData(plr,"DM:unlock",true)
                                                                local kasa = getElementData(plr,"pieniadze")
								if getElementData(plr,"premium") then
																local hajspremium = math.random(90,130)
																outputChatBox_("Dostarczyłeś paczki do klienta otrzymujesz za to wynagrodzenie w wysokości: "..hajspremium.." PLN",0,255,0, true)
                                                                setElementData(plr, "pieniadze",kasa+hajspremium)
                                                                else
																local hajs = math.random(50,90)
																outputChatBox_("Dostarczyłeś paczki do klienta otrzymujesz za to wynagrodzenie w wysokości: "..hajs.." PLN",0,255,0, true)
                                                                setElementData(plr, "pieniadze",kasa+hajs)
                                                                end
                                                                local rp =  getElementData(plr,"punkty")
                                                                local losek = math.random(1,4)
                                                                if losek == 2 then
                                                                setElementData(plr,"punkty", rp+1)
                                                                outputChatBox_("Za dobrą prace dostajesz dodatkowe 1 RP")
                                                                end
 								fadeCamera(false)
								setTimer(function()
									fadeCamera(true)
								end,3500,1)
								playerpoints = 0
								timerrrrr[plr] = setTimer(function()
									setElementPosition(plr, -2401.54, -2187.77, 39.20)
								end,2500,1)
							else
								endkurier(plr)
							end
						else
							endkurier(plr)
						end
					end
				end)
			end,1000,1)
		end
	end
end

addEventHandler("onClientVehicleExit",resourceRoot,function(plr,seat)
	if plr == localPlayer then
	
		endkurier(plr)
		setElementData(plr,"player:job",false)
		setElementData(plr,"player:job:materialy:etap",false)
		triggerServerEvent("destroyElement:buildingjob",plr,plr)
		triggerServerEvent("destroyVehicle:buildingjob",plr,plr)
		playerpoints = 0
	end
end)

addEventHandler("onClientPlayerWasted",root,function()
	if source == localPlayer then
		endkurier(source)
		setElementData(source,"player:job",false)
		setElementData(source,"player:job:materialy:etap",false)
		triggerServerEvent("destroyElement:buildingjob",source,source)
		triggerServerEvent("destroyVehicle:buildingjob",source,source)
		playerpoints = 0
	end
end)