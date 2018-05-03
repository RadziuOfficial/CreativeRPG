--[[
 Autor: Asperek
]]

createBlip(-1953.91, 270.52, 35.47, 55,2,255,0,0,255,0,100)
--createBlip(-1660.31, 1209.42, 21.16, 55,2,255,0,0,255,0,100)
createBlip(2254.65, 2046.09, 10.17, 55,2,255,0,0,255,0,100)
createBlip(932.69, 2019.01, 10.82, 55,2,255,0,0,255,0,100) -- SALON NAJLEPSZY LV

local pojazd = false
local pojazdy = {
-- id, x,y, z, cena, salon
-- auta

--	  SALON NORMALNY
      {426, -1946.09, 273.23, 35.22, 0.0, 0.0, 88.8, 105000, "salon", 3, 1.8}, -- PREMIER
      {496, -1961.46, 304.11, 35.19, 0.0, 360.0, 179.4, 65000, "salon", 3, 1.6}, -- BLISTA COMPACT
      {550, -1954.34, 304.08, 35.29, 359.6, 360.0, 179.6, 30000, "salon", 3, 1.4}, -- SUNRISE
      {402, -1954.07, 257.61, 40.88, 360.0, 0.0, 0.3, 135000, "salon", 3, 1.8}, -- BUFFALO
      {475, -1946.07, 265.39, 40.85, 359.8, 359.8, 91.5, 95000, "salon", 3, 2.0}, -- SABRE
      {445, -1946.07, 273.35, 40.93, 0.1, 0.0, 91.2, 55000, "salon", 3, 1.6}, -- ADMIRAL
      {405, -1946.06, 257.57, 40.92, 0.0, 360.0, 42.8, 67000, "salon", 3, 1.6}, -- SENTINEL
      {603, -1946.03, 257.64, 35.31, 0.1, 0.0, 42.5, 85000, "salon", 3, 1.6}, -- PHOENIX
      {566, -1960.86, 257.72, 35.25, 0.3, 360.0, 1.3, 40000, "salon", 3, 1.8}, -- TAHOMA
      {419, -1953.44, 257.86, 35.27, 0.0, 359.8, 1.1, 50000, "salon", 3, 1.8}, -- ESPERANTO
      {533, -1946.10, 265.43, 35.18, 360.0, 0.0, 90.5, 65000, "salon", 3, 1.8}, -- FELTZER

--	  SALON NAJLEPSZY LV
      {415, 946.70, 2006.35, 10.60, 0.3, 0.0, 124.5, 650000, "salon2", 3, 1.8}, -- CHEETAH
      {562, 929.72, 1989.72, 10.48, 359.5, 360.0, 317.8, 400000, "salon2", 3, 1.8}, -- ELEGY
      {560, 929.23, 2037.38, 10.53, 359.9, 360.0, 210.9, 500000, "salon2", 3, 1.6}, -- SULTAN
      {541, 939.22, 2036.91, 10.45, 359.5, 360.0, 149.4, 800000, "salon2", 3, 2.0}, -- BULLET
      {411, 939.41, 2023.18, 10.55, 0.0, 360.0, 179.2, 1500000, "salon2", 3, 1.6}, -- INFERNUS
      {480, 946.25, 1989.25, 10.48, 359.8, 0.0, 53.4, 375000, "salon2", 3, 1.6}, -- COMET
      {559, 929.57, 2002.40, 10.48, 360.0, 360.0, 324.9, 225000, "salon2", 3, 1.6}, -- JESTER
      {451, 946.76, 1996.84, 10.53, 359.5, 360.0, 90.9, 850000, "salon2", 3, 1.8}, -- TURISMO
      {477, 937.90, 1988.14, 10.58, 359.7, 360.0, 267.3, 275000, "salon2", 3, 1.8}, -- ZR-350
      {429, 929.39, 2013.49, 10.50, 360.0, 0.0, 317.4, 595000, "salon2", 3, 1.4}, -- BANSHEE

-- motory
--{468, 893.42, -1188.49, 16.64, 359.8, 360.0, 224.8, 75000, "salon", 1.5},
--{521, 895.34, -1187.96, 16.65, 0.2, 360.0, 230.2, 1000, "salon", 1.5},
--{461, -1952.64, 304.74, 40.63, 358.8, 360.0, 119.6, 1000, "salon", 1.5, },
--{581, -1952.55, 300.43, 40.64, 359.4, 0.0, 86.3, 1000, "salon", 1.5},
--{463, -1952.62, 295.70, 40.59, 0.1, 0.0, 86.4, 1000, "salon", 1.5},

--	  SALON AUT UŻYWANYCH LV
      {542, 2288.07, 2063.23, 10.57, 0.0, 0.0, 230.6, 13475, "cygan", 3, 1.2}, -- CLOVER
      {478, 2284.68, 2046.43, 10.81, 359.2, 360.0, 89.5, 2550, "cygan", 3, 1.2}, -- WALTON
      {543, 2246.69, 2046.09, 10.63, 359.0, 0.0, 218.8, 9700, "cygan", 3, 1.2}, -- SADLER
      {467, 2241.65, 2063.05, 10.56, 0.0, 0.0, 179.4,  10200, "cygan", 3, 1.2}, -- OCEANIC
      {410, 2235.32, 2045.26, 10.47, 359.4, 0.0, 142.2, 5000, "cygan", 3, 1.2}, -- MANANA
      {491, 2273.26, 2038.50, 10.58, 360.0, 360.0, 1.2, 6475, "cygan", 3, 1.2}, -- VIRGO
      {436, 2218.59, 2049.05, 10.59, 359.4, 360.0, 289.5, 4450, "cygan", 3, 1.2}, -- PREVION
      {600, 2262.86, 2063.95, 10.53, 359.0, 360.0, 152.5, 6050, "cygan", 3, 1.2}, -- PICADOR
      {549, 2297.05, 2038.69, 10.52, 360.0, 360.0, 269.0,  7200, "cygan", 3, 1.2}, -- TAMPA
      {404, 2234.14, 2034.73, 10.56, 359.7, 360.0, 89.5, 3000, "cygan", 3, 1.2}, -- PERENNIAL
}

addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(pojazdy) do
		pojazd = createVehicle(v[1], v[2], v[3], v[4], v[5], v[6], v[7])
		local cena = v[8]
		local cenap = v[8]
		local pojemnosc = v[11]
		local model = getModelHandling(tonumber(v[1]))
		local naped = model["driveType"]
		if naped == "rwd" then naped = "RWD" elseif naped == "fwd" then naped = "FWD" elseif naped == "awd" then naped = "AWD" end
		setElementData(pojazd, "nametag", "Model: "..getVehicleName(pojazd).."\nCena: "..cena.." PLN\nNapęd: "..naped.."\n Pojemność: "..pojemnosc.."\nAby zakupić wpisz /kuppojazd")
		setElementFrozen(pojazd, true)
		setVehicleDamageProof(pojazd, true)
		setElementData(pojazd, "salon", v[9])
		local shape = createColSphere(v[2], v[3], v[4], v[10])
		setElementData(shape, "i", i)
		setElementData(shape, "salon", pojazd)
		setElementData(shape, "cena", cenap)
		setElementData(shape, "size", v[10])
		setElementData(shape, "pojemnoscnowa", v[11])
	end
end)

addEventHandler("onColShapeHit", resourceRoot, function(gracz)
	if getElementType(gracz) ~= "player" then return end
	exports["crpg_powiadomienia"]:noti("Aby zakupić ten pojazd użyj komendy /kuppojazd", gracz)
end)

addEventHandler("onVehicleStartEnter", resourceRoot, function(plr, seat, jacked)
	if seat ~= 0 then return end
	cancelEvent()
end)

addCommandHandler("kuppojazd", function(gracz)
	local shape = cuboid(gracz)
	if shape then
		local veh = getElementData(shape, "salon")
		if not veh then return end
		if getElementData(shape, "size") == 3 and getElementData(gracz, "prawko_b") ~= 1 then
			exports["crpg_powiadomienia"]:noti("Nie posiadasz prawa jazdy kategorii B.", gracz)
			return
		end
		if getElementData(shape, "size") == 1.5 and getElementData(gracz, "prawko_a") ~= 1 then
			exports["crpg_powiadomienia"]:noti("Nie posiadasz prawa jazdy kategorii A.", gracz)
			return
		end
		local cenap = getElementData(shape, "cena")
		local hajs = getElementData(gracz, "pieniadze")
		cenap = tonumber(cenap)
		if hajs < cenap then
			exports["crpg_powiadomienia"]:noti("Brak funduszy na zakup tego pojazdu.", gracz)
		else
			if getElementData(gracz, "prawko_b") ~= 1 then
				exports["crpg_powiadomienia"]:noti("Nie posiadasz prawa jazdy.", gracz)
				return
			end
			local spr = exports.mysql:wykonaj("SELECT * FROM prawka WHERE serial=?", getPlayerSerial(gracz))
			if #spr > 0 then
				exports["crpg_powiadomienia"]:noti("Posiadasz zawieszone prawo jazdy kat. A,B,C do "..spr[1].data.." zabrane przez "..spr[1].admin, gracz)
				return
			end
			setElementData(gracz, "pieniadze", hajs-cenap)
			local model = getVehicleModel(veh)
			local dbid = getElementData(gracz, "dbid")
			if getElementData(shape,"pojemnoscnowa") == 1.2 then
				pojemnosc2 = 1
			elseif getElementData(shape,"pojemnoscnowa") == 1.4 then
				pojemnosc2 = 2
			elseif getElementData(shape,"pojemnoscnowa") == 1.6 then
				pojemnosc2 = 3
			elseif getElementData(shape,"pojemnoscnowa") == 1.8 then
				pojemnosc2 = 4
			elseif getElementData(shape,"pojemnoscnowa") == 2.0 then
				pojemnosc2 = 5
			elseif getElementData(shape,"pojemnoscnowa") == 2.2 then
				pojemnosc2 = 6
			elseif getElementData(shape,"pojemnoscnowa") == 2.4 then
				pojemnosc2 = 7
			elseif getElementData(shape,"pojemnoscnowa") == 2.6 then
				pojemnosc2 = 8
			elseif getElementData(shape,"pojemnoscnowa") == 2.8 then
				pojemnosc2 = 9
			end
			local k = getElementData(veh, "salon")
			if k == "salon" then
				x, y, z, r, z, yx = -1936.15, 273.34, 40.73, 360.0, 0.0, 180.7
			elseif k == "cygan" then
				x, y, z, r, z, yx = 2213.11, 2065.14, 10.56, 359.7, 0.0, 270.5
                       elseif k == "salon2" then
                                x, y, z, r, z, yx = 956.11, 2006.82, 10.50, 360.0, 0.0, 180.1
			end
			local pozycja = x..", "..y..", "..z..", "..r..", "..z..", "..yx
			local wyk, _, id = exports.mysql:wykonaj("INSERT INTO pojazdy SET model=?, wlasciciel=?, pozycja=?, paliwo=50, bak=50, przebieg=0, pojemnosc=?", model, dbid, pozycja, pojemnosc2)
			local q = exports.mysql:wykonaj("select * from pojazdy where id=?", id)
			local pojazd = exports["nm-pojazdy"]:stworzPojazdy(q[1], x, y, z, r, z, yx)
			warpPedIntoVehicle(gracz, pojazd)
			exports["crpg_powiadomienia"]:noti("Zakupiłeś pojazd "..getVehicleName(pojazd).." za cene "..cenap.." PLN", gracz)
		end
	end
end)

function cuboid(gracz)
 for i, v in ipairs(getElementsByType("colshape", resourceRoot)) do
	 if isElementWithinColShape(gracz, v) then
		return v
	end
 end
 return false
end