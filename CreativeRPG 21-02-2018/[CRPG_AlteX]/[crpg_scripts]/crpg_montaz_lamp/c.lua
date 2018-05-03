function dxDrawButton(x, y, w, h, color)
  local color2 = tocolor(0,255,25)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x-0.4660164, y + h-1.6, w+1.5, 2, color2, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 3, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 3, color, false)
end

local lista = {
{"Blue", 0, 0, 255, 1000, "#0000ff"},
{"Neon Blue", 0, 255, 239, 1000, "#00FFEF"},
{"Pink", 255, 0, 255, 1000, "#CC00CC"},
{"Orange", 255, 128, 0, 1000, "#FF8000"},
{"Green", 0, 204, 0, 1000, "#00CC00"},
{"Neon Green", 102, 204, 0, 1000, "#80FF00"},
{"Purple", 179, 0, 255, 1000, "#B300FF"},
}

local vehicle = false

local gridlist = false
local screenW, screenH = guiGetScreenSize()
local sx, sy = guiGetScreenSize()

function mysz(psx,psy,pssx,pssy,abx,aby)
    if not isCursorShowing() then return end
    cx,cy=getCursorPosition()
    cx,cy=cx*sx,cy*sy
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true,cx,cy
    else
        return false
    end
end

function roundedRectangle(x, y, w, h, color)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x + 2, y + h, w - 4, 1, color, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 4, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 4, color, false)
end

local czcionka = dxCreateFont(":crpg_fonty", 15)
if not czcionka then
    czcionka = "default"
end

function gui()
        roundedRectangle(screenW * 0.3328, screenH * 0.2870, screenW * 0.3349, screenH * 0.4259, tocolor(15,15,15,222), false)
        roundedRectangle(screenW * 0.3328, screenH * 0.2870, screenW * 0.3349, screenH * 0.0574, tocolor(0,255,25,125), false)
        dxDrawText("Panel zmiany koloru lamp", (screenW * 0.3323) + 1, (screenH * 0.2870) + 1, (screenW * 0.6677) + 1, (screenH * 0.3444) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Panel zmiany koloru lamp", screenW * 0.3323, screenH * 0.2870, screenW * 0.6677, screenH * 0.3444, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        if mysz(screenW * 0.3516, screenH * 0.6472, screenW * 0.1339, screenH * 0.0528) then
            dxDrawButton(screenW * 0.3516, screenH * 0.6472, screenW * 0.1339, screenH * 0.0528, tocolor(0,255,25,125), false)
        else
            dxDrawButton(screenW * 0.3516, screenH * 0.6472, screenW * 0.1339, screenH * 0.0528, tocolor(30,30,30,225), false)
        end
        if mysz(screenW * 0.5146, screenH * 0.6472, screenW * 0.1339, screenH * 0.0528) then
            dxDrawButton(screenW * 0.5146, screenH * 0.6472, screenW * 0.1339, screenH * 0.0528, tocolor(0,255,25,125), false)
        else
            dxDrawButton(screenW * 0.5146, screenH * 0.6472, screenW * 0.1339, screenH * 0.0528, tocolor(30,30,30,225), false)
        end
        dxDrawText("Zmień kolor", (screenW * 0.3516) + 1, (screenH * 0.6463) + 1, (screenW * 0.4854) + 1, (screenH * 0.7000) + 1, tocolor(0, 0, 0, 255), 0.8, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Zmień kolor", screenW * 0.3516, screenH * 0.6463, screenW * 0.4854, screenH * 0.7000, tocolor(255, 255, 255, 255), 0.8, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Anuluj", (screenW * 0.5146) + 1, (screenH * 0.6463) + 1, (screenW * 0.6484) + 1, (screenH * 0.7000) + 1, tocolor(0, 0, 0, 255), 0.8, czcionka, "center", "center", false, false, false, false, false)
        dxDrawText("Anuluj", screenW * 0.5146, screenH * 0.6463, screenW * 0.6484, screenH * 0.7000, tocolor(255, 255, 255, 255), 0.8, czcionka, "center", "center", false, false, false, false, false)
end

addEventHandler("onClientMarkerHit", resourceRoot, function(hit)
	if hit ~= localPlayer then return end
	local cuboid = getElementData(source, "cuboid")
	if not cuboid then return end
  local frakcja = getElementData(hit, "frakcja")
  if not frakcja or frakcja ~= "Mechanik" then
    exports["crpg_powiadomienia"]:noti("Nie jesteś zatrudniony jako Mechanik, zatrudnić się możesz w urzędzie.")
    return
  end
	local pojazd = getElementsWithinColShape(cuboid, "vehicle")
	if #pojazd < 1 then
		exports["crpg_powiadomienia"]:noti("Na stanowisku zmiany lamp nie znajduje się pojazd.")
		return 
	end
	if #pojazd > 1 then 
		exports["crpg_powiadomienia"]:noti("Na stanowisku zmiany lamp jest zbyt dużo pojazdów.")
		return 
	end
	addEventHandler("onClientPreRender", root, gui)
	showCursor(true, false)
	vehicle = pojazd[1]
    gridlist = exports["dxlists"]:dxCreate(screenW * 0.3432, screenH * 0.3537, screenW * 0.3151, screenH * 0.2806, 4)
    exports["dxlists"]:dxAddColumn(4, "ID", 50) 
    exports["dxlists"]:dxAddColumn(4, "Nazwa", 125)
    exports["dxlists"]:dxAddColumn(4, "     Kolor", 105)
    exports["dxlists"]:dxAddColumn(4, "Cena", 125) 
	for i,v in pairs(lista) do
		exports["dxlists"]:dxAddItem(1, tostring(i), 4) 
		exports["dxlists"]:dxAddItem(2, tostring(v[1]), 4) 
		exports["dxlists"]:dxAddItem(3, v[6].."██", 4) 
		exports["dxlists"]:dxAddItem(4, "£"..tostring(v[5]), 4) 
	end
end)

local stuningowal = false

addEventHandler("onClientMarkerLeave", resourceRoot, function(hit)
	if hit ~= localPlayer then return end
	if gridlist == false then return end
	vehicle = false
	showCursor(false)
	gridlist = false
	exports["dxlists"]:dxDestroy(4)
	removeEventHandler("onClientPreRender", root, gui)
end)

addEventHandler("onClientClick", root, function(b, state)
  	if b ~= "state" and state ~= "down" then return end
  	if mysz(screenW * 0.3516, screenH * 0.6472, screenW * 0.1339, screenH * 0.0528) and gridlist ~= false and stuningowal ~= true then
  		local kolor = exports["dxlists"]:dxItemDetails(4, 2)
  		local cena = exports["dxlists"]:dxItemDetails(4, 4)
  		if kolor and cena then
  			local hajs = getElementData(localPlayer, "pieniadze")
        	cena = string.gsub(cena, "[£]", "")
  			cena = tonumber(cena)
  			if cena > hajs then
  				exports["crpg_powiadomienia"]:noti("Brak wystarczających funduszy.")
  				return
  			end
  			for i,v in ipairs(lista) do
  				if v[1] == kolor then
  					triggerServerEvent("swiatla:color", localPlayer, vehicle, v[2], v[3], v[4])
  				end
  			end
  		end
  	elseif mysz(screenW * 0.5146, screenH * 0.6472, screenW * 0.1339, screenH * 0.0528) and gridlist ~= false then
  		vehicle = false
		showCursor(false)
		gridlist = false
		exports["dxlists"]:dxDestroy(4)
		removeEventHandler("onClientPreRender", root, gui)
  	end
 end)