--[[
Autor: Asper
Zakaz udostepniania bez zgody autora!
Zakaz uzywania bez zgody autora!
]]

local aktualizacje = {}
local updates = createElement("updates")

local result = exports.mysql:wykonaj("SELECT * FROM aktualizacje")
if #result > 0 then
	for i,v in ipairs(result) do
		table.insert(aktualizacje, v.tresc)
	end
	setElementData(updates, "aktualizacje", table.concat(aktualizacje, "\n"))
end

addCommandHandler("da", function(player, cmd, ...)
	if not ... then return end
	if not getElementData(player, "duty") then return end
	local text = table.concat({...}, " ")
	text = text.." - "..getPlayerName(player).."/"..getTime()
	table.insert(aktualizacje, text)
	exports.mysql:wykonaj("INSERT INTO aktualizacje SET tresc=?", text)
	setElementData(updates, "aktualizacje", table.concat(aktualizacje, "\n"))
end)

function getTime()
	local time = getRealTime()
	local year = time.year + 1900
	local month = time.month + 1
	local monthday = time.monthday
	return string.format("%02d", monthday)..":"..string.format("%02d", month)..":"..year
end