--[[
	Autor: Asper
	Dla servera: .newMode
	Skrypt: System pojazdow
]]

addEventHandler("onVehicleEnter", root, function(plr, seat)
if seat ~= 0 then return end
local kto = getPlayerName(plr)
setElementData(source, "ostatnikierowca", kto)
end)

-- system odsylania pojazdow do przechowalni po okreslonym czasie

addEventHandler("onVehicleExit", resourceRoot, function(gracz, tryb)
	if tryb ~= 0 then return end
	setElementData(source, "naliczanie", true)
	local pojazd = source
	setTimer(function()
		if pojazd and isElement(pojazd) then
			if getElementData(pojazd, "naliczanie") then
				exports.mysql:wykonaj("UPDATE pojazdy SET przechowalnia=1 WHERE id=?", getElementData(pojazd, "id"))
				destroyElement(pojazd)
			end
		end
	end, 25200000, 1)
end)

addEventHandler("onVehicleEnter", resourceRoot, function(gracz, tryb)
	if tryb ~= 0 then return end
	setElementData(source, "naliczanie", false)
end)


-- koniec

addEventHandler("onResourceStart", resourceRoot, function()
	local spr = exports.mysql:wykonaj("SELECT * FROM pojazdy WHERE przechowalnia=0")
	for _, p in ipairs(spr) do
		stworzPojazdy(p)
	end
end)

addEventHandler("onResourceStop", resourceRoot, function()
	for _, p in ipairs(getElementsByType("vehicle")) do
		zapiszPojazdy(p)
	end
end)

function stworzPojazdy(p,x,y,z,rx,ry,rz)
	local pozycja = split(p.pozycja, ",")
	local kolor = split(p.kolor, ",")
	local pojazd = false
	if x and y and z and rx and ry and rz then
		pojazd = createVehicle(p.model, x, y, z, rx, ry, rz)
	else
		pojazd = createVehicle(p.model, pozycja[1], pozycja[2], pozycja[3], pozycja[4], pozycja[5], pozycja[6])
	end
	setVehicleColor(pojazd, kolor[1], kolor[2], kolor[3], kolor[4], kolor[5], kolor[6])
	setElementData(pojazd, "veh:mk1", p.mk1)
	setElementData(pojazd, "veh:mk2", p.mk2)
	setElementData(pojazd, "veh:mk3", p.mk3)		
	setElementData(pojazd, "wlasciciel", p.wlasciciel)	
	setElementData(pojazd, "id", p.id)
	setElementData(pojazd, "veh:org", p.organizacja)	
	setElementData(pojazd, "przebieg", p.przebieg)
	setElementData(pojazd, "paliwo", p.paliwo)
	setElementData(pojazd, "pojemnosc1", p.pojemnosc)
    setElementData(pojazd, "veh:cb", p.cb)
	setElementHealth(pojazd, p.zdrowie)
	if (p.panelstates~="0,0,0,0,0,0,0") then
    	p.panelstates=split(p.panelstates,",")
		for i,v in ipairs(p.panelstates) do
		  setVehiclePanelState(pojazd,i-1, tonumber(v))
		end
	else
    	p.panelstates=split(p.panelstates,",")
	end
	local tuning = split(p.tuning, ",")
	for i=1,#tuning do
		addVehicleUpgrade(pojazd, tuning[i])
	end
	--dodatki mechaniczne
	--if getElementData(pojazd, "veh:mk1") and getElementData(pojazd, "veh:mk1") == 1 then
	if getElementData(pojazd, "veh:mk1") and getElementData(pojazd, "veh:mk1") == 1 then
		local acceleration = getVehicleHandling(pojazd).engineAcceleration
		local velocity = getVehicleHandling(pojazd).maxVelocity
		setVehicleHandling(pojazd, "engineAcceleration", acceleration+3)
		setVehicleHandling(pojazd, "maxVelocity", velocity+20)	
	end
	if getElementData(pojazd, "veh:mk2") and getElementData(pojazd, "veh:mk2") == 1 then
		local acceleration = getVehicleHandling(pojazd).engineAcceleration
		local velocity = getVehicleHandling(pojazd).maxVelocity
		setVehicleHandling(pojazd, "engineAcceleration", acceleration+3)
		setVehicleHandling(pojazd, "maxVelocity", velocity+20)
	end
	if getElementData(pojazd, "veh:mk3") and getElementData(pojazd, "veh:mk3") == 1 then
		local acceleration = getVehicleHandling(pojazd).engineAcceleration
		local velocity = getVehicleHandling(pojazd).maxVelocity
		setVehicleHandling(pojazd, "engineAcceleration", acceleration+3)
		setVehicleHandling(pojazd, "maxVelocity", velocity+20)
	end
--[[	if p.duklad == 1 then
		local handling = getVehicleHandling(pojazd)
		setVehicleHandling(pojazd, "maxVelocity", handling.maxVelocity+8)
		setVehicleHandling(pojazd, "engineAcceleration", handling.engineAcceleration+1.2)
		setElementData(pojazd,"up4",true)
	end]]
	if p.zawieszenie == 1 then
		setElementData(pojazd, "zawieszenie", 2)
	end
	setElementData(pojazd, "bak", p.bak)
	--
	if p.organizacja:len() > 2 then
		setElementData(pojazd, "organizacja", p.organizacja)
	else
		setElementData(pojazd, "organizacja", false)
	end
	if p.rejestracja:len() > 1 then
		setVehiclePlateText(pojazd, p.rejestracja)
	else
		setVehiclePlateText(pojazd, "RPG "..p.id)
	end
	if p.naped:len() > 1 then
		setVehicleHandling(pojazd, "driveType", p.naped)
	end
	if p.swiatla:len() > 1 then
		local swiatla = split(p.swiatla, ",")
		setVehicleHeadLightColor(pojazd, swiatla[1], swiatla[2], swiatla[3])
	end

if getElementData(pojazd, "pojemnosc1") == 1 then
        setElementData(pojazd,"pojemnosc", 1.2)
        setVehicleHandling(pojazd, "maxVelocity", getVehicleHandling(pojazd).maxVelocity+1)
		setVehicleHandling(pojazd, "engineAcceleration", getVehicleHandling(pojazd).engineAcceleration)
elseif getElementData(pojazd, "pojemnosc1") == 2 then
        setElementData(pojazd,"pojemnosc", 1.4)
        setVehicleHandling(pojazd, "maxVelocity", getVehicleHandling(pojazd).maxVelocity+5)
		setVehicleHandling(pojazd, "engineAcceleration", getVehicleHandling(pojazd).engineAcceleration)
elseif getElementData(pojazd, "pojemnosc1") == 3 then
        setElementData(pojazd,"pojemnosc", 1.6)
        setVehicleHandling(pojazd, "maxVelocity", getVehicleHandling(pojazd).maxVelocity+10)
		setVehicleHandling(pojazd, "engineAcceleration", getVehicleHandling(pojazd).engineAcceleration+1)
elseif getElementData(pojazd, "pojemnosc1") == 4 then
        setElementData(pojazd,"pojemnosc", 1.8)
        setVehicleHandling(pojazd, "maxVelocity", getVehicleHandling(pojazd).maxVelocity+15)
		setVehicleHandling(pojazd, "engineAcceleration", getVehicleHandling(pojazd).engineAcceleration+2)
elseif getElementData(pojazd, "pojemnosc1") == 5 then
        setElementData(pojazd,"pojemnosc", 2.0)
        setVehicleHandling(pojazd, "maxVelocity", getVehicleHandling(pojazd).maxVelocity+20)
		setVehicleHandling(pojazd, "engineAcceleration", getVehicleHandling(pojazd).engineAcceleration+4)
elseif getElementData(pojazd, "pojemnosc1") == 6 then
        setElementData(pojazd,"pojemnosc", 2.2)
        setVehicleHandling(pojazd, "maxVelocity", getVehicleHandling(pojazd).maxVelocity+25)
		setVehicleHandling(pojazd, "engineAcceleration", getVehicleHandling(pojazd).engineAcceleration+6)
elseif getElementData(pojazd, "pojemnosc1") == 7 then
        setElementData(pojazd,"pojemnosc", 2.4)
        setVehicleHandling(pojazd, "maxVelocity", getVehicleHandling(pojazd).maxVelocity+30)
		setVehicleHandling(pojazd, "engineAcceleration", getVehicleHandling(pojazd).engineAcceleration+8)
elseif getElementData(pojazd, "pojemnosc1") == 8 then
        setElementData(pojazd,"pojemnosc", 2.6)
        setVehicleHandling(pojazd, "maxVelocity", getVehicleHandling(pojazd).maxVelocity+35)
		setVehicleHandling(pojazd, "engineAcceleration", getVehicleHandling(pojazd).engineAcceleration+10)
elseif getElementData(pojazd, "pojemnosc1") == 9 then
        setElementData(pojazd,"pojemnosc", 2.8)
		 setVehicleHandling(pojazd, "maxVelocity", getVehicleHandling(pojazd).maxVelocity+40)
		setVehicleHandling(pojazd, "engineAcceleration", getVehicleHandling(pojazd).engineAcceleration+12)
elseif getElementData(pojazd, "pojemnosc1") == 10 then
        setElementData(pojazd,"pojemnosc", 3.0)
		 setVehicleHandling(pojazd, "maxVelocity", getVehicleHandling(pojazd).maxVelocity+70)
		setVehicleHandling(pojazd, "engineAcceleration", getVehicleHandling(pojazd).engineAcceleration+32)
elseif getElementData(pojazd, "pojemnosc1") == 11 then
        setElementData(pojazd,"pojemnosc", 3.2)
		 setVehicleHandling(pojazd, "maxVelocity", getVehicleHandling(pojazd).maxVelocity+90)
		setVehicleHandling(pojazd, "engineAcceleration", getVehicleHandling(pojazd).engineAcceleration+42)
elseif getElementData(pojazd, "pojemnosc1") == 12 then
        setElementData(pojazd,"pojemnosc", 6.0)
		 setVehicleHandling(pojazd, "maxVelocity", getVehicleHandling(pojazd).maxVelocity+220)
		setVehicleHandling(pojazd, "engineAcceleration", getVehicleHandling(pojazd).engineAcceleration+52)
elseif getElementData(pojazd, "pojemnosc1") == 13 then
        setElementData(pojazd,"pojemnosc", 3.1)
		 setVehicleHandling(pojazd, "maxVelocity", getVehicleHandling(pojazd).maxVelocity+290)
		setVehicleHandling(pojazd, "engineAcceleration", getVehicleHandling(pojazd).engineAcceleration+72)
	end
	return pojazd
end

function zapiszPojazdy(p)
	local id = getElementData(p, "id")
	if not id then return end
	local x, y, z = getElementPosition(p)
	local model = getVehicleModel(p)
	local rx, ry, rz = getElementRotation(p)
	local r1,g1,b1, r2,g2,b2 = getVehicleColor(p, true)
	local pozycja = x..", "..y..", "..z..", "..rx..", "..ry..", "..rz
	local kolor = r1..", "..g1..", "..b1..", "..r2..", "..g2..", "..b2
	local zdrowie = getElementHealth(p)
	local paliwo = getElementData(p, "paliwo")
	local przebieg = getElementData(p, "przebieg")
        local pojemnosc = getElementData(p,"pojemnosc1")
        local cb = getElementData(p, "veh:cb") or 0
	local panelstates={}
	for i=0,6 do
		table.insert(panelstates, getVehiclePanelState(p,i))
	end
	panelstates=table.concat(panelstates,",")
	local licznik = getElementData(p, "lrgb")
	local r,g,b = false
	if licznik then
		r = licznik.r
		g = licznik.g
		b = licznik.b
	else
		r = 255
		g = 255
		b = 0
	end
	local r3, g3, b3 = getVehicleHeadLightColor(p)
	local swiatla = r3..", "..g3..", "..b3
	licznik = r..", "..g..", "..b
	local tuning = getVehicleUpgrades(p)
	if not tuning then
		tuning = {}
	end
	tuning = table.concat(tuning, ",")
	local wyk = exports.mysql:wykonaj("UPDATE pojazdy SET pozycja=?, model=?, kolor=?, panelstates=?, zdrowie=?, paliwo=?, przebieg=?, licznik=?, swiatla=?, pojemnosc=?, tuning=?, cb=? WHERE id=?", pozycja, model, kolor, panelstates, zdrowie, paliwo, przebieg, licznik, swiatla, pojemnosc, tuning, cb, id)
	if not wyk then
		outputDebugString("Nie udalo sie zapisac pojazdu o id "..id)
	end
end

addEventHandler("onVehicleStartEnter", root, function(gracz, seat)
	if seat ~= 0 then return end
	if getElementData(source, "id") then
		if getElementData(source, "keys") and getElementData(source, "keys") == getElementData(gracz, "dbid") then return end
		if getElementData(source, "organizacja") and getElementData(source, "organizacja") == getElementData(gracz, "organizacja") then return end
		if getElementData(source, "wlasciciel") ~= getElementData(gracz, "dbid") then
			cancelEvent()
			exports["crpg_powiadomienia"]:noti("Ten pojazd nie należy do ciebie.", gracz)
		end
	end
end)

local motory = {
{"Freeway"},
{"FCR-900"},
{"Faggio"},
{"Pizzaboy"},
{"BF-400"},
{"NRG-500"},
{"PCJ-600"},
{"HPV-1000"},
{"Wayfarer"},
{"Sanchez"},
{"Quadbike"},
}

addEventHandler("onVehicleStartEnter", root, function(g, typ)
	if typ ~= 0 then return end
	local serial = getPlayerSerial(g)
	local spr = exports.mysql:wykonaj("SELECT * FROM prawka WHERE serial=? AND data>NOW()", serial)
	if #spr > 0 then
		exports["crpg_powiadomienia"]:noti("Posiadasz zawieszone prawo jazdy kat. A,B,C od "..spr[1].admin.." do "..spr[1].data, g)
		cancelEvent()
	else
		exports.mysql:wykonaj("DELETE FROM prawka WHERE serial=?", serial)
	end
end)

addEventHandler("onVehicleStartEnter", root, function(gracz, seat)
	if seat ~= 0 then return end
	if not getElementData(source, "id") then return end
 	for i,v in ipairs(motory) do
 		if v[1] == getVehicleName(source) then 
 			if getElementData(gracz, "prawko_a") ~= 1 then
 				cancelEvent()
				exports["crpg_powiadomienia"]:noti("Nie posiadasz prawa jazdy kategorii A.", gracz)
 				return 
 			end
 		end
	 end
	if getElementData(gracz, "prawko_b") ~= 1 then
		cancelEvent()
		exports["crpg_powiadomienia"]:noti("Nie posiadasz prawa jazdy kategorii B.", gracz)
	end
end)

-- anty wybuch pojazdow

setTimer(function()
for _, vehicle in pairs(getElementsByType("vehicle")) do
if getElementHealth(vehicle) < 300 then
setVehicleDamageProof(vehicle, true)
elseif getElementHealth(vehicle) > 301 then
if getVehicleController (vehicle) then
setVehicleDamageProof(vehicle, false)
end
end
end
end, 500, 0)

setTimer(function()
for _, vehicle in pairs(getElementsByType("vehicle")) do
if not getVehicleController(vehicle) then
setVehicleDamageProof(vehicle, true)
end
end
end, 500, 0)

addEventHandler("onVehicleEnter", resourceRoot, function(gracz, tryb)
  if tryb ~= 0 then return end
  local pojazd = source
  if getElementData(pojazd, "kara") then
    triggerClientEvent(gracz, "oknoKary", source)
  end
end)

addEvent("wybralnieplace", true)
addEventHandler("wybralnieplace",root, function()
removePedFromVehicle(source)
end)