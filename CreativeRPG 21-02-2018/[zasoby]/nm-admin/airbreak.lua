local f = dxCreateFont(":crpg_fonty/f.ttf", 15)
local sx, sy = guiGetScreenSize()
local screenW, screenH = guiGetScreenSize()
function putPlayerInPosition(timeslice)
    local cx,cy,cz,ctx,cty,ctz = getCameraMatrix()
    ctx,cty = ctx-cx,cty-cy
    timeslice = timeslice*0.08
    local tx, ty, tz = getWorldFromScreenPosition(sx / 2, sy / 2, 10)
    if getKeyState("lctrl") then timeslice = timeslice*3 end
    if getKeyState("lalt") then timeslice = timeslice*0.35 end
    local mult = timeslice/math.sqrt(ctx*ctx+cty*cty)
    ctx,cty = ctx*mult,cty*mult
    if getKeyState("2") then abx,aby = abx+ctx,aby+cty end
    if getKeyState("w") then abx,aby = abx+ctx,aby+cty end
    if getKeyState("s") then abx,aby = abx-ctx,aby-cty end
    if getKeyState("a") then  abx,aby = abx-cty,aby+ctx end
    if getKeyState("d") then abx,aby = abx+cty,aby-ctx end
    if getKeyState("space") then  abz = abz+timeslice end
    if getKeyState("lshift") then   abz = abz-timeslice end
    local xxd,yxd = 100,200
    if not getElementData(localPlayer, "hud") then
    	--dxDrawText("Pozycja gracza:\nX: "..string.format("%.2f", abx).."\nY: "..string.format("%.2f", aby).."\nZ: "..string.format("%.2f", abz), sx/1.2+1,sy/2+1,sx/2+1,sy/2+1, tocolor(0,0,0), 1, f, "left", "top", false)
    	dxDrawBorderedText("Pozycja gracza:\nX: "..string.format("%.2f", abx).."\nY: "..string.format("%.2f", aby).."\nZ: "..string.format("%.2f", abz), sx/1.2,sy/2,sx/2,sy/2, tocolor(255,255,255), 1, f, "left", "top", false)
    end
    if isPedInVehicle (localPlayer) then
    	local vehicle = getPedOccupiedVehicle(localPlayer)
    	local angle = getPedCameraRotation(localPlayer)
    	setElementPosition(vehicle,abx,aby,abz)
    	setElementRotation(vehicle,0,0,-angle)
    else
    	local angle = getPedCameraRotation(localPlayer)
    	setElementRotation(localPlayer,0,0,angle)
    	setElementPosition(localPlayer,abx,aby,abz)
    end
end

function toggleAirBrake()
	if  getElementData(localPlayer, "duty") == 4 or getElementData(localPlayer, "duty") == 3 then
    if dev_mode ~= true then
    	dev_mode = true
        if isPedInVehicle (localPlayer) then
        	local vehicle = getPedOccupiedVehicle(localPlayer)
        	abx,aby,abz = getElementPosition(vehicle)
        	Speed,AlingSpeedX,AlingSpeedY = 0,1,1
        	OldX,OldY,OldZ = 0
        	setElementCollisionsEnabled(vehicle, false)
        	setElementFrozen(vehicle, true)
        	addEventHandler("onClientPreRender",root,putPlayerInPosition)
    	else
        	abx,aby,abz = getElementPosition(localPlayer)
        	Speed,AlingSpeedX,AlingSpeedY = 0,1,1
        	OldX,OldY,OldZ = 0
        	setElementCollisionsEnabled(localPlayer, false)
        	addEventHandler("onClientPreRender",root,putPlayerInPosition)
    	end
    else
    	dev_mode = false
    	if isPedInVehicle (localPlayer) then
        	local vehicle = getPedOccupiedVehicle(localPlayer)
        	abx,aby,abz = false
        	setElementFrozen(vehicle, false)
        	setElementCollisionsEnabled(vehicle, true)
        	removeEventHandler("onClientPreRender",root,putPlayerInPosition)
        else
        	abx,aby,abz = false
        	setElementCollisionsEnabled(localPlayer, true)
        	removeEventHandler("onClientPreRender",root,putPlayerInPosition)
        end
     end
  end
end
bindKey("0", "down", toggleAirBrake)

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