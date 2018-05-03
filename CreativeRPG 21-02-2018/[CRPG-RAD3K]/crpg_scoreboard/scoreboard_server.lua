addEvent("getMaxPlayer",true)
addEventHandler("getMaxPlayer",root,
function (player)
    max = getMaxPlayers()
    triggerClientEvent(player,"getMaxPlayers",root,max)
end
)