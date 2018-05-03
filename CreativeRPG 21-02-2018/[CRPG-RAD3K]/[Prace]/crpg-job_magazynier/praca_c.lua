local jobPoints = {
{2527.21, -1669.29, 114.19},
{2533.28, -1659.20, 114.19},
{2533.38, -1638.09, 114.19},
{2527.48, -1632.28, 114.19},
{2516.39, -1666.96, 114.19},
{2522.04, -1662.70, 114.19},
{2522.25, -1637.78, 114.19},
{2516.32, -1641.84, 114.19},
{2511.46, -1667.35, 114.19},
{2505.36, -1662.24, 114.19},
{2511.14, -1638.25, 114.19},
{2505.46, -1640.42, 114.19},
{2500.05, -1661.36, 114.19},
{2494.99, -1669.90, 114.19},
{2494.37, -1644.54, 114.19},
{2499.61, -1635.23, 114.19},
{2483.56, -1659.41, 114.19},
}


local jobMarker
local jobStartMarker=createMarker(2555.78, -1663.79, 114.19-3.5, "cylinder", 3.7, 255, 0, 0, 125)
setElementInterior(jobStartMarker, 1)

local textPraca = createElement("text")
setElementPosition(textPraca, 2555.78, -1663.79, 114.19-0.5)
setElementData(textPraca, "text", "Praca dorywcza\n>magazynier<\nKLIKNIJ E ŻEBY ROZPOCZĄC PRACE!")
setElementInterior(textPraca, 1)

function finishJob()
	if jobMarker and isElement(jobMarker) then
		destroyElement(jobMarker)
		jobMarker=nil
	end
	if jobTarget and isElement(jobTarget) then
		destroyElement(jobTarget)
		jobTarget=nil
	end
end

local function showMarker()
	rnd=math.random(1, #jobPoints)
	jobMarker=createMarker(jobPoints[rnd][1], jobPoints[rnd][2], jobPoints[rnd][3], "checkpoint", 1.5, 0, 0, 255, 0)
    setElementInterior(jobMarker, 1)	
	
	addEventHandler("onClientMarkerHit", jobMarker, function(el,md)
	local hajs = getElementData(el, "pieniadze") or 0
	local gracz = math.random(30,40)	
	local premium = math.random(35,55)		
		if el~=localPlayer or not md then return end
		if not getPedOccupiedVehicle(el) then
			setElementFrozen(el, true)
			setTimer(function()
				finishJob()
				playSoundFrontEnd(1)
				setElementFrozen(el, false)
				toggleControl("jump", true)
				toggleControl("sprint", true)
				toggleControl("enter_exit", true)
				setElementData(el, "praca", false)				
			if getElementData(el,"premium") then
		    setElementData(el, "pieniadze", hajs+premium)
		    exports["crpg_powiadomienia"]:noti("#FFFF00✪#FFFFFF Twoje wynagrodzenie wynosi "..premium.." PLN!", el)		
        else
		    setElementData(el, "pieniadze", hajs+gracz)
		    exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Twoje wynagrodzenie wynosi "..gracz.." PLN!", el)	
        end
				destroyElement(obiekt)
				destroyElement(blip)
				setPedAnimation(localPlayer, false)
			end, 5000, 1)
		end
	end)
end

bindKey("e", "down", function()
	if isElementWithinMarker(localPlayer, jobStartMarker) then		
		if not getElementData(localPlayer, "praca") then		
		obiekt = createObject(2912,0,0,0,0,0,0)
		setElementCollisionsEnabled(obiekt,false)
		setElementDoubleSided(obiekt,true)
		setObjectScale(obiekt,0.8)
		attachElements(obiekt,localPlayer,0-0.03,0.6,0.32,0,0,0,0)
        setElementInterior(obiekt, 1)	
		setPedAnimation ( localPlayer, "CARRY", "crry_prtial", 1,true )
		    exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Zanieś paczkę na wskazany regał!")	
			setElementData(localPlayer, "praca", true)
			toggleControl("enter_exit", false)
			toggleControl("sprint", false)
			toggleControl("jump", false)
			showMarker()
		else
            exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Posiadasz aktywną pracę!")	
		end
	end
end)