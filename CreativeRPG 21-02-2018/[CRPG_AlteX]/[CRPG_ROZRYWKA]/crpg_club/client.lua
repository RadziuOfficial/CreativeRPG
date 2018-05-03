--local stripBlip = createBlip(STRIP_CLUB_POSITION, 21)
stripBlip:setData("text", "blip_strip_club")

local enterMarker
local exitMarker

local colshape = createColSphere(Vector3 { x = 1030.836, y = -1100.674, z = 4179.453 }, 30)
local music

addEventHandler("onClientResourceStart", resourceRoot, function ()
	enterMarker = exports.dpMarkers:createMarker("stripclub", STRIP_CLUB_POSITION - Vector3(0, 0, 0.9), 0)
	enterMarker.dimension = 0
	exitMarker = exports.dpMarkers:createMarker("exit", STRIP_CLUB_INTERIOR_POSITION - Vector3(0, 0, 0.9), 0)
end)

addEventHandler("dpMarkers.use", root, function ()
	if source == enterMarker then
		localPlayer.position = STRIP_CLUB_INTERIOR_POSITION
	elseif source == exitMarker then
		localPlayer.position = STRIP_CLUB_POSITION
	end
end)

addEventHandler("onClientColShapeHit", colshape, function (player)
	if player ~= localPlayer then
		return
	end

	if isElement(music) then
		return
	end
	music = playSound("https://youtu.be/_5TlJdn2WPU")
end)

addEventHandler("onClientColShapeLeave", colshape, function (player)
	if player ~= localPlayer then
		return
	end
	if not isElement(music) then
		return
	end
	destroyElement(music)
end)