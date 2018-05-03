--[[
Autor: Asper
Skrypt: Bankomaty
]]

local bankomaty = {
-- LV
{2082.12, 2487.89, 11.08, 360},
{2002.37, 2302.92, 10.82, 0},
{1981.57, 944.44, 10.81, 0},
{2569.58, 1056.60, 10.82, 180},
{2397.33, 1982.88, 10.82, 0},
{1312.63, 2089.57, 10.82, 270},
{1019.87, 1382.87, 10.82, 0},
-- FC
{175.18, 1175.59, 14.76, 330},
{-157.55, 1078.61, 19.74, 180},
-- SF
{-1724.15, 1276.99, 7.14, 225},
{-2374.56, 904.96, 45.45, 270},
{-2594.65, 131.33, 4.34, 270},
{-1830.28, 107.59, 15.12, 90},
{-2528.25, -624.95, 132.76, 180},
{-1702.03, 792.22, 24.89, 270},
}

addEvent("oBank", true)
addEventHandler("oBank", root, function(c, i, cz)
	if i and not tonumber(i) then
		exports["aw-noti"]:noti("Podana wartość nie jest liczbą.", source)
		return
	end
	if cz and cz == "wp" then
		if getElementData(source, "pieniadze") < i then
			exports["aw-noti"]:noti("Brak wystarczających funduszy.", source)
			return
		end
		setElementData(source, "bkasa", getElementData(source, "bkasa")+i)
  		setElementData(source, "pieniadze", getElementData(source, "pieniadze")-i)
	elseif cz and cz == "wy" then
		if getElementData(source, "bkasa") < i then
			exports["aw-noti"]:noti("Brak wystarczających funduszy.", source)
			return
		end
		setElementData(source, "bkasa", getElementData(source, "bkasa")-i)
  		setElementData(source, "pieniadze", getElementData(source, "pieniadze")+i)
	end
	if c == "zapisz" then
		for i,v in ipairs(getElementsByType("player")) do
			if getElementData(v, "dbid") == getElementData(source, "dbid") then
				exports.mysql:wykonaj("UPDATE konta SET bkasa=? WHERE dbid=?", getElementData(v, "bkasa"), getElementData(v, "dbid"))
			end
		end
	elseif c == "zaladuj" then
		local s = exports.mysql:wykonaj("SELECT * FROM konta WHERE dbid=?", getElementData(source, "dbid"))
		for i,v in ipairs(getElementsByType("player")) do
			if getElementData(v, "dbid") == getElementData(source, "dbid") then
				setElementData(v, "bkasa", s[1].bkasa)
			end
		end
	end
end)

addEventHandler("onResourceStart", resourceRoot, function()
	for _, v in ipairs(bankomaty) do
		local bankomat = createObject(2942, v[1], v[2], v[3]-0.4, 0, 0, v[4])
		local cuboid = createColSphere(v[1], v[2], v[3], 1.3)
		local blip = createBlipAttachedTo(bankomat, 52)
		setBlipVisibleDistance(blip, 300)
		addEventHandler("onColShapeHit", cuboid, okno)
		addEventHandler("onColShapeLeave", cuboid, vokno)
	end
end)

function okno(hit)
	triggerClientEvent(hit, "bOkno", hit)
end

function vokno(hit)
	triggerClientEvent(hit, "vOkno", hit)
end
