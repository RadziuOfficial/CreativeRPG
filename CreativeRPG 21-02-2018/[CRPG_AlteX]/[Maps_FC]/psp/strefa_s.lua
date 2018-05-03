local silownia = createColCuboid(-1503.97278, 736.93896, 15,  19.31, 20.6, 5)
local psps = createColCuboid(-1525.70056, 734.49945, 0, 42, 23, 16.8)
local pspa = createRadarArea(-1525.70056, 734.49945, 42, 23, 255, 0, 0, 255, root)
local psps2 = createColCuboid(-1504.29688, 758.28601, 0, 19.8, 25.7, 16.5)
local pspa2 = createRadarArea(-1504.29688, 758.28601, 19.8, 25.7, 255, 0, 0, 255, root)

function strefaw1 ( thePlayer, matchingDimension )
        -- announce to everyone that the player entered the hill
        if (getElementType(thePlayer) == "player") then
				triggerClientEvent(thePlayer, "strefa", root, "0")
        end
end
addEventHandler ( "onColShapeHit", psps, strefaw1 )
function strefaw2 ( thePlayer, matchingDimension )
        -- announce to everyone that the player entered the hill
        if (getElementType(thePlayer) == "player") then
				triggerClientEvent(thePlayer, "strefa", root, "0")
        end
end
addEventHandler ( "onColShapeHit", psps2, strefaw2 )
function strefaw3 ( thePlayer, matchingDimension )
        -- announce to everyone that the player entered the hill
        if (getElementType(thePlayer) == "player") then
				triggerClientEvent(thePlayer, "strefa", root, "0")
        end
end
addEventHandler ( "onColShapeHit", silownia, strefaw3 )

function strefawj1 ( thePlayer, matchingDimension )
        -- announce to everyone that the player left the hill
        if (getElementType(thePlayer) == "player") then
				triggerClientEvent(thePlayer, "strefa", root, "1")
        end
end
addEventHandler ( "onColShapeLeave", psps, strefawj1 )
function strefawj2 ( thePlayer, matchingDimension )
        -- announce to everyone that the player left the hill
        if (getElementType(thePlayer) == "player") then
				triggerClientEvent(thePlayer, "strefa", root, "1")
        end
end
addEventHandler ( "onColShapeLeave", psps2, strefawj2 )
function strefawj3 ( thePlayer, matchingDimension )
        -- announce to everyone that the player left the hill
        if (getElementType(thePlayer) == "player") then
				triggerClientEvent(thePlayer, "strefa", root, "1")
        end
end
addEventHandler ( "onColShapeLeave", silownia, strefawj3 )