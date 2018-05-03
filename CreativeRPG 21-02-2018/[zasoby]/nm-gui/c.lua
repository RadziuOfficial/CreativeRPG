--[[
  Autor: Asper
  Dla: .newMode
  Skrypt: Gui
]]

function isEventHandlerAdded(sEventName,pElementAttachedTo,func)
	if type(sEventName)=='string' and isElement(pElementAttachedTo) and type(func)=='function' then local aAttachedFunctions = getEventHandlers(sEventName,pElementAttachedTo)
	if type(aAttachedFunctions)=='table' and #aAttachedFunctions > 0 then for i,v in ipairs(aAttachedFunctions) do if v==func then return true end end end
	end return false
end
local nametagFont = dxCreateFont( ":crpg_fonty/f.ttf", 10 ) or "default-bold"
local wFont = dxCreateFont(":crpg_fonty/f.ttf", 14) or "default-bold"
local wFont2 = dxCreateFont(":crpg_fonty/f.ttf", 11) or "default-bold"
local lFont = dxCreateFont("lcz.ttf", 15) or "default-bold"
local nCz = dxCreateFont( ":crpg_fonty/f.ttf", 10 ) or "default-bold"

local licznik = dxCreateFont(":crpg_fonty/f.ttf", 15) or "default-bold"
local hud = dxCreateFont(":crpg_fonty/f.ttf", 14) or "default-bold"
local street = dxCreateFont(":crpg_fonty/f3.ttf", 27) or "default-bold"

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

--[[local gp = {}
gp.napisy = guiCreateLabel(0.45, 0.29, 0.20, 0.32, "", true)
guiSetFont(gp.napisy, "default-bold-small")
guiLabelSetHorizontalAlign(gp.napisy, "center", false)
guiLabelSetVerticalAlign(gp.napisy, "center")
gp.d3 = guiCreateCheckBox(0.36, 0.31, 0.08, 0.04, "Premium 1 dni", false, true)
gp.d7 = guiCreateCheckBox(0.36, 0.38, 0.08, 0.04, "Premium 7 dni", false, true)
gp.d14 = guiCreateCheckBox(0.36, 0.46, 0.08, 0.04, "Premium 14 dni", false, true)
gp.d30 = guiCreateCheckBox(0.36, 0.53, 0.08, 0.04, "Premium 30 dni", false, true)
gp.kod = guiCreateEdit(0.36, 0.59, 0.08, 0.05, "WPISZ KOD Z SMS...", true)    
guiSetVisible(gp.napisy, false)
guiSetVisible(gp.d3, false)
guiSetVisible(gp.d7, false)
guiSetVisible(gp.d14, false)
guiSetVisible(gp.d30, false)
guiSetVisible(gp.kod, false)

addEventHandler("onClientGUIClick", resourceRoot, function()
	if source == gp.d3 or source == gp.d7 or source == gp.d14 or source == gp.d30 then
		if not guiCheckBoxGetSelected(gp.d3) or not guiCheckBoxGetSelected(gp.d7) or not guiCheckBoxGetSelected(gp.d14) or not guiCheckBoxGetSelected(gp.d30) then
			guiSetText(gp.napisy, "")
		end
        if guiCheckBoxGetSelected(gp.d3) then
        	guiCheckBoxSetSelected(gp.d7, false)
        	guiCheckBoxSetSelected(gp.d14, false)
        	guiCheckBoxSetSelected(gp.d30, false)
            guiSetText(gp.napisy, "Aby zakupić premium na 1 dni:\nWyślij SMS na numer 71480 o\ntreści MSMS.CRPG koszt smsa 1,23 zł brutto.\nNastępnie wpisz kod do okna poniżej i kliknij ZAKUP.")
        elseif guiCheckBoxGetSelected(gp.d7) then
        	guiCheckBoxSetSelected(gp.d3, false)
        	guiCheckBoxSetSelected(gp.d14, false)
        	guiCheckBoxSetSelected(gp.d30, false)
            guiSetText(gp.napisy, "Aby zakupić premium na 7 dni:\nWyślij SMS na numer 74480 o\ntreści MSMS.CRPG koszt smsa 4,92 zł brutto.\nNastępnie wpisz kod do okna poniżej i kliknij ZAKUP.")
        elseif guiCheckBoxGetSelected(gp.d14) then
        	guiCheckBoxSetSelected(gp.d7, false)
        	guiCheckBoxSetSelected(gp.d3, false)
        	guiCheckBoxSetSelected(gp.d30, false)
            guiSetText(gp.napisy, "Aby zakupić premium na 14 dni:\nWyślij SMS na numer 76480 o\ntreści MSMS.CRPG koszt smsa 7,38 zł brutto.\nNastępnie wpisz kod do okna poniżej i kliknij ZAKUP.")
        elseif guiCheckBoxGetSelected(gp.d30) then
        	guiCheckBoxSetSelected(gp.d7, false)
        	guiCheckBoxSetSelected(gp.d14, false)
        	guiCheckBoxSetSelected(gp.d3, false)  
            guiSetText(gp.napisy, "Aby zakupić premium na 30 dni:\nWyślij SMS na numer 79480 o\ntreści MSMS.CRPG koszt smsa 11,07 zł brutto.\nNastępnie wpisz kod do okna poniżej i kliknij ZAKUP.")
        end
    end
end)

function dxDrawButton(x, y, w, h, color)
  local color2 = tocolor(0,94,254)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x-0.4660164, y + h-1.6, w+1.5, 2, color2, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 3, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 3, color, false)
end

local pp = false
function guiPremka()
	    dxDrawButton(screenW * 0.3309, screenH * 0.1901, screenW * 0.3389, screenH * 0.6211, tocolor(15, 15, 15, 185))
        roundedRectangle(screenW * 0.3309, screenH * 0.1901, screenW * 0.3389, screenH * 0.0508, tocolor(0, 94, 254, 200), false)
        dxDrawBorderedText("Panel premium!", screenW * 0.3309, screenH * 0.1888, screenW * 0.6698, screenH * 0.2409, tocolor(255, 255, 255, 255), 1.00, wFont, "center", "center", false, false, false, false, false)
       	if mysz(screenW * 0.4034, screenH * 0.6576, screenW * 0.1940, screenH * 0.0599) then
        	dxDrawButton(screenW * 0.4034, screenH * 0.6576, screenW * 0.1940, screenH * 0.0599, tocolor(0,94,254,225), false)
        else
        	dxDrawButton(screenW * 0.4034, screenH * 0.6576, screenW * 0.1940, screenH * 0.0599, tocolor(30,30,30,225), false)
        end
       	if mysz(screenW * 0.4034, screenH * 0.7305, screenW * 0.1940, screenH * 0.0599) then
        	dxDrawButton(screenW * 0.4034, screenH * 0.7305, screenW * 0.1940, screenH * 0.0599, tocolor(0,94,254,225), false)
        else
        	dxDrawButton(screenW * 0.4034, screenH * 0.7305, screenW * 0.1940, screenH * 0.0599, tocolor(30,30,30,225), false)
        end
        dxDrawBorderedText("Zakup", screenW * 0.4026, screenH * 0.6563, screenW * 0.5974, screenH * 0.7174, tocolor(255, 255, 255, 255), 1.00, wFont, "center", "center", false, false, false, false, false)
        dxDrawBorderedText("Anuluj", screenW * 0.4026, screenH * 0.7305, screenW * 0.5974, screenH * 0.7904, tocolor(255, 255, 255, 255), 1.00, wFont, "center", "center", false, false, false, false, false)
end

addEventHandler("onClientClick", root, function(b, s)
    if b ~= "state" and s ~= "down" then return end
	if mysz(screenW * 0.4034, screenH * 0.6576, screenW * 0.1940, screenH * 0.0599) and pp == true then
		if guiGetText(gp.kod) == "Kod" then return end
		local dni = 0
		if guiCheckBoxGetSelected(gp.d3) then
			dni = 1
		elseif guiCheckBoxGetSelected(gp.d7) then
			dni = 7
		elseif guiCheckBoxGetSelected(gp.d14) then
			dni = 14
		elseif guiCheckBoxGetSelected(gp.d30) then
			dni = 30
		else
			dni = 0
		end
		if dni == 0 then
            exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Nie wybrałeś ilośći dni!")				
			return
		end
		triggerServerEvent("skPremium", localPlayer, guiGetText(gp.kod), dni)
		pp = false
		guiSetVisible(gp.napisy, false)
		guiSetVisible(gp.d3, false)
		guiSetVisible(gp.d7, false)
		guiSetVisible(gp.d14, false)
		guiSetVisible(gp.d30, false)
		guiSetVisible(gp.kod, false)
		showCursor(false)
		removeEventHandler("onClientPreRender", root, guiPremka)
	elseif mysz(screenW * 0.4034, screenH * 0.7305, screenW * 0.1940, screenH * 0.0599) and pp == true then
		pp = false
		guiSetVisible(gp.napisy, false)
		guiSetVisible(gp.d3, false)
		guiSetVisible(gp.d7, false)
		guiSetVisible(gp.d14, false)
		guiSetVisible(gp.d30, false)
		guiSetVisible(gp.kod, false)
		showCursor(false)
		removeEventHandler("onClientPreRender", root, guiPremka)
	end
end)

addCommandHandler("xd", function()
	if pp ~= true then
		pp = true
		guiSetVisible(gp.napisy, true)
		guiSetVisible(gp.d3, true)
		guiSetVisible(gp.d7, true)
		guiSetVisible(gp.d14, true)
		guiSetVisible(gp.d30, true)
		guiSetVisible(gp.kod, true)
		showCursor(true, false)
		addEventHandler("onClientPreRender", root, guiPremka)
	else
		pp = false
		guiSetVisible(gp.napisy, false)
		guiSetVisible(gp.d3, false)
		guiSetVisible(gp.d7, false)
		guiSetVisible(gp.d14, false)
		guiSetVisible(gp.d30, false)
		guiSetVisible(gp.kod, false)
		showCursor(false)
		removeEventHandler("onClientPreRender", root, guiPremka)
	end
end)]]


-- czas online

setTimer(function()
	local online = tonumber(getElementData(localPlayer, "online")) or 0
	if not online then return end
	setElementData(localPlayer, "online", online+1)
end, 60000, 0)

-- kordy

addCommandHandler("gp",function()
    local x,y,z = getElementPosition(localPlayer)
    local p = string.format("%.2f, %.2f, %.2f", x,y,z)
    local rx,ry,rz = getElementRotation(localPlayer)
    outputChatBox("Pozycja gracza: ".. p)
    outputChatBox("Rotacja gracza: "..rz)
    setClipboard(p)
    local pojazd = getPedOccupiedVehicle(localPlayer)
    if pojazd then
        local x,y,z = getElementPosition(pojazd)
        local rx,ry,rz = getElementRotation(pojazd)
        p = string.format("%.2f, %.2f, %.2f, %.1f, %.1f, %.1f", x, y, z, rx, ry, rz)
        outputChatBox("Pozycja pojazdu: ".. p)
        setClipboard(p)
    end
end)

addCommandHandler("gp2",function()
    local x,y,z = getElementPosition(localPlayer)
    p = string.format("%.2f, %.2f, %.2f", x,y,z)
    outputChatBox("Pozycja gracza: ".. p)
    setClipboard(p)
    local pojazd = getPedOccupiedVehicle(localPlayer)
    if pojazd then
        local x,y,z = getElementPosition(pojazd)
        local rx,ry,rz = getElementRotation(pojazd)
		    local model = getVehicleModel(pojazd)
        p = string.format("%d, %.2f, %.2f, %.2f, %.1f, %.1f, %.1f", model, x, y, z, rx, ry, rz)
        outputChatBox("Pozycja pojazdu: ".. p)
        setClipboard(p)
    end
end)

local tick = getTickCount()
local text = ""

addEvent("addOgloszenie", true)
addEventHandler("addOgloszenie", root, function(player, texti)
	text = getPlayerName(player).." ["..getElementData(player, "id").."]: "..texti
	tick = getTickCount()
	if isEventHandlerAdded("onClientRender",root,ogl) then
	removeEventHandler("onClientRender",root,ogl)
end
	addEventHandler("onClientRender", root, ogl)
	setTimer(function()
		removeEventHandler("onClientRender", root, ogl)
	end, 15000, 1)
end)

function ogl()
	if not getElementData(localPlayer, "zalogowany") then return end
	local x = interpolateBetween(screenW, screenW, 0, screenW * 0.8010, screenW * 0.8016, 0, (getTickCount()-tick)/2500, "OutBack")
	roundedRectangle(x, screenH * 0.0841, screenW * 0.1839, screenH * 0.0556, tocolor(0, 0, 0, 100), false)
	if getTickCount()-tick > 500 then
		--dxDrawText(text, (screenW * 0.8010) + 1, (screenH * 0.0852) + 1, (screenW * 0.9839) + 1, (screenH * 0.1370) + 1, tocolor(0, 0, 0, 255), 1.00, wFont2, "center", "center", false, true, false, false, false)
		dxDrawText(text, screenW * 0.8010, screenH * 0.0852, screenW * 0.9839, screenH * 0.1370, tocolor(255, 255, 0, 255), 1.00, wFont2, "center", "center", false, true, false, false, false)
	end
end

-- nametagi

setTimer(function()
	if getElementData(localPlayer, "premium_czas") and getElementData(localPlayer, "premium_czas") > 59 then
		local hajs = getElementData(localPlayer, "pieniadze")
		local mp = getElementData(localPlayer, "punkty")
		setElementData(localPlayer, "pieniadze", hajs+750)
		setElementData(localPlayer, "punkty", mp+5)
		setElementData(localPlayer, "premium_czas", 0)
		exports["nm-noti"]:noti("Premium: Za pełną godzine gry otrzymujesz 750 PLN oraz 5 RP.")
	end
	local data = getElementData(localPlayer, "premium_czas")
	if data then
		setElementData(localPlayer, "premium_czas", data+1)
	end
end, 60000, 0)

local fps = 0
local tick = getTickCount()

function getCurrentFPS()
    return fps
end

function updateFPS(msSinceLastFrame)
	if fps == 0 then
		fps = (1 / msSinceLastFrame) * 1000
	end
	if getTickCount()-tick > 1000 then
		tick = getTickCount()
		fps = (1 / msSinceLastFrame) * 1000
	end
end
addEventHandler("onClientPreRender", root, updateFPS)

addEventHandler("onClientRender", getRootElement(), function()
	if getElementData(localPlayer, "hud") then return end
	if not getElementData(localPlayer, "zalogowany") then return end
	--dxDrawText(math.floor(getCurrentFPS()).." FPS", screenW * 0.9323+1, screenH * 0.0000+1, screenW * 1.0000+1, screenH * 0.0231+1, tocolor(0,0,0, 255), 1.00, wFont, "center", "center", false, false, false, false, false)
	--dxDrawText(math.floor(getCurrentFPS()).." FPS", screenW * 0.9323, screenH * 0.0000, screenW * 1.0000, screenH * 0.0231, tocolor(255, 255, 255, 255), 1.00, wFont, "center", "center", false, false, false, false, false)
	local iks,igrek,zet = getElementPosition(localPlayer)
	local ulica = ""..getZoneName(iks,igrek,zet,true)..", "..getZoneName(iks,igrek,zet,false)
    --dxDrawText(ulica, (screenW * 0.2) + 1, (screenH * 0.8565) + 1, (screenW * 0.3208) + 1, (screenH * 0.9130) + 1, tocolor(0, 0, 0, 255), 1.00, street, "left", "top", false, false, false, false, false)
    dxDrawBorderedText(ulica, screenW * 0.0050, screenH * 1.065, screenW * 0.3208, screenH * 0.9130, tocolor(255, 255, 255, 255), 1.2, "default-bold", "left", "center", false, false, false, false, false)
	local pojazd = getPedOccupiedVehicle(localPlayer)
	if pojazd then 
		if getVehicleEngineState(pojazd) and getElementData(pojazd, "paliwo") and getElementData(pojazd, "paliwo") < 1 then
			setVehicleEngineState(pojazd, false)
		end
		if getElementData(localPlayer, "hud") then return end
		local sx,sy,sz = getElementVelocity(pojazd)
		local kmh = math.ceil(((sx^2+sy^2+sz^2)^(0.5))*143)
		local paliwo = getElementData(pojazd, "paliwo") or 100
		paliwo = string.format("%1d", paliwo)
		local km = getElementData(pojazd, "przebieg") or 0
		local bak = getElementData(pojazd, "bak") or 100
        local pojemnosc = getElementData(pojazd, "pojemnosc") or 1.2
		local vx,vy,vz = getElementVelocity(pojazd)
        local predkosc = math.ceil(((vx^2+vy^2+vz^2)^(0.5))*165)		
		
	    dxDrawImage(screenW * 0, screenH * 0, screenW * 1, screenH * 1, "licznik.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		--dxDrawText(paliwo.."/"..bak.." L", screenW * 0.7104+1, screenH * 0.9630+1, screenW * 0.8255+1, screenH * 0.993+1, tocolor(0,0,0, 255), 1.00, licznik, "center", "center", false, false, false, false, false)
		dxDrawText(paliwo.."/"..bak.." L", screenW * 0.9050, screenH * 0.5465, screenW * 0.9432, screenH * 0.9944, tocolor(255, 255, 255, 255), 1.00, licznik, "center", "center", false, false, false, false, false)
		--dxDrawText(string.format("%.2f", km).."km", (screenW * 0.8650) + 1, (screenH * 0.9685) + 1, (screenW * 0.9432) + 1, (screenH * 0.9944) + 1, tocolor(0, 0, 0, 255), 1.00, licznik, "center", "center", false, false, false, false, false)
		dxDrawText(string.format("%.2f", km).."km", screenW * 0.9050, screenH * 0.8700, screenW * 0.9432, screenH * 0.9944, tocolor(255, 255, 255, 255), 1.00, licznik, "center", "center", false, false, false, false, false)
		dxDrawText(""..predkosc.." km/h", screenW * 0.9050, screenH * 0.7100, screenW * 0.9432, screenH * 0.9944, tocolor(255, 255, 255, 255), 1.00, licznik, "center", "center", false, false, false, false, false)		
	end
	if not isPlayerMapVisible() then
	if getElementData(localPlayer, "hud") then return end
	local kasa = getElementData(localPlayer, "pieniadze")
        kasa = string.format("%1d", kasa)
		local times = getRealTime()
		times.hour = string.format("%02d", times.hour)
		times.minute = string.format("%02d", times.minute)
	    dxDrawImage(screenW * 0, screenH * 0, screenW * 1, screenH * 1, "hud.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)		
        dxDrawBorderedText(getPlayerName(localPlayer), screenW * 0.9310, screenH * -0.0035, screenW * 0.9849, screenH * 0.0796, tocolor(255, 255, 255, 255), 1.00, hud, "center", "center", false, false, false, false, false)
        dxDrawBorderedText(""..kasa.." PLN", screenW * 0.9310, screenH * 0.1000, screenW * 0.9849, screenH * 0.0796, tocolor(255, 255, 255, 255), 1.00, hud, "center", "center", false, false, false, true, false)
		dxDrawBorderedText(""..times.hour..":"..times.minute, screenW * 0.9310, screenH * 0.2025, screenW * 0.9849, screenH * 0.0796, tocolor(255, 255, 255, 255), 1.00, hud, "center", "center", false, false, false, true, false)
	end
	if getElementData(localPlayer, "pracujeMagazyn") then
		local poziom = getElementData(localPlayer, "mlvl")
		local exp = getElementData(localPlayer, "mexp")
	    dxDrawImage(screenW * 0, screenH * 0, screenW * 1, screenH * 1, "hud2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)	
        dxDrawBorderedText("Poziom: "..poziom, screenW * 0.9310, screenH * 0.3050, screenW * 0.9849, screenH * 0.0796, tocolor(255, 255, 255, 255), 1.00, hud, "center", "center", false, false, false, true, false)		
		dxDrawBorderedText("EXP: "..exp, screenW * 0.9310, screenH * 0.4050, screenW * 0.9849, screenH * 0.0796, tocolor(255, 255, 255, 255), 1.00, hud, "center", "center", false, false, false, true, false)		
        --roundedRectangle(screenW * 0.7590, screenH * 0.1844, screenW * 0.2264, screenH * 0.0622, tocolor(0, 0, 0, 100), false)
        --dxDrawText("Twój exp: "..exp.."         |         Twój poziom: "..poziom, screenW * 0.7590, screenH * 0.1833, screenW * 0.9854, screenH * 0.2467, tocolor(255, 255, 255, 255), 1.00, wFont2, "center", "center", false, false, false, false, false)
	end
  for _, p in ipairs(getElementsByType("player")) do
  	local rx, ry, rz = getCameraMatrix()
      local x, y, z = getPedBonePosition(p, 5)
      local sy, sx = getScreenFromWorldPosition(x, y, z + 0.5)
      local dystans = getDistanceBetweenPoints3D(rx, ry, rz, x, y, z)
      local alpha = getElementAlpha(p)
      local dimensions = getElementDimension(localPlayer) == getElementDimension(p)
      local interiors = getElementInterior(localPlayer) == getElementInterior(p)
      if dystans < 25 and sy and sx and interiors and dimensions and alpha > 0 and p ~= localPlayer then
      local nick = getPlayerName(p)
      local id = getElementData(p, "id")
      if not getElementData(p, "zalogowany") then return end
			--dxDrawText(nick:gsub("#%x%x%x%x%x%x","").." ("..id..")", sy + 1, sx + 6, sy + 1, sx + 1, tocolor(0, 0, 0, 190), 1, nCz, "center", "center", false, false, false, true, false)
			dxDrawBorderedText(nick.." ["..id.."]", sy, sx + 5, sy, sx, tocolor(255, 255, 255, 225), 1, nCz, "center", "center", false, false, false, true, false)
        local duty = getElementData(p, "duty")
        local premium = getElementData(p, "premium")
        local frakcja = getElementData(p, "frakcja")
	local hex = getElementData(p, "hex")
        if duty then
          ranga = hex..getElementData(p, "ranga")
        elseif frakcja == "PSP" then
         ranga = "#ff0000Państwowa Straż Pożarna#ffffff"
        elseif frakcja == "KGP" then
         ranga = "#0000ffKomenda Główna Policji#ffffff"
        elseif getElementData(p,"dbid") == 53 then
         ranga = "#8c8800Zasłużony#ffffff"
        elseif premium then
          ranga =  "#ffff43Premium#ffffff"
        else
          ranga = "#939393Gracz#ffffff"
        end
		if getPlayerName(p) == "Anonymous*" then
			ranga = "#ff00ffGruby Asper"
		end
			--dxDrawText(ranga:gsub("#%x%x%x%x%x%x",""), sy + 1, sx - 34, sy + 1, sx + 1, tocolor(0, 0, 0, 190), 1, nCz, "center", "center", false, false, false, true, false)
			dxDrawBorderedText(ranga, sy, sx - 35, sy, sx, tocolor(255, 255, 255, 225), 1, nCz, "center", "center", false, false, false, true, false)
    	end
  	end
	for _,v in ipairs(getElementsByType("vehicle")) do
	  local x1x, y1x, z1x = getElementPosition(v)
	  local x2x, y2x, z2x = getElementPosition(localPlayer)
	  local dist = getDistanceBetweenPoints3D(x1x,y1x,z1x, x2x,y2x,z2x)
	  if dist < 7 then
	      local sx,sy = getScreenFromWorldPosition(x1x, y1x, z1x)
	      if sx and sy then
	        local text = getElementData(v, "nametag") or ""
	        --dxDrawText(text, sx+1, sy+1, sx+1, sy+1, tocolor(0, 0, 0, 255), 1, nametagFont, "center", "center")
	        dxDrawBorderedText(text, sx, sy, sx, sy, tocolor(255, 255, 255, 255), 1, "sans", "center", "center")
	   		end
		end
	end
	for i,v in ipairs(getElementsByType("text")) do
		local x1, y1, z1 = getElementPosition(v)
		local x2, y2, z2 = getElementPosition(localPlayer)
		local dist = getDistanceBetweenPoints3D(x1,y1,z1, x2,y2,z2)
		if dist < 30 then
			if isLineOfSightClear(x1,y1,z1+1.2, x2,y2,z2, true, false, true, true, false, false, true, localPlayer) then
				local sx,sy = getScreenFromWorldPosition(x1, y1, z1)
				if sx and sy then
					local text = getElementData(v, "text") or ""
					dxDrawText(text, sx+1, sy+1, sx+1, sy+1, tocolor(0, 0, 0, 255), 1, nametagFont, "center", "center")
					dxDrawText(text, sx, sy, sx, sy, tocolor(255, 255, 255, 255), 1, nametagFont, "center", "center")
				end
			end
		end
	end
	if getElementData(localPlayer, "premium") then
		if getElementData(localPlayer, "premium_czas") then return end
		setElementData(localPlayer, "premium_czas", 0)
	end
end)

bindKey("F4", "down", function()
	if getElementData(localPlayer, "hud") == true then
		setElementData(localPlayer, "hud", false)
		showPlayerHudComponent ("radar", true)		
		showChat(true)
	else
		setElementData(localPlayer, "hud", true)	
		showPlayerHudComponent ("radar", false)			
		showChat(false)
	end
end)

local x1,y1,z1

addEventHandler("onClientPreRender", getRootElement(), function ()
	local pojazd = getPedOccupiedVehicle(localPlayer)
	if not pojazd then return end
 	local s = getPedOccupiedVehicleSeat(localPlayer)
	if s ~= 0 then return end
	if not x1 or not y1 or not z1 then
		x1,y1,z1 = getElementPosition(pojazd)
	end
	local x2,y2,z2 = getElementPosition(pojazd)
	local dystans = getDistanceBetweenPoints3D(x1,y1,z1, x2,y2,z2)
	if dystans > 10 then
		local przebieg = getElementData(pojazd, "przebieg")
		local paliwo = getElementData(pojazd, "paliwo")
		if przebieg then
			setElementData(pojazd, "przebieg", przebieg+0.045)
		end
		if paliwo then
			setElementData(pojazd, "paliwo", paliwo-0.020)
		end
		x1,y1,z1 = getElementPosition(pojazd)
	end
end)

addEventHandler("onClientResourceStart", resourceRoot, function()
	for _,v in ipairs(getElementsByType("player")) do
		setPlayerNametagShowing(v, false)
	end
end)

addEventHandler("onClientPlayerSpawn", root,  function()
	setPlayerNametagShowing(source, false)
end)

function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x - 1, y - 1, w - 1, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x + 1, y - 1, w + 1, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x - 1, y + 1, w - 1, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x + 1, y + 1, w + 1, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x - 1, y, w - 1, h, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x + 1, y, w + 1, h, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x, y - 1, w, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x, y + 1, w, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true )
end

function roundedRectangle(x, y, w, h, color)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x + 2, y + h, w - 4, 1, color, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 4, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 4, color, false)
end