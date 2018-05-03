local miejsca = {
{-2272.66, -5.04, 35.80, -2281.29, -13.81, 35.42},
{1946.30, -2012.00, 13.55, 1943.55, -2018.95, 13.65},
}

local texty = {
{ -2281.88, -8.53, 35.32+2},
}

for i,v in ipairs(miejsca) do
	local marker = createMarker(v[1], v[2], v[3]-1, "cylinder", 1.1, 15, 15, 15, 125)
	local cuboid = createColCuboid(v[4], v[5], v[6]-1, 6.15, 6.6, 4)
	setElementData(marker, "cuboid", cuboid)
end

for i,v in ipairs(texty) do
	local text = createElement("text")
	setElementData(text, "text", "Stanowisko zmiany lamp #"..i)
	setElementPosition(text, v[1], v[2], v[3]+1.7)
end

addEvent("swiatla:color", true)
addEventHandler("swiatla:color", root, function(pojazd, r, g, b)
	local color = {r,g,b}
	setVehicleHeadLightColor(pojazd, tonumber(color[1]), tonumber(color[2]), tonumber(color[3]))
end)