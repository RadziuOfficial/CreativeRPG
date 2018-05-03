--[[
Autor: Asper
Dla: .newMode
Skrypt: Notifikacje
Typ: Server
]]

function noti(data, player)
	triggerClientEvent(player, "notka", player, data)
end
