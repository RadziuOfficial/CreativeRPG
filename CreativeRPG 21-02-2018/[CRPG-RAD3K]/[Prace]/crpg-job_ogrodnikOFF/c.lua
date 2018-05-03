--[[
Autor: Malentas
Dla: .sunnyRPG
NIE MASZ PRAWA DO UŻYWANIA KODU BEZ MOJEJ ZGODY!!!!!!!!!
]]

local screenW, screenH = guiGetScreenSize()
local sx, sy = guiGetScreenSize()

function outputChatBox_(text)
	exports["nm-noti"]:noti(text)
end

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

local marker = createMarker(-2404.89, 695.61, 35.85-1,"cylinder",1.1, 0, 94, 254, 100)

local czcionka = dxCreateFont(":nm-scoreboard/czcionka.ttf", 10) or "default-bold"

addEventHandler("onClientMarkerHit", marker, function(el, md)
    if not md or getElementType(el) ~= "player" then return end
    if el ~= localPlayer then return end
    if not getElementData(localPlayer, "pracujeTory") then
		setElementData(localPlayer,"pracujeTory", true)
        showMarker()
		outputChatBox_("Rozpocząłeś pracę.")
        toggleControl("jump", false)
        toggleControl("enter_exit", false)
    else
       setElementData(localPlayer,"pracujeTory", false)
       finishJob()
	   outputChatBox_("Zakończyłeś pracę.")
		toggleControl("jump", true)
		toggleControl("enter_exit", true)
    end
end)

local punkty = {
  {-2416.88, 678.82, 35.16},
  {-2438.45, 687.11, 35.11},
  {-2465.55, 676.63, 34.48},
  {-2460.19, 655.74, 33.93},
  {-2437.45, 640.89, 33.78},
  {-2409.47, 647.57, 34.67},
  {-2460.28, 634.34, 32.18},
  {-2509.16, 640.08, 28.78},
  {-2514.04, 675.46, 28.44},
  {-2495.34, 601.56, 22.87},
  {-2485.52, 585.76, 18.90}, 
}

local stany = {
    "dobry",
    "słaby",
    "zniszczony",
    "do naprawy",
}


function showMarker(el, md)
        rnd = punkty[math.random(#punkty)]
        tutajpracujesz = createMarker(rnd[1], rnd[2], rnd[3]-1, "cylinder", 1.2, 255, 0, 0, 200 )
        tutajpracujesz2 = createBlip(rnd[1], rnd[2], rnd[3], 12)
        addEventHandler("onClientMarkerHit", tutajpracujesz, function(el,md)
	if not md or getElementType(el) ~= "player" then return end
        if el ~= localPlayer then return end
       if not getPedOccupiedVehicle(el) then
        outputChatBox_("Sprawdzasz stan torów...")
        setElementFrozen(localPlayer, true)
        triggerServerEvent("dajAnimke", localPlayer)
        setTimer(function()
        local rp = getElementData(localPlayer,"punkty")
        local losrp = math.random(1,10) 
        if losrp == 4 then
        setElementData(localPlayer,"punkty", rp+1)
        outputChatBox_("Za dobrą prace dostajesz dodatkowe 1 RP")
        end
        local los=math.random(#stany)
        local pieniadze = getElementData(localPlayer,"pieniadze")
	if getElementData(localPlayer,"premium") then
        local zarobek = math.random(140,160)
        setElementData(localPlayer, "pieniadze", pieniadze+zarobek)
        outputChatBox_("Sprawdziłeś stan torów i jest "..stany[los]..". Zarabiasz "..zarobek.." PLN")
        setElementFrozen(localPlayer, false)
        triggerServerEvent("offAnimke", localPlayer)
        else
        local zarobek2 = math.random(100,115)
        setElementData(localPlayer, "pieniadze", pieniadze+zarobek2)
        outputChatBox_("Sprawdziłeś stan torów i jest "..stany[los]..". Zarabiasz "..zarobek2.." PLN")
        setElementFrozen(localPlayer, false)
        triggerServerEvent("offAnimke", localPlayer)
        end
        finishJob()
        showMarker()
           end, 6000, 1)
end
end)
end

function finishJob()
	if tutajpracujesz and isElement(tutajpracujesz) then
		destroyElement(tutajpracujesz)
		tutajpracujeszr=nil
	end
	if tutajpracujesz2 and isElement(tutajpracujesz2) then
		destroyElement(tutajpracujesz2)
		tutajpracujesz2=nil
	end
end