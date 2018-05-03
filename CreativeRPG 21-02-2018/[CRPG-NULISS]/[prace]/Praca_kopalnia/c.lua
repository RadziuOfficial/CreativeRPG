local job_marker = createMarker(-2087.05, -1530.54, 77.80-1, "cylinder", 3, 0, 94, 254, 60)
local job_marker_cancel = createMarker(-2100.82, -1522.49, 77.80-1, "cylinder", 3, 255, 0, 0, 50)
createBlipAttachedTo(m1,46)
local time_freeze = math.random(6000,9000)
local name_job = "wydobywania surowców mineralnych"
local button_job = "e"
local button_state = "down"
local digging_animation = "bat_4"
local sw, sh = guiGetScreenSize()

local points = {
	{-2103.61, -1518.70, 77.80},  
	{-2102.30, -1537.98, 77.47},
	{-2134.67, -1527.72, 77.86},
	{-2140.18, -1535.47, 77.80},
	{-2149.79, -1536.17, 77.80},
	{-2154.60, -1523.97, 77.80},
	{-2146.71, -1518.26, 78.08},
	{-2182.42, -1532.73, 77.90},
	{-2140.01, -1524.30, 77.80},
	{-2136.47, -1527.72, 77.83},
}

local nazwy = {
	"rudy żelaza",
	"sztabki węgla brunatnego",
	"sztabki węgla kamiennego",
	"rudy złota",
	"rudy diamentu",
	"rudy szmaragdu",
	"rudy miedzi",
	"sztabki soli kamiennej",
	"sztabki granitu",
}

local objective
local draw
local draw = 0
local element_type = "player"

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
	if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
		local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
		if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
			for i, v in ipairs( aAttachedFunctions ) do
				if v == func then
					return true
				end
			end
		end
	end
	return false
end

local function postep()
	local pasek = interpolateBetween(0, 0, 0, sw * 0.4297, 0, 0, (getTickCount()-time)/time_freeze, "InOutQuad")
	dxDrawText("Postęp:", (sw * 0.2855) + 0.8, (sh * 0.2422) + 0.8, (sw * 0.4407) + 0.8, (sh * 0.2799) + 0.8, tocolor(0, 0, 0, 255), 3.00, "default-bold", "left", "top", false, false, false, true, false)
    dxDrawText("Postęp:", sw * 0.2855, sh * 0.2422, sw * 0.4407, sh * 0.2799, tocolor(255, 255, 255, 255), 3.00, "default-bold", "left", "top", false, false, false, true, false)
	dxDrawLine((sw * 0.2855) - 1, (sh * 0.3060) - 1, (sw * 0.2855) - 1, sh * 0.3659, tocolor(0, 0, 0, 200), 1, false)
    dxDrawLine(sw * 0.7152, (sh * 0.3060) - 1, (sw * 0.2855) - 1, (sh * 0.3060) - 1, tocolor(0, 0, 0, 200), 1, false)
    dxDrawLine((sw * 0.2855) - 1, sh * 0.3659, sw * 0.7152, sh * 0.3659, tocolor(0, 0, 0, 200), 1, false)
    dxDrawLine(sw * 0.7152, sh * 0.3659, sw * 0.7152, (sh * 0.3060) - 1, tocolor(0, 0, 0, 200), 1, false)
	dxDrawRectangle(sw * 0.2855, sh * 0.3060, sw * 0.4297, sh * 0.0600, tocolor(0, 0, 0, 170), false)
	dxDrawRectangle(sw * 0.2855, sh * 0.3060, pasek, sh * 0.0600, tocolor(0, 94, 254, 255), false)
end

local function hitmarker(player, md)
    if not md or getElementType(player) ~= element_type then return end
    if player ~= localPlayer then return end
	outputChatBox("Aby rozpocząć pracę "..name_job.." wciśnij klawisz '"..button_job.."'.")
end
addEventHandler("onClientMarkerHit", job_marker, hitmarker)

local function startjob()
	if not isElementWithinMarker(localPlayer, job_marker) then return end
	if getElementData(localPlayer, "player:miner") == true then exports["noti"]:noti("* Posiadasz aktywną pracę!", 255, 0, 0, true) return end
    if getPedOccupiedVehicle(localPlayer) == true then exports["noti"]:noti("* Nie możesz być w pojeździe!", 255, 0, 0, false) return end
	setElementData(localPlayer, "player:miner", true)
	outputChatBox("Rozpocząłeś(aś) pracę "..name_job..", idź wydobyć surowiec zaznaczony blipem 'C' na minimapie.")
	toggleControl("sprint", false) toggleControl("jump", false) toggleControl("crouch", false) toggleControl("next_weapon", false) toggleControl("previous_weapon", false) toggleControl("fire", false)
	triggerServerEvent("kilof", localPlayer)
	job_stage(localPlayer)
end
bindKey(button_job, button_state, startjob)

local function canceljob()
	if not isElementWithinMarker(localPlayer, job_marker_cancel) then return end
	if getElementData(localPlayer, "player:miner") == false then outputChatBox("Nie posiadasz aktywnej pracy!") return end
    if getPedOccupiedVehicle(localPlayer) == true then outputChatBox("Nie możesz być w pojeździe!") return end
	outputChatBox("Zakończyłeś(aś) pracę "..name_job..".")
	toggleControl("sprint", true) toggleControl("jump", true) toggleControl("crouch", true) toggleControl("next_weapon", true) toggleControl("previous_weapon", true)
	if isElement(objective) and isElement(blip) and isElement(rocks) and isElement(text) then
	destroyElement(objective)
	destroyElement(blip)
	destroyElement(rocks)
	destroyElement(text)
	end
	if isEventHandlerAdded("onClientRender", root, postep) then
	removeEventHandler("onClientRender", root, postep)
	end
	triggerServerEvent("end_job", localPlayer)
	setElementData(localPlayer, "player:miner", false)
end
bindKey(button_job, button_state, canceljob)

function job_stage(player, md)
    if (objective) and isElement(objective) then
    destroyElement(objective)
	destroyElement(blip)
	destroyElement(rocks)
    objective = nil
    end
	toggleControl("sprint", false) toggleControl("jump", false) toggleControl("crouch", false) toggleControl("next_weapon", false) toggleControl("previous_weapon", false) toggleControl("fire", false)
	local losuj = math.random(2, #points)
	local miner = points
    objective = createMarker(miner[losuj][1], miner[losuj][2], miner[losuj][3]-0.95, "cylinder", 1.2, 255, 255, 0, 70)
	rocks = createObject(math.random(3930,3931), miner[losuj][1]+math.random(0.4,0.5), miner[losuj][2]+math.random(0.2, 0.3), miner[losuj][3]-0.6, 0, 0, math.random(0,90))
	blip = createBlipAttachedTo(objective, 12)
	text = createElement("text")
	setElementData(text, "text", "Surowiec")
	setElementPosition(text, miner[losuj][1], miner[losuj][2], miner[losuj][3]-0.5)
    addEventHandler("onClientMarkerHit", objective, function(player, md)
	if not md or getElementType(player) ~= element_type then return end
	if player ~= localPlayer then return end
	if isPedInVehicle(player) then outputChatBox("Nie możesz być w pojeździe!") return end
	local data = setElementData(player, "player:miner", true)
	if data then outputDebugString("Nadano elementdatę górnika dla użytkownika o nicku: "..getPlayerName(player)..".") end
    setElementFrozen(player, true)
	toggleAllControls(false)
	outputChatBox("Wydobywasz surowiec...")
	addEventHandler("onClientRender", root, postep) 
	time = getTickCount()
	setTimer(function()
	removeEventHandler("onClientRender", root, postep)
	end, time_freeze, 1) 
	triggerServerEvent("animation", localPlayer)
    setTimer(function()
    setElementFrozen(player, false)
	toggleAllControls(true)
	setPedAnimation(player, digging_animation)
	destroyElement(objective)
	destroyElement(blip)
	destroyElement(rocks)
	destroyElement(text)
	triggerServerEvent("end_animation", localPlayer)
	job_stage(localPlayer)
	wyplata(localPlayer)
	end, time_freeze, 1)
	end)
end

function wyplata()
    local random = math.random(1, #nazwy)
	local hajs = getElementData(localPlayer, "pieniadze") or 0
	local gracz = math.random(25,50)	
	local premium = math.random(75,100)	
			if getElementData("premium") then
		    setElementData(localPlayer, "pieniadze", hajs+premium)
		    exports["crpg_powiadomienia"]:noti("#FFFF00✪#FFFFFF Za wydobycie "..nazwy[random].." otrzymujesz wynagrodzenie "..premium.." PLN!", client)		
        else
		    setElementData(localPlayer, "pieniadze", hajs+gracz)
		    exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Za wydobycie "..nazwy[random].." otrzymujesz wynagrodzenie "..gracz.." PLN!", client)	
        end
end

function onresourcestop()
	if isEventHandlerAdded("onClientRender", root, postep) then
	removeEventHandler("onClientRender", root, postep)
	end
	setElementData(localPlayer, "player:miner", false)
	setElementFrozen(localPlayer, false)
	toggleControl("sprint", true)
	toggleControl("jump", true)
	toggleControl("crouch", true)
	toggleControl("next_weapon", true)
	toggleControl("previous_weapon", true)
	toggleControl("fire", true)
end
addEventHandler("onClientResourceStop", resourceRoot, onresourcestop)

local function hitmarker2(player, md)
    if not md or getElementType(player) ~= element_type then return end
    if player ~= localPlayer then return end
	outputChatBox("✔ Aby zakończyć pracę "..name_job.." wciśnij klawisz #99FF00'"..button_job.."'", 255, 0, 0, true)
end
addEventHandler("onClientMarkerHit", job_marker_cancel, hitmarker2)