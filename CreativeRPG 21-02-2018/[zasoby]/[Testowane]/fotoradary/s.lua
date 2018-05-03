--[[
Autor: Asper
Skrypt: Fotoradary
Dla servera Own World
]]

local fotoradary = {
	{1920.302734375, 2153.0712890625, 10.8203125, 15, 60},
}

for i,v in pairs(fotoradary) do
	local cuboid = createColSphere(v[1], v[2], v[3], v[4]-2)
	local fotoradar = createObject(16101, v[1], v[2], v[3]-2.16, 0, 0, 160)
	setElementData(cuboid, "max:predkosc", v[5])
end

addEventHandler("onColShapeHit", resourceRoot, function(hit)
if not hit then return end
if getElementType(hit) == "player" then
local veh = getPedOccupiedVehicle(hit)
if not veh then return end
local kara = getElementData(source, "max:predkosc")
if not kara then return end
if getVehicleController(veh) ~= hit then return end
if getElementData(hit, "user:faction") then return end
local vx, vy, vz = getElementVelocity(veh)
local predkosc = ((vx^2 + vy^2 + vz^2)^(0.5))*170
local mandat = predkosc/2
if getElementData(hit, "user:money") < mandat then return end
if predkosc > kara then
exports.rpg_noti:createNotification(hit, "info", "Przekroczyłeś dopuszczalną prędkośc otrzymałeś mandat w wysokości "..string.format("%01d", mandat).." PLN")
setElementData(hit, "user:money", getElementData(hit, "user:money")-mandat)
end
end
end)

addEventHandler("onClientResourceStart", resourceRoot, function()
	txd = engineLoadTXD("foto.txd" )
	engineImportTXD(txd, 16101)
	dff = engineLoadDFF("foto.dff", 16101)
	engineReplaceModel(dff, 16101)
end)
