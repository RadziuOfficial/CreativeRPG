function roundedRectangle(x, y, w, h, color)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x + 2, y + h, w - 4, 1, color, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 4, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 4, color, false)
end



local screenW, screenH = guiGetScreenSize()

local vehicle={}
vehicle.id=nil
vehicle.speed=nil
vehicle.driver=nil

local option={}
value=nil
element=nil
option.selected=0
option.actived=false

option["vehicle"]={
    "Wystaw Mandat",
}
function isPedAiming ( thePedToCheck )
	if isElement(thePedToCheck) then
		if getElementType(thePedToCheck) == "player" or getElementType(thePedToCheck) == "ped" then
			if getPedTask(thePedToCheck, "secondary", 0) == "TASK_SIMPLE_USE_GUN" then
				return true
			end
		end
	end
	return false
end

function isRendering()
    if option.actived == true then
    	if not element then return end
        if value == "vehicle" then
	local sx,sy,sz = getElementVelocity(element)
        local km = math.ceil(((sx^2+sy^2+sz^2)^(0.5))*155)
        roundedRectangle(screenW * 0.3986, screenH * 0.8222, screenW * 0.2292, screenH * 0.1056, tocolor(0, 0, 0, 180), false)
	roundedRectangle(screenW * 0.3986, screenH * 0.8044, screenW * 0.2292, screenH * 0.0333, tocolor(78, 174, 1, 255), false)
        dxDrawText(""..km.."km/h", screenW * 0.3986, screenH * 0.8378, screenW * 0.6278, screenH * 0.8978, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        dxDrawText(option[value][option.selected] or "Wybierz opcje (scrollem)", screenW * 0.4007, screenH * 0.9011, screenW * 0.6278, screenH * 0.9278, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        dxDrawText("Suszarka SAPD", screenW * 0.4104, screenH * 0.7967, screenW * 0.5993, screenH * 0.8456, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
		end
    end
end

addEventHandler("onClientPlayerTarget",root, function(el)
    if isPedAiming(localPlayer) and el and getPedWeapon(localPlayer) == 24 then
        if not option.actived  then
            if getElementType(el) == "vehicle" then
                value="vehicle"
                element=el
                option.actived=true
            else return end
            bindKey("mouse1", "down", onElementClicked)
            bindKey("mouse_wheel_down", "down", onElementMoveDown)
            bindKey("mouse_wheel_up", "down", onElementMoveUp)
			bindKey("arrow_d", "down", onElementMoveDown)
			bindKey("arrow_u", "down", onElementMoveDown)
            addEventHandler("onClientHUDRender", root, isRendering)
        end
    else
        if option.actived then
            vehicle.el=nil
            option.actived=false
            unbindKey("mouse1", "down", onElementClicked)
            unbindKey("mouse_wheel_down", "down", onElementMoveDown)
            unbindKey("mouse_wheel_up", "down", onElementMoveUp)
			unbindKey("arrow_d", "down", onElementMoveDown)
			unbindKey("arrow_u", "down", onElementMoveDown)
            removeEventHandler("onClientHUDRender", root, isRendering)
        end
    end
end)

function onElementMoveUp() if option.selected > 4 then option.selected=1 else option.selected=option.selected+1 end end
function onElementMoveDown() if option.selected < 1 then option.selected=4 else option.selected=option.selected-1 end end
function onElementClicked() if option.selected > 0 then triggerServerEvent("onDryerAction2", localPlayer, value, option.selected, element) end end

function blokada ( prevSlot, newSlot )
	if getPedWeapon(getLocalPlayer(), newSlot) == 24 then
		toggleControl ( "fire", false ) --disable the aim button
	else 
		toggleControl ( "fire", true ) --renable the aim button
	end
end
addEventHandler ( "onClientPlayerWeaponSwitch", getRootElement(), blokada )