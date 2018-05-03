--[[
  Autor: Asper
  Dla: .newMode
  Skrypt: przechowalnia
]]

local screenW,screenH = guiGetScreenSize()

function roundedRectangle(x, y, w, h, color)
  exports["nm-blur"]:dxDrawBluredRectangle(x, y, w, h, tocolor(255,255,255), false)
  exports["nm-blur"]:dxDrawBluredRectangle(x + 2, y - 1, w - 4, 1, tocolor(255,255,255), false)
  exports["nm-blur"]:dxDrawBluredRectangle(x + 2, y + h, w - 4, 1, tocolor(255,255,255), false)
  exports["nm-blur"]:dxDrawBluredRectangle(x - 1, y + 2, 1, h - 4, tocolor(255,255,255), false)
  exports["nm-blur"]:dxDrawBluredRectangle(x + w, y + 2, 1, h - 4, tocolor(255,255,255), false)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x + 2, y + h, w - 4, 1, color, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 4, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 4, color, false)
end

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


addEventHandler("onClientRender", root, function()
  for i,v in ipairs(getElementsByType("vehicle")) do
    if getElementData(v, "obracanie") then
      local rx, ry, rz = getVehicleRotation(v)
      setElementRotation(v, 0, 0, rz+1)
    end
  end
end)

-- kary --

function guikary()
	    local auto = getPedOccupiedVehicle (localPlayer)
	    local kwota = getElementData(auto,"kwotakary")
	    local powod = getElementData(auto,"powodkary")
	    dxDrawRectangle(screenW * 0.3715, screenH * 0.2378, screenW * 0.2875, screenH * 0.4867, tocolor(0, 0, 0, 180), false)
        dxDrawRectangle(screenW * 0.3715, screenH * 0.1978, screenW * 0.2875, screenH * 0.0622, tocolor(74, 178, 1, 255), false)
        dxDrawText("Kara", screenW * 0.3708, screenH * 0.1967, screenW * 0.6590, screenH * 0.2600, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        dxDrawText("Auto posiada nałożoną kare przez policje\n\nKwota: "..kwota.."\n\nPowód: "..powod.."\n\n Aby zapłacić za kare i móc jeździć swoim autem kliknij \"Opłać kare\"", screenW * 0.3701, screenH * 0.2600, screenW * 0.6590, screenH * 0.5111, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        dxDrawRectangle(screenW * 0.4007, screenH * 0.5167, screenW * 0.2250, screenH * 0.0700, tocolor(74, 178, 1, 255), false)
        dxDrawRectangle(screenW * 0.4007, screenH * 0.6078, screenW * 0.2250, screenH * 0.0700, tocolor(74, 178, 1, 255), false)
        dxDrawText("Opłać kare", screenW * 0.4000, screenH * 0.5156, screenW * 0.6257, screenH * 0.5867, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        dxDrawText("Nie płac za kare", screenW * 0.4000, screenH * 0.6067, screenW * 0.6257, screenH * 0.6778, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
end

jestoknokary = false

addEvent("oknoKary", true)
addEventHandler("oknoKary", root, function()
	addEventHandler("onClientRender", root, guikary)
	jestoknokary = true
	showCursor(true)
end)

addEventHandler("onClientClick", root, function(btn, state)
if btn == "left" and state == "down" then
if mysz(screenW * 0.4007, screenH * 0.5167, screenW * 0.2250, screenH * 0.0700) and jestoknokary == true then
local kasa = getElementData(localPlayer,"pieniadze")
local auto = getPedOccupiedVehicle (localPlayer)
local kwota = getElementData(auto,"kwotakary")
setElementData(localPlayer,"pieniadze", kasa-kwota)
outputChatBox("Zapłaciłeś za kare "..kwota.."")
jestoknokary = false
showCursor(false)
removeEventHandler("onClientRender", root, guikary)
setElementData(auto,"kara", false)
elseif mysz(screenW * 0.4007, screenH * 0.6078, screenW * 0.2250, screenH * 0.0700) and jestoknokary == true then
triggerServerEvent("wybralnieplace", localPlayer)
jestoknokary = false
showCursor(false)
removeEventHandler("onClientRender", root, guikary)
end
end
end)


addCommandHandler("dajkare", function()
local auto = getPedOccupiedVehicle (localPlayer)
setElementData(auto,"powodkary", "Ty chuju")
setElementData(auto,"kwotakary", 5)
setElementData(auto,"kara", true)
end)

-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local blip = {}
addEventHandler("onClientRender", root, function()
	for i,v in ipairs(getElementsByType("vehicle")) do
		if not blip[v] then
			--local org = getElementData(v, "veh:org")
			local owner = getElementData(v, "wlasciciel")
			local uid = getElementData(localPlayer, "dbid")
			--local oname = getElementData(localPlayer, "nazwa")
			if owner and owner == uid then
				blip[v] = createBlipAttachedTo(v, 0, 1, 255, 0, 0, 255, 1, 9999)
				setBlipVisibleDistance(blip[v], 250)
			elseif org and org == oname then
				blip[v] = createBlipAttachedTo(v, 0, 1, 0, 0, 255, 255, 1, 9999)
				setBlipVisibleDistance(blip[v], 250)
			end
		end
	end
end)

addEventHandler("onClientElementDestroy", root, function()
	if getElementType(source) ~= "vehicle" then return end
	if blip[source] then
		destroyElement(blip[source])
		blip[source] = false
	end
end)
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------