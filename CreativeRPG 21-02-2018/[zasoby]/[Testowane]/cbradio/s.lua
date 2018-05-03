--[[
Autor: Malentas (pomagał value)
Dla: Our New Hope
Nie masz prawa do urzywania, udostepniania kodu bez mojej zgody!!
]]

addCommandHandler("cb", function (player, command, ...)
    local veh = getPedOccupiedVehicle(player)
    if not veh then
        outputChatBox("Musisz być w pojeździe", player, 255, 0, 0)
        return
    end
    if getElementData(veh,"veh:cb") ~= 1 then
      outputChatBox("Nie posiadasz radia CB", player, 255,0,0)
      return
    end
    if not ... then
        local chat = getElementData(player, "user:cboff")
        if chat == true then -- CB jest wyłączone
            outputChatBox("Włączasz radio CB", player, 255, 0, 0)
            setElementData(player, "user:cboff", false)
        else -- CB jest włączony
            outputChatBox("Wyłączasz radio CB", player, 255, 0, 0)
            setElementData(player, "user:cboff", true)
        end  
        return
    end
    local text = table.concat({...}, " ")
    for i,v in ipairs(getElementsByType("player")) do
        if isPedInVehicle(v) and not getElementData(v, "user:cboff") then
            outputChatBox("#000000[CB-radio]#ffffff "..getPlayerName(player).." ["..getElementData(player, "id").."]: "..text, v, 255, 255, 255,true)
        end
    end
end)