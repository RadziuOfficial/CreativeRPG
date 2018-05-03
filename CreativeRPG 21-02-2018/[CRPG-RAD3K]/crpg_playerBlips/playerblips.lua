--[[
  Autor: RAD3K
  Skrypt: playerBlips
  Informacje: Zakaz usuwania autora i używania tego skryptu bez jego wiedzy!
]]

local blip = {}
function createPlayerBlip(plr)
	if not blip[plr] then
		blip[plr] = Blip.createAttachedTo(plr, 0, 2, 0, 94, 254, 255)
		setBlipVisibleDistance(blip[plr], 300)
	end
end

function destroyPlayerBlip(plr)
	if blip[plr] and isElement(blip[plr]) then
		blip[plr]:destroy()
		blip[plr] = nil
	end
end

function destroyBlipForSource()
	destroyPlayerBlip(source)
end
addEventHandler("onPlayerQuit", root, destroyBlipForSource)
addEventHandler("onPlayerWasted", root, destroyBlipForSource)

function onPlayerSpawn()
	createPlayerBlip(source)
end
addEventHandler("onPlayerSpawn", root, onPlayerSpawn)

function onResourceStart()
	for i, plr in ipairs(Element.getAllByType("player")) do
		createPlayerBlip(plr)
	end
end
addEventHandler("onResourceStart", resourceRoot, onResourceStart)
