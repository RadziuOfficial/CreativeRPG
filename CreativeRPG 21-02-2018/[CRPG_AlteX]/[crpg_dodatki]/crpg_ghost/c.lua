--[[
	autor: AlteX
	All rights reserved!
]]

addEvent("ghost:cuboids", true)
addEventHandler("ghost:cuboids", resourceRoot, function(colshape,player,type,on)
	if type == "vehicle" then
		if on == "Leave" then
			for i,v in ipairs(getElementsByType("vehicle")) do
				setElementCollidableWith(player, v, true)
			end
		else
			for i,v in ipairs(getElementsByType("vehicle")) do
				setElementCollidableWith(player, v, false)
			end
		end
	else
		if on == "Leave" then
			for i,v in ipairs(getElementsByType("player")) do
				setElementCollidableWith(player, v, true)
			end
		else
			for i,v in ipairs(getElementsByType("player")) do
				setElementCollidableWith(player, v, false)
			end
		end
	end
end)