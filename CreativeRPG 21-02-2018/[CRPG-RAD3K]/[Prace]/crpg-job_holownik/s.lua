--[[
	Autor: Asper
	Praca Koparek
	Nie masz prawa użyć tego kodu bez mojej zgody
]]

local nazwa_pracy = "Holownia pojazdów"
local wiadomosc_pracy = "holownik."
local opis_pracy = "Wymagania:\n[+] Kategoria B\n\nPraca polega na holowniu pojazdów na baze, wypłate możemy odebrać po wyholowaniu 1 pojazdu."
local id_pracy = 2
local licencje_pracy = "b"
createBlip(1066.40, 2091.40, 10.82,46,2,255,0,0,255,0,100)

local starts = {
	{ped={1066.38, 2092.31, 10.82, 180}, marker={1066.40, 2091.40, 10.82}},
}

addEventHandler("onResourceStart", resourceRoot, function ()
	for i,v in ipairs(starts) do
		local x1,y1,z1, rz = unpack(v.ped)
		local ped = createPed(165, x1, y1, z1, rz)
		setElementData(ped, "name", "Pracodawca")
		setElementFrozen(ped, true)

		local x2,y2,z2 = unpack(v.marker)
		local marker = createMarker(x2, y2, z2-1, "cylinder", 1.1, 0, 94, 254, 75)

		local cs = createColSphere(x2, y2, z2, 1)

		addEventHandler("onColShapeHit", cs, markerHit)
		addEventHandler("onColShapeLeave", cs, markerLeave)
	end
end)

function markerHit(hit, dim)
	if getElementType(hit) ~= "player" then return end
	if isPedInVehicle(hit) then return end
	triggerClientEvent(hit, "createJobsWindow", hit, {nazwa_pracy, opis_pracy, id_pracy, wiadomosc_pracy, licencje_pracy})
end

function markerLeave(hit, dim)
	if getElementType(hit) ~= "player" then return end
	if isPedInVehicle(hit) then return end
	triggerClientEvent(hit, "destroyJobsWindow", hit)
end

local vehicle_position = {
{1057.85, 2074.29, 10.70, 358.2, 0.0, 88.4},
{1034.45, 2075.90, 10.71, 358.4, 360.0, 269.7},
{1033.99, 2068.82, 10.69, 358.0, 0.0, 269.1},
{1041.41, 2089.36, 10.69, 358.1, 0.0, 0.6},	
{1034.92, 2098.25, 10.69, 358.1, 360.0, 271.1},
{1090.26, 2164.57, 10.69, 358.0, 0.0, 88.5},
{1077.94, 2164.81, 10.69, 358.1, 360.0, 90.0},
{1065.84, 2164.81, 10.71, 358.3, 0.0, 90.0},
{1062.78, 2157.69, 10.71, 358.4, 0.0, 88.3},
{1044.06, 2167.43, 10.68, 357.8, 0.0, 179.7},
}

addEvent("giveHolownik", true)
addEventHandler("giveHolownik", root, function ()
	local rnd = math.random(1,#vehicle_position)
	local pos = vehicle_position[rnd]
	local veh = createVehicle(525, pos[1],pos[2],pos[3],pos[4],pos[5],pos[6])
	setElementData(veh, "praca:pojazd", id_pracy)
	setElementData(veh, "praca:gracz", source)
	setElementData(source, "praca:pojazd", veh)
    warpPedIntoVehicle(source, veh)
	setElementParent(veh, source)
	setElementData(veh, "nametag", "Praca dorywcza\nHolownik")
end)

addEventHandler("onPlayerQuit", root, function ()
	if getElementData(source, "praca") ~= id_pracy then return end
	if not getElementData(source, "praca:pojazd") then return end
	local veh = getElementData(source, "praca:pojazd")
	destroyElement(veh)
	triggerClientEvent(source, "stop:holownik", source, veh)
end)

addEventHandler("onVehicleStartEnter", root, function (gracz)
	if getElementData(source, "praca:pojazd") ~= id_pracy then return end
	if getElementData(source, "praca:gracz") ~= gracz then cancelEvent() end
end)

addEventHandler("onVehicleExit", resourceRoot, function (gracz, seat)
	if seat ~= 0 then return end
	if getElementData(source, "praca:pojazd") ~= id_pracy then return end
	if getElementData(source, "praca:gracz") ~= gracz then return end
	triggerClientEvent(gracz, "stop:holownik", gracz, source)
	destroyElement(source)
end)

function stopPraca(hit, dim)
	local veh = getElementData(source, "stop:veh")
	if getElementData(hit, "praca:pojazd") ~= veh then return end
	destroyElement(veh)
	if isElement(source) then
		destroyElement(cs)
	end
	setElementData(hit, "praca:pojazd", false)
end

addEventHandler("onPlayerResign", root, function (gracz, job)
	if job ~= id_pracy then return end
	local veh = getElementData(gracz, "praca:pojazd")
	if veh and isElement(veh) then
		destroyElement(veh)
	end
	setElementData(gracz, "praca:pojazd", false)
end)