--[[
Autor: Asper, DomiiPlay
Zakaz uzywania bez zgody autora!
Zakaz udostepniania bez zgody autora!
--]]

local screenW, screenH = guiGetScreenSize()
 
local panel = false

local font = dxCreateFont(":crpg_fonty/f.ttf", 15)
local font3 = dxCreateFont(":crpg_fonty/f.ttf", 13)
local serwer = false
local pomoc = false
local przewodnik = false
local premium = false
local statystyki = false
local aktualizacje = false

function roundedRectangle(x, y, w, h, color)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x + 2, y + h, w - 4, 1, color, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 4, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 4, color, false)
end

function dxDrawButton(x, y, w, h, color)
  local color2 = tocolor(0,94,254)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x-0.4660164, y + h-1.6, w+1.5, 2, color2, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 3, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 3, color, false)
end

function PrzyciskiPanelF1()
	dxDrawButton(screenW * 0.1526, screenH * 0.2306, screenW * 0.6745, screenH * 0.5852, tocolor(15, 15, 15, 222), false)
	if cursorPosition(screenW * 0.160, screenH * 0.245, screenW * 0.105, screenH * 0.06) then --Przycisk serwer
		dxDrawButton(screenW * 0.160, screenH * 0.245, screenW * 0.105, screenH * 0.06, tocolor(0, 94, 254, 125), false)
	else
		dxDrawButton(screenW * 0.160, screenH * 0.245, screenW * 0.105, screenH * 0.06, tocolor(15, 15, 15, 222), false)
	end
	dxDrawText("Serwer", screenW * 0.160+1, screenH * 0.490+1, screenW * 0.265+1, screenH * 0.06+1, tocolor(0,0,0), 1, font, "center", "center", false)
	dxDrawText("Serwer", screenW * 0.160, screenH * 0.490, screenW * 0.265, screenH * 0.06, white, 1, font, "center", "center", false)

	if cursorPosition(screenW * 0.271, screenH * 0.245, screenW * 0.105, screenH * 0.06) then --Przycisk Pomoc
		dxDrawButton(screenW * 0.271, screenH * 0.245, screenW * 0.105, screenH * 0.06, tocolor(0, 94, 254, 125), false)
	else
		dxDrawButton(screenW * 0.271, screenH * 0.245, screenW * 0.105, screenH * 0.06, tocolor(15, 15, 15, 222), false)
	end
	dxDrawText("Pomoc", screenW * 0.505+1, screenH * 0.490+1, screenW * 0.140+1, screenH * 0.06+1, tocolor(0,0,0), 1, font, "center", "center")
	dxDrawText("Pomoc", screenW * 0.505, screenH * 0.490, screenW * 0.140, screenH * 0.06, white, 1, font, "center", "center")

	if cursorPosition(screenW * 0.382, screenH * 0.245, screenW * 0.105, screenH * 0.06) then --Przycisk Przewodnik
		dxDrawButton(screenW * 0.382, screenH * 0.245, screenW * 0.105, screenH * 0.06, tocolor(0, 94, 254, 125), false)
	else
		dxDrawButton(screenW * 0.382, screenH * 0.245, screenW * 0.105, screenH * 0.06, tocolor(15, 15, 15, 222), false)
	end
	dxDrawText("Przewodnik", screenW * 0.730+1, screenH * 0.490+1, screenW * 0.140+1, screenH * 0.06+1, tocolor(0,0,0), 1, font, "center", "center")
	dxDrawText("Przewodnik", screenW * 0.730, screenH * 0.490, screenW * 0.140, screenH * 0.06, white, 1, font, "center", "center")

	if cursorPosition(screenW * 0.493, screenH * 0.245, screenW * 0.105, screenH * 0.06) then --Przycisk Premium
		dxDrawButton(screenW * 0.493, screenH * 0.245, screenW * 0.105, screenH * 0.06, tocolor(0, 94, 254, 125), false)
	else
		dxDrawButton(screenW * 0.493, screenH * 0.245, screenW * 0.105, screenH * 0.06, tocolor(15, 15, 15, 222), false)
	end
	dxDrawText("Premium", screenW * 0.950+1, screenH * 0.490+1, screenW * 0.140+1, screenH * 0.06+1, tocolor(0,0,0), 1, font, "center", "center")
	dxDrawText("Premium", screenW * 0.950, screenH * 0.490, screenW * 0.140, screenH * 0.06, white, 1, font, "center", "center")

	if cursorPosition(screenW * 0.604, screenH * 0.245, screenW * 0.105, screenH * 0.06) then --Przycisk Statystyki
		dxDrawButton(screenW * 0.604, screenH * 0.245, screenW * 0.105, screenH * 0.06, tocolor(0, 94, 254, 125), false)
	else
		dxDrawButton(screenW * 0.604, screenH * 0.245, screenW * 0.105, screenH * 0.06, tocolor(15, 15, 15, 222), false)
	end
	dxDrawText("Statystyki", screenW * 1.170+1, screenH * 0.490+1, screenW * 0.140+1, screenH * 0.06+1, tocolor(0,0,0), 1, font, "center", "center")
	dxDrawText("Statystyki", screenW * 1.170, screenH * 0.490, screenW * 0.140, screenH * 0.06, white, 1, font, "center", "center")

	if cursorPosition(screenW * 0.715, screenH * 0.245, screenW * 0.105, screenH * 0.06) then --Przycisk 1
		dxDrawButton(screenW * 0.715, screenH * 0.245, screenW * 0.105, screenH * 0.06, tocolor(0, 94, 254, 125), false)
	else
		dxDrawButton(screenW * 0.715, screenH * 0.245, screenW * 0.105, screenH * 0.06, tocolor(15, 15, 15, 222), false)
	end
	dxDrawText("Aktualizacje", screenW * 1.400+1, screenH * 0.490+1, screenW * 0.140+1, screenH * 0.06+1, tocolor(0,0,0), 1, font, "center", "center")
	dxDrawText("Aktualizacje", screenW * 1.400, screenH * 0.490, screenW * 0.140, screenH * 0.06, white, 1, font, "center", "center")

end

function Serwer()
	local Alpha = interpolateBetween(25, 0, 0, 255, 0, 0, ((getTickCount() - czas) / 2400), "Linear")
	dxDrawText("CreativeRPG", (screenW * 0.260) + 1, (screenH * 0.105) + 1, (screenW * 0.7489) + 1, (screenH * 0.6849) + 1, tocolor(0, 94, 254, Alpha), 1.20, font3, "center", "center", false)	
    dxDrawText("Forum: creativerpg.pl\n\nTS3: kraina-haju.pl\n\nStart Serwera: 16-02-2018\n\nZałożyciele: RAD3K, AlteX and Nuliss", (screenW * 0.260) + 1, (screenH * 0.450) + 1, (screenW * 0.7489) + 1, (screenH * 0.6849) + 1, tocolor(255, 255, 255, Alpha), 1.00, font3, "center", "center", false)	
end

function Pomoc()
	local Alpha = interpolateBetween(25, 0, 0, 255, 0, 0, ((getTickCount() - czas) / 2400), "Linear")
	dxDrawText("Pomoc dotycząca Serwera", (screenW * 0.260) + 1, (screenH * 0.105) + 1, (screenW * 0.7489) + 1, (screenH * 0.6849) + 1, tocolor(0, 94, 254, Alpha), 1.20, font3, "center", "center", false)
	dxDrawText("Komendy:\n\n/report (nick/id) (powód) - zgłoszenie gracza do administracji\n/me - czat do odgrywania RP\n/do - czat to odgrywania RP\n\nBindy:\nF1 - przewodnik\nF4 - schowanie hudu\nF5 - panel organizacji", (screenW * 0.260) + 1, (screenH * 0.450) + 1, (screenW * 0.7489) + 1, (screenH * 0.6849) + 1, tocolor(255, 255, 255, Alpha), 1.00, font3, "center", "center", false)
end

function Przewodnik()
	local Alpha = interpolateBetween(25, 0, 0, 255, 0, 0, ((getTickCount() - czas) / 2400), "Linear")
	dxDrawText("Przewodnik", (screenW * 0.260) + 1, (screenH * 0.105) + 1, (screenW * 0.7489) + 1, (screenH * 0.6849) + 1, tocolor(0, 94, 254, Alpha), 1.20, font3, "center", "center", false)
	--dxDrawText("Grę rozpoczynamy w stanie San Andreas w miescie Los Santos przy głównym urzędzie.\nRozgrywka na serwerze polega na odgrywaniu życia realnego w rozgrywce wirtualnej,\ntzw. Role Play. Serwer jest trypu Role Play Gaming więc odgrywanie życia realnego\njest tylko do pewnych granic, lecz warto pamiętać że trzeba je odgrywać.\nPrzed rozgrywką radzimy również zapoznać się z regulaminem na naszym forum!\nPierw zalecane jest udanie się do przebielarni gdzie wybierzesz swoją postać.\nNajlepiej jest udać się do szkoły jazdy gdzie zdaje się egzamin na prawo jazdy,\ndzięki niemu możesz wykonywać niektóre prace do których potrzebne są prawa jazdy.\nPo wyszkoleniu swojej jazdy po drogach San Andreas czas na zarobek by kupić cos dla siebie.\nZa zdobyte pieniądzę można kupić wiele udogodzeń, a to co chcesz zrobić z pieniędzmi\nzależy tylko i wyłącznie od Ciebie! ", (screenW * 0.1057) + 1, (screenH * 0.3885) + 1, (screenW * 0.9023) + 1, (screenH * 0.7745) + 1, tocolor(255, 255, 255, Alpha), 1.00, font3, "center", "center", false, true, false, false, false)
end

function Premium()
	local Alpha = interpolateBetween(25, 0, 0, 255, 0, 0, ((getTickCount() - czas) / 2400), "Linear")
	dxDrawText("Konto Premium", (screenW * 0.260) + 1, (screenH * 0.105) + 1, (screenW * 0.7489) + 1, (screenH * 0.6849) + 1, tocolor(0, 94, 254, Alpha), 1.20, font3, "center", "center", false)
	dxDrawText("Informacje o koncie premium:\n\nDodatki:\n-Skiny premium;\n-Większe zarobki na niektórych pracach;\n-1000 PLN co godzine;\n-5 RP co godzine;\n-Tansze paliwo;\n\nNarazie panel jest w budowie, jeśli chcesz zakupić premium to pisz do RAD3K!", (screenW * 0.260) + 1, (screenH * 0.450) + 1, (screenW * 0.7489) + 1, (screenH * 0.6849) + 1, tocolor(255, 255, 255, Alpha), 1.00, font3, "center", "center", false)
end

function mth(minutes)
	local h = math.floor(minutes/60)
	local m = minutes - (h*60)
	return {h,m}
end

function Statystyki()
	local Alpha = interpolateBetween(25, 0, 0, 255, 0, 0, ((getTickCount() - czas) / 2400), "Linear")
	dxDrawText("Statystyki", (screenW * 0.260) + 1, (screenH * 0.105) + 1, (screenW * 0.7489) + 1, (screenH * 0.6849) + 1, tocolor(0, 94, 254, Alpha), 1.20, font3, "center", "center", false)
			local minuty = getElementData(localPlayer, "online")
			local dbid = getElementData(localPlayer, "dbid")
    	local premium = "?"
    	local org = "?"
    	if getElementData(localPlayer, "premium") then
      		premium = "Posiadasz"
    	else
      		premium = "Nie posiadasz"
    	end
    	if getElementData(localPlayer, "org") then
    		org = getElementData(localPlayer, "organizacja")
    	else
    		org = "brak"
    	end
	dxDrawText("UID: "..dbid.."\nLogin: "..getPlayerName(localPlayer).."\nPrzegrany czas: "..mth(minuty)[1].."h "..mth(minuty)[2].."m\nKonto premium: "..premium.."\nReputacja: "..getElementData(localPlayer, "punkty").."\nRejestracja: "..getElementData(localPlayer, "rejestracja").."\nOrganizacja: "..org, (screenW * 0.1057) + 1, (screenH * 0.3885) + 1, (screenW * 0.9023) + 1, (screenH * 0.7745) + 1, tocolor(255, 255, 255, Alpha), 1.00, font3, "center", "center", false, true, false, false, false)
end

function Aktualizacje()
	local Alpha = interpolateBetween(25, 0, 0, 255, 0, 0, ((getTickCount() - czas) / 2400), "Linear")   
	dxDrawText("Aktualizacje", (screenW * 0.260) + 1, (screenH * 0.105) + 1, (screenW * 0.7489) + 1, (screenH * 0.6849) + 1, tocolor(0, 94, 254, Alpha), 1.20, font3, "center", "center", false)
	for i,v in ipairs(getElementsByType("updates")) do
		local updates = getElementData(v, "aktualizacje")
		if not updates then
			updates = "2018-02-21: Została ukończona frakcja San Andreas Medical Departament //AlteX"
		end
		dxDrawText(updates, (screenW * 0.260) + 1, (screenH * 0.450) + 1, (screenW * 0.7489) + 1, (screenH * 0.6849) + 1, tocolor(255, 255, 255, Alpha), 1.00, font3, "center", "center", false)
	end
end
	
function Informacje(button, state)
	if panel and button == "left" and state == "down" then
		if cursorPosition(screenW * 0.160, screenH * 0.245, screenW * 0.105, screenH * 0.06) and serwer ~= true then
            removeEventHandler ("onClientRender", root, Pomoc)
            removeEventHandler ("onClientRender", root, Przewodnik)
            removeEventHandler ("onClientRender", root, Premium)
            removeEventHandler ("onClientRender", root, Statystyki)
            removeEventHandler ("onClientRender", root, Aktualizacje)
            addEventHandler ("onClientRender", root, Serwer)
            pomoc = false
            przewodnik = false
            premium = false
            statystyki = false
            serwer = true
            aktualizacje = false
            czas = getTickCount()
		elseif cursorPosition(screenW * 0.271, screenH * 0.245, screenW * 0.105, screenH * 0.06) and pomoc ~= true then
            removeEventHandler ("onClientRender", root, Serwer)
            removeEventHandler ("onClientRender", root, Przewodnik)
            removeEventHandler ("onClientRender", root, Premium)
            removeEventHandler ("onClientRender", root, Statystyki)
            removeEventHandler ("onClientRender", root, Aktualizacje)
            pomoc = true
            przewodnik = false
            premium = false
            statystyki = false
            serwer = false
            aktualizacje = false
            addEventHandler ("onClientRender", root, Pomoc)
            czas = getTickCount()
		elseif cursorPosition(screenW * 0.382, screenH * 0.245, screenW * 0.105, screenH * 0.06) and przewodnik ~= true then
            removeEventHandler ("onClientRender", root, Serwer)
            removeEventHandler ("onClientRender", root, Pomoc)
            removeEventHandler ("onClientRender", root, Premium)
            removeEventHandler ("onClientRender", root, Statystyki)
            removeEventHandler ("onClientRender", root, Aktualizacje)
            pomoc = false
            przewodnik = true
            premium = false
            statystyki = false
            serwer = false
            aktualizacje = false
            addEventHandler ("onClientRender", root, Przewodnik)
            czas = getTickCount()
		elseif cursorPosition(screenW * 0.493, screenH * 0.245, screenW * 0.105, screenH * 0.06) and premium ~= true then
            removeEventHandler ("onClientRender", root, Serwer)
            removeEventHandler ("onClientRender", root, Pomoc)
            removeEventHandler ("onClientRender", root, Przewodnik)
            removeEventHandler ("onClientRender", root, Statystyki)
            removeEventHandler ("onClientRender", root, Aktualizacje)
            addEventHandler ("onClientRender", root, Premium)
            pomoc = false
            przewodnik = false
            premium = true
            statystyki = false
            serwer = false
            aktualizacje = false
            czas = getTickCount()
		elseif cursorPosition(screenW * 0.604, screenH * 0.245, screenW * 0.105, screenH * 0.06) and statystyki ~= true then
            removeEventHandler ("onClientRender", root, Serwer)
            removeEventHandler ("onClientRender", root, Pomoc)
            removeEventHandler ("onClientRender", root, Przewodnik)
            removeEventHandler ("onClientRender", root, Premium)
            removeEventHandler ("onClientRender", root, Aktualizacje)
            addEventHandler ("onClientRender", root, Statystyki)
            pomoc = false
            przewodnik = false
            premium = false
            statystyki = true
            serwer = false
            aktualizacje = false
            czas = getTickCount()
		elseif cursorPosition(screenW * 0.715, screenH * 0.245, screenW * 0.105, screenH * 0.06) and aktualizacje ~= true then
            removeEventHandler ("onClientRender", root, Serwer)
            removeEventHandler ("onClientRender", root, Pomoc)
            removeEventHandler ("onClientRender", root, Przewodnik)
            removeEventHandler ("onClientRender", root, Premium)
            removeEventHandler ("onClientRender", root, Statystyki)
            addEventHandler ("onClientRender", root, Aktualizacje)
            pomoc = false
            przewodnik = false
            premium = false
            statystyki = false
            serwer = false
            aktualizacje = true
            czas = getTickCount()
        end
    end
end
addEventHandler("onClientClick", getRootElement(), Informacje)
	
function PrzewodnikF1()
    if panel == false then
    	setElementData(localPlayer, "hud", true)
		showPlayerHudComponent("all", false)
		showChat(false)
        tick = getTickCount()
        addEventHandler ("onClientRender", root, PrzyciskiPanelF1)
        addEventHandler ("onClientRender", root, Serwer)
        panel = true
        czas = getTickCount()
        serwer = true
        showCursor(true)
    else
    			setElementData(localPlayer, "hud", false)
		showPlayerHudComponent("all", true)
  		showPlayerHudComponent("money", false)
  		showPlayerHudComponent("area_name", false)
  		showPlayerHudComponent("radio", false)
  		showPlayerHudComponent("vehicle_name", false)
  		showChat(true)
  		showPlayerHudComponent ("health", false)
		showPlayerHudComponent ("clock", false)
		showPlayerHudComponent ("breath", false)
		showPlayerHudComponent ("weapon", false)
		showPlayerHudComponent ("armour", false)
		showPlayerHudComponent ("ammo", false)
        removeEventHandler ("onClientRender", root, PrzyciskiPanelF1)
        removeEventHandler ("onClientRender", root, Premium)
        removeEventHandler ("onClientRender", root, Serwer)
        removeEventHandler ("onClientRender", root, Pomoc)
        removeEventHandler ("onClientRender", root, Przewodnik)
        removeEventHandler ("onClientRender", root, Statystyki)
        removeEventHandler ("onClientRender", root, Aktualizacje)
        panel = false
        showCursor(false)
            pomoc = false
            przewodnik = false
            premium = false
            statystyki = false
            serwer = false
            aktualizacje = false
    end
end
bindKey ("F1", "down", PrzewodnikF1)

function cursorPosition(x, y, w, h)
	if (not isCursorShowing()) then
		return false
	end
	local mx, my = getCursorPosition()
	local fullx, fully = guiGetScreenSize()
	cursorx, cursory = mx*fullx, my*fully
	if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
		return true
	else
		return false
	end
end