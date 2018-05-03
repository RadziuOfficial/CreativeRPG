
createObject(3379,1768.84,-1860.04,13.58)














function outputChatBox_(text)
	exports["noti"]:noti(text)
end
--zdjecie


local pasazerow = math.random(2,6)

local linia = {1,2,3,4,5}
local nzwa = math.random(1,#linia)


local markerPositions = {

[1]= {"Linia 129",{
{1765.21,-1857.66,13.41},
{1826.22,-1800.27,13.39},
{2050.62,-1757.37,13.55},
{2076.57,-1857.54,13.55}
}},
[2]= {"Linia 772",{
{1765.21,-1857.66,13.41},
{1826.22,-1800.27,13.39},
{2050.62,-1757.37,13.55},
{2076.57,-1857.54,13.55}
}},
  [3]= {"Linia 772",{
{1765.21,-1857.66,13.41},
{1826.22,-1800.27,13.39},
{2050.62,-1757.37,13.55},
{2076.57,-1857.54,13.55}
  }},
  [4]= {"Linia 772",{
{1765.21,-1857.66,13.41},
{1826.22,-1800.27,13.39},
{2050.62,-1757.37,13.55},
{2076.57,-1857.54,13.55}
  }},
  [5]= {"Linia 772",{
{1765.21,-1857.66,13.41},
{1826.22,-1800.27,13.39},
{2050.62,-1757.37,13.55},
{2076.57,-1857.54,13.55}

  }},
	
}




local _VARS = {
	jobName = "Praca Komunikacji Miejskiej",
jobPosition = {-1940.1145019531, 575.84063720703, 35.157329559326},
	-- sposób zarobku
	-- random = one za kazdy marker
	-- queue = za wszystkie markery
	queueType = "queue",

	payment = pasazerow*5,




--bilet

spChance = 3,

freezeTime = 8000, -- if not false then freezes for freezeTime in miliseconds
unfreezeMessage = "Wszyscy zajeli miejsca !, ruszaj dalej.",

markerHitMessage = "Zatrzymujesz się na przystanku, do autobusu wsiada "..pasazerow.." pasażerów." ,

paymentCompanyPercent = 50, --ile procent pieniedzy wiecej za prace w firmie

fillingSystem = false,
fText = "Zapełnienie ", -- przed
fPrefix = "%", -- sztuki
fFull = 100, -- maksymalne zapelgowno
fUpper = 1,  -- NUMBER or {MIN,MAX}
fPerOnePayment = 1, -- platnosc za jeden punkt
fEmptyPlace = {0,0,3}, -- pozycja wyplaty
fFreeze = false -- w milisekundach freeze pojazdu po wjechaniu w rozladowanie

--pasażerowie
}

local tempCMP = nil
-- triggerClientEvent ( DOKOGO, "onGreeting", resourceRoot )

function table.random(tbl)
return tbl[math.random(1,#tbl)]
end

local _TEMPVARS = {
	VEHICLE = false,
	ACTUALMARKER = false,
	ACTUALKEY = false,
	ACTUALFILLED = false,
	DESC = false,
	EMPTYMARKER = false
}

local prevmarker = false

function gNM()
	if markerPositions[nzwa][2][_TEMPVARS.ACTUALKEY+1] then
		return markerPositions[nzwa][2][_TEMPVARS.ACTUALKEY+1]
	else
		return markerPositions[nzwa][2][1]
	end
end





function getNextMarker()
	if _VARS.queueType == "queue" then
		if not _TEMPVARS.ACTUALKEY then
			_TEMPVARS.ACTUALKEY = 1
		else
			if markerPositions[nzwa][2][_TEMPVARS.ACTUALKEY + 1] then
				_TEMPVARS.ACTUALKEY = _TEMPVARS.ACTUALKEY + 1
			else
				_TEMPVARS.ACTUALKEY = 1
			end

		end
	end
	if _VARS.queueType == "random" then
    local test = false
    repeat 
--createMarker
		test = math.random(1,#markerPositions[nzwa][2])
		until test ~= _TEMPVARS.ACTUALKEY
			_TEMPVARS.ACTUALKEY = test
	end
		return markerPositions[nzwa][2][_TEMPVARS.ACTUALKEY]
end

function math.randompercent(percent)
	local number = math.random()
	number = number * 100
	if number <= percent then
		return true
	else
		return false
	end
	return false
end

function getPaymentText()
	local cmpPlus = ((_VARS.payment/100)*(_VARS.paymentCompanyPercent))
	if tempCMP then
		return "Otrzymujesz #00ff33"..(_VARS.payment).." PLN#ffffff."
	else
		return "Otrzymujesz #00ff33"..(_VARS.payment).." PLN#ffffff."
	end
end
--
function markersRepeat(first)
	if not first then
		if not _VARS.fillingSystem then
		if not tempCMP then
	triggerServerEvent( "onJobPay", resourceRoot, _VARS.payment )
else
local cmpPlus = ((_VARS.payment/100)*(_VARS.paymentCompanyPercent))
triggerServerEvent( "onJobPay", resourceRoot, _VARS.payment+cmpPlus )
end

					local sp = getElementData(localPlayer,"data:sp") or 0
					if math.randompercent(_VARS.spChance) then
						setElementData(localPlayer,"data:sp",sp+1)
						outputChatBox_("Otrzymałeś losowo punkty respektu !.")
					end
				else
					local uppers = false
					if type(_VARS.fUpper) == "table" then
						uppers = math.random(unpack(_VARS.fUpper))
					else
						uppers = _VARS.fUpper
					end
					_TEMPVARS.ACTUALFILLED = _TEMPVARS.ACTUALFILLED + uppers
					if _TEMPVARS.ACTUALFILLED > _VARS.fFull then
						_TEMPVARS.ACTUALFILLED = _VARS.fFull
					end
					local syntax = _TEMPVARS.DESC.."\n".._VARS.fText.._TEMPVARS.ACTUALFILLED.._VARS.fPrefix
					setElementData(_TEMPVARS.VEHICLE,"vehicle:opis",syntax)
					local sp = getElementData(localPlayer,"data:sp") or 0
					if math.randompercent(_VARS.spChance) then
						setElementData(localPlayer,"data:sp",sp+1)
						outputChatBox_("Otrzymałeś losowo punkty respektu !.")
					end
				end
end
--markerPositions

	if _TEMPVARS.ACTUALMARKER then
			destroyElement(_TEMPVARS.ACTUALMARKER)
		end
		local x, y, z = unpack(getNextMarker())
		
		_TEMPVARS.ACTUALMARKER = createMarker( x, y, z-0.9, "cylinder", 4.0, 0 ,100 ,255 , 30 )

		setElementParent(createBlip( x, y, z, 41 ),_TEMPVARS.ACTUALMARKER )
		if _VARS.queueType == "queue" then
			x, y, z = unpack(gNM())
			local marker = createMarker(x,y,z,"checkpoint",1.75,0,255,0,50)
		
       		setElementParent(marker,_TEMPVARS.ACTUALMARKER)
			setElementParent(createBlip( x, y, z, 41 ),_TEMPVARS.ACTUALMARKER )
					setMarkerTarget(_TEMPVARS.ACTUALMARKER,x,y,z)
		end
		addEventHandler("onClientMarkerHit",_TEMPVARS.ACTUALMARKER,function (hitPlayer)
			if hitPlayer == localPlayer and getPedOccupiedVehicle(hitPlayer) and getPedOccupiedVehicle(hitPlayer) == _TEMPVARS.VEHICLE then
				markersRepeat()
				setVehicleDoorOpenRatio ( _TEMPVARS.VEHICLE, 3, 1, 1000 )

				local open = playSound( "opendoor.mp3" )
                setSoundVolume( open, 0.3 ) 
                setTimer( function() destroyElement(open) end, 1500, 1 )
				

				
				
				
			    setTimer(function() 
				local zamknij = playSound( "closedoor.mp3" )
                setSoundVolume( zamknij, 0.3 ) 
                setTimer( function() destroyElement(zamknij) end, 1000, 1 ) 
				setVehicleDoorOpenRatio(_TEMPVARS.VEHICLE,3,0,1000)
				
				end, 8000, 1 )
						
			--startJobL
--

				if _VARS.markerHitMessage then
					outputChatBox_(_VARS.markerHitMessage..(getPaymentText()))
				else
					outputChatBox_(getPaymentText())
				end

				if _VARS.freezeTime then
					setElementFrozen(_TEMPVARS.VEHICLE,true)
					setTimer(function () setElementFrozen(_TEMPVARS.VEHICLE,false) if _VARS.unfreezeMessage then outputChatBox_(_VARS.unfreezeMessage) end end,_VARS.freezeTime,1)
				end


			end
			end,false)
	end


--
addEvent("onJobStart",true)
addEvent("stopJobClient",true)



	function stopJob()

	_TEMPVARS.VEHICLE = false
	if _TEMPVARS.ACTUALMARKER and isElement(_TEMPVARS.ACTUALMARKER) then
		destroyElement(_TEMPVARS.ACTUALMARKER)
	end
	_TEMPVARS.ACTUALMARKER = false
	_TEMPVARS.ACTUALKEY = false
	destroyElement(_TEMPVARS.CHECKINGCOL)
	_TEMPVARS.CHECKINGCOL = nil
	_TEMPVARS.ACTUALFILLED = false
	_TEMPVARS.DESC = false
	tempCMP = nil

	if _VARS.fillingSystem then
		_TEMPVARS.DESC = false
		destroyElement(_TEMPVARS.EMPTYMARKER)
		_TEMPVARS.EMPTYMARKER = false
	end
	end

addEventHandler("stopJobClient",resourceRoot,stopJob,false)

function onQuit()
			
			
			removeEventHandler("onClientPlayerQuit",localPlayer,onQuit)
			removeEventHandler("onClientColShapeLeave",_TEMPVARS.CHECKINGCOL,onColShapeMoveOut)
			removeEventHandler("onClientVehicleStartExit",_TEMPVARS.VEHICLE,onVehicleMoveOut)
			triggerServerEvent("stopJobServer",resourceRoot,_TEMPVARS.VEHICLE)
			stopJob()
end

function onVehicleMoveOut(plr)
if plr == localPlayer then
			
			
		outputChatBox_("Opuściłeś pojazd słżbowy ! Jeżeli oddalisz się od niego o #0099ff50 metrów#ffffff, praca zostanie #ff0000zakończona#ffffff !.")
		
		end
	end


--payment
function onColShapeMoveOut(plr)

		if plr == localPlayer then
					outputChatBox_("Zakończyłeś pracę.")
			
		removeEventHandler("onClientColShapeLeave",_TEMPVARS.CHECKINGCOL,onColShapeMoveOut)
		removeEventHandler("onClientPlayerQuit",localPlayer,onQuit)
		removeEventHandler("onClientVehicleStartExit",_TEMPVARS.VEHICLE,onVehicleMoveOut)
		triggerServerEvent("stopJobServer",resourceRoot,_TEMPVARS.VEHICLE)
		stopJob()

		end
end



	function startJob(veh,cmp)
		if cmp then
			tempCMP = true
		end
	_TEMPVARS.VEHICLE = veh
	markersRepeat(true)
		local x, y, z = getElementPosition(_TEMPVARS.VEHICLE)
	_TEMPVARS.CHECKINGCOL = createColSphere( x,y,z,50 )
	attachElements( _TEMPVARS.CHECKINGCOL, _TEMPVARS.VEHICLE )
	addEventHandler("onClientPlayerQuit",localPlayer,onQuit,false)
	addEventHandler("onClientColShapeLeave",_TEMPVARS.CHECKINGCOL,onColShapeMoveOut,false)
	addEventHandler("onClientVehicleStartExit",_TEMPVARS.VEHICLE,onVehicleMoveOut,false)
	setElementData(_TEMPVARS.VEHICLE,"vehicle:jobowner",localPlayer)
	if _VARS.fillingSystem then
		_TEMPVARS.ACTUALFILLED = 0
		_TEMPVARS.DESC = getElementData(_TEMPVARS.VEHICLE,"vehicle:opis")
		local syntax = _TEMPVARS.DESC.."\n".._VARS.fText.._TEMPVARS.ACTUALFILLED.._VARS.fPrefix
		setElementData(_TEMPVARS.VEHICLE,"vehicle:opis",syntax)
		local x, y, z =  unpack(_VARS.fEmptyPlace)
		_TEMPVARS.EMPTYMARKER = createMarker( x, y, z,"cylinder",3.0,0,0,0,0)
		setElementParent(createMarker( x, y, z-1,"cylinder",3.0,0,0,0,100),_TEMPVARS.EMPTYMARKER)
		setElementParent(createBlip( x, y, z,8,2,255,255,255,255,1,99999),_TEMPVARS.EMPTYMARKER)
		addEventHandler("onClientMarkerHit",_TEMPVARS.EMPTYMARKER, function(hit)
			if hit == localPlayer then
				if _TEMPVARS.ACTUALFILLED > 0 then
					local payNow = _TEMPVARS.ACTUALFILLED * _VARS.fPerOnePayment
					--on


					if tempCMP then
					    outputChatBox_("Otrzymujesz #00ff33"..(_VARS.payment).." PLN#ffffff."  )
					
						payNow = payNow + ((payNow/100)*_VARS.paymentCompanyPercent)

					else
						outputChatBox_("Otrzymujesz #00ff33"..(_VARS.payment).." PLN#ffffff.")
					end
					triggerServerEvent("onJobPay",resourceRoot,payNow)
					_TEMPVARS.ACTUALFILLED = 0
					local syntax = _TEMPVARS.DESC.."\n".._VARS.fText.._TEMPVARS.ACTUALFILLED.._VARS.fPrefix
					setElementData(_TEMPVARS.VEHICLE,"vehicle:opis",syntax)
					if _VARS.fFreeze then
						setElementFrozen(_TEMPVARS.VEHICLE,true)
						setTimer(function () setElementFrozen(_TEMPVARS.VEHICLE,false) end,_VARS.fFreeze,1)
					end

				end
			end
			end,false)


	end

end

addEventHandler("onJobStart",resourceRoot,startJob,false)


addEventHandler("onClientRender",root,function ()
	local x, y, z = getCameraMatrix()
	local x1, y1, z1 =_VARS.jobPosition[1],_VARS.jobPosition[2],_VARS.jobPosition[3]+1
	local xs, ys, ds = getScreenFromWorldPosition( _VARS.jobPosition[1],_VARS.jobPosition[2],_VARS.jobPosition[3]+1)
	if isLineOfSightClear( x,y,z,x1,y1,z1,true,false,false,true,false,false,false) then
		if xs and ys and ds and ds <= 40 then
			local val = 1/(ds/9)
			dxDrawText( _VARS.jobName,xs+val,ys+val,xs+val,ys+val,tocolor(0,0,0,255),1/(ds/9),"default","center","center")
			dxDrawText( _VARS.jobName,xs,ys,xs,ys,tocolor(255,255,255,255),1/(ds/9),"default","center","center")
		end
	end
	end)
	
	
	
	
	
txd = engineLoadTXD ("znak.txd")
engineImportTXD ( txd, 3379 )
dff = engineLoadDFF ( "znak.dff" )
engineReplaceModel ( dff, 3379 )
COL = engineLoadCOL("znak.col")
engineReplaceCOL( COL, 3379 )
removeWorldModel(3379,10000,0,0,0)