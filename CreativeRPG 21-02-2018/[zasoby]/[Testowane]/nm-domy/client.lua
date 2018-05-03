--[[
Autorzy: MKL,MALENTAS,ASPEREK
]]

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

function shadowText(text,x,y,w,h,color,size,font,xx,yy)
	dxDrawText(text,x+1,y+1,w+1,h+1,tocolor(0,0,0),size,font,xx,yy,false)
	dxDrawText(text,x,y,w,h,color,size,font,xx,yy,false)
end

bindKey( 'i', 'both', function( key, keyState )
	if keyState == 'down' then
		for k, v in ipairs ( getElementsByType( 'colshape', resourceRoot ) ) do
			local dom=getElementData(v,"dom")
			if tonumber(dom.wlasciciel) then
				createBlipAttachedTo( v, 32, 2, 255,0,0,255,100,500 );
			else
				createBlipAttachedTo( v, 31, 2, 255,0,0,255,100,500 );
			end
		end
	else
		for k, v in ipairs( getElementsByType( 'blip', getResourceRootElement() ) ) do
			destroyElement(v)
		end
	end

end)

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

local ustawienia = nil
local panel = false

local edit = guiCreateEdit(0.35, 0.50, 0.26, 0.04, "1", true)  
guiSetVisible(edit, false)
guiEditSetMaxLength(edit, 2)
guiSetAlpha(edit, 255)

local czcionka = dxCreateFont(":crpg_fonty/f.ttf", 10) or "default-bold"

function guiKupno()
        roundedRectangle(screenW * 0.2653, screenH * 0.4067, screenW * 0.4444, screenH * 0.2300, tocolor(0, 0, 0, 180), false)
        roundedRectangle(screenW * 0.2653, screenH * 0.3700, screenW * 0.4444, screenH * 0.0478, tocolor(74, 178, 1, 255), false)
  local info = "Panel kupna domu"
  if ustawienia.wlasciciel == getElementData(localPlayer, "dbid") then
    info = "Panel przedłużania domu"
  end
  local dni = "Ilość dni"
  if ustawienia.wlasciciel == getElementData(localPlayer, "dbid") then
    dni = "Ilość dni\n(( Dom jest opłacony do "..ustawienia.data.."))"
  end
shadowText(info, screenW * 0.2639, screenH * 0.3689, screenW * 0.7097, screenH * 0.4178, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
shadowText(dni, screenW * 0.2639, screenH * 0.4178, screenW * 0.7097, screenH * 0.4922, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
  if mysz(screenW * 0.3833, screenH * 0.5667, screenW * 0.1944, screenH * 0.0533) then
    roundedRectangle(screenW * 0.3833, screenH * 0.5667, screenW * 0.1944, screenH * 0.0533, tocolor(74, 178, 1, 155), false)
  else
   roundedRectangle(screenW * 0.3833, screenH * 0.5667, screenW * 0.1944, screenH * 0.0533, tocolor(74, 178, 1, 255), false)
  end
shadowText("Zakup", screenW * 0.3826, screenH * 0.5667, screenW * 0.5778, screenH * 0.6200, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
  if mysz(screenW * 0.6778, screenH * 0.5889, screenW * 0.0250, screenH * 0.0367) then
    roundedRectangle(screenW * 0.6778, screenH * 0.5889, screenW * 0.0250, screenH * 0.0367, tocolor(74, 178, 1, 155), false)
  else
    roundedRectangle(screenW * 0.6778, screenH * 0.5889, screenW * 0.0250, screenH * 0.0367, tocolor(74, 178, 1, 255), false)
  end
shadowText("X", screenW * 0.6771, screenH * 0.5878, screenW * 0.7028, screenH * 0.6256, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
end

function gui()
  local nazwa = ustawienia.nazwa
        roundedRectangle(screenW * 0.2653, screenH * 0.7133, screenW * 0.4444, screenH * 0.2300, tocolor(0, 0, 0, 180), false)
        roundedRectangle(screenW * 0.2653, screenH * 0.6778, screenW * 0.4444, screenH * 0.0467, tocolor(74, 178, 1, 249), false)
        shadowText(nazwa, screenW * 0.2646, screenH * 0.6767, screenW * 0.7097, screenH * 0.7244, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
  local wlasciciel = ustawienia.nwlasciciel
  local cena = ustawienia.cena
  local id = ustawienia.id
  local info = wlasciciel
  if wlasciciel == "brak" then
    info = "brak"
  end
  shadowText("ID domku: "..id.."\nWłaściciel domku: "..info.."\nCena domku "..cena.." PLN", screenW * 0.2646, screenH * 0.7289, screenW * 0.7097, screenH * 0.8522, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
  if mysz(screenW * 0.2715, screenH * 0.8633, screenW * 0.1271, screenH * 0.0533) then
    roundedRectangle(screenW * 0.2715, screenH * 0.8633, screenW * 0.1271, screenH * 0.0533, tocolor(74, 178, 1, 155), false)
  else
    roundedRectangle(screenW * 0.2715, screenH * 0.8633, screenW * 0.1271, screenH * 0.0533, tocolor(74, 178, 1, 255), false)
  end
shadowText("Zobacz Dom", screenW * 0.2708, screenH * 0.8633, screenW * 0.3986, screenH * 0.9167, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
  if mysz(screenW * 0.4215, screenH * 0.8633, screenW * 0.1271, screenH * 0.0533) then
    roundedRectangle(screenW * 0.4215, screenH * 0.8633, screenW * 0.1271, screenH * 0.0533, tocolor(74, 178, 1, 155), false)
  else
    roundedRectangle(screenW * 0.4215, screenH * 0.8633, screenW * 0.1271, screenH * 0.0533, tocolor(74, 178, 1, 255), false)
  end
  local bnapis = ""
  if ustawienia.wlasciciel ~= "brak" and ustawienia.wlasciciel ~= getElementData(localPlayer, "dbid") then
    bnapis = "Dom został już wynajęty"
  elseif ustawienia.wlasciciel == "brak" then
    bnapis = "Kup dom"
  elseif ustawienia.wlasciciel ~= "brak" and ustawienia.nwlasciciel == getPlayerName(localPlayer) then
    bnapis = "Przedłuż dom"
  end
  shadowText(bnapis, screenW * 0.4215, screenH * 0.8633, screenW * 0.5493, screenH * 0.9167, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
  if ustawienia.wlasciciel == getElementData(localPlayer, "dbid") then
    if mysz(screenW * 0.5694, screenH * 0.8633, screenW * 0.1271, screenH * 0.0533) then
      roundedRectangle(screenW * 0.5694, screenH * 0.8633, screenW * 0.1271, screenH * 0.0533, tocolor(74, 178, 1, 155), false)
    else
      roundedRectangle(screenW * 0.5694, screenH * 0.8633, screenW * 0.1271, screenH * 0.0533, tocolor(74, 178, 1, 255), false)
    end
    shadowText("Zwolnij dom", screenW * 0.5694, screenH * 0.8633, screenW * 0.6972, screenH * 0.9167, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
  end
end



addEventHandler("onClientClick", root, function(b, s)
  if b ~= "state" and s ~= "down" then return end
  if mysz(screenW * 0.2715, screenH * 0.8633, screenW * 0.1271, screenH * 0.0533) and panel == true then
    triggerServerEvent("tdDomu", localPlayer, ustawienia.x, ustawienia.y, ustawienia.z, ustawienia.int, ustawienia.id)
  elseif mysz(screenW * 0.5694, screenH * 0.8633, screenW * 0.1271, screenH * 0.0533) and panel == true then
    if ustawienia.wlascciel ~= "brak" and ustawienia.wlasciciel ~= getElementData(localPlayer, "dbid") then return end
    triggerServerEvent("zDom", localPlayer, ustawienia.id)
    		outputChatBox("Pomyślnie zwolniłeś dom o id "..ustawienia.id)
  elseif mysz(screenW * 0.4215, screenH * 0.8633, screenW * 0.1271, screenH * 0.0533) and panel == true then
    if ustawienia.wlasciciel ~= "brak" and ustawienia.wlasciciel ~= getElementData(localPlayer, "dbid") then return end
    addEventHandler("onClientRender", root, guiKupno)
    guiSetVisible(edit, true)
  elseif mysz(screenW * 0.6778, screenH * 0.5889, screenW * 0.0250, screenH * 0.0367) and guiGetVisible(edit) == true then
    guiSetVisible(edit, false)
    removeEventHandler("onClientRender", root, guiKupno)
  elseif mysz(screenW * 0.3833, screenH * 0.5667, screenW * 0.1944, screenH * 0.0533) and guiGetVisible(edit) == true then
    local text = guiGetText(edit)
    if not tonumber(text) then return end
    if tonumber(text) < 1 then
      		outputChatBox("Ilość dni musi przekracać minimum zero.")
      return
    end
    triggerServerEvent("kDom", localPlayer, ustawienia.id, tonumber(text), ustawienia.cena)
  end
end)

addEventHandler("onClientColShapeHit", resourceRoot, function(hit)
  if hit ~= localPlayer then return end
  local dom = getElementData(source, "dom")
  if not dom then return end
  if panel == true then return end
  ustawienia = dom
  showCursor(true, false)
  panel = true
  addEventHandler("onClientRender", root, gui)
end)

addEventHandler("onClientMarkerHit", resourceRoot, function(hit)
  if hit ~= localPlayer then return end
  if getElementDimension(source) ~= getElementDimension(hit) then return end
  local wdom = getElementData(source, "wdom")
  if not wdom then return end
  triggerServerEvent("tdDomu", hit, wdom.x, wdom.y, wdom.z)
end)

addEventHandler("onClientColShapeLeave", resourceRoot, function(hit)
  if hit ~= localPlayer then return end
  local dom = getElementData(source, "dom")
  if not dom then return end
  ustawienia = false
  showCursor(false)
  panel = false
  removeEventHandler("onClientRender", root, gui)
  if guiGetVisible(edit) == true then
    removeEventHandler("onClientRender", root, guiKupno)
    guiSetVisible(edit, false)
  end
end)