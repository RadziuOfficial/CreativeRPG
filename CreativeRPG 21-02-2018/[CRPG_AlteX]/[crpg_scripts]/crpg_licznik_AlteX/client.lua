
local screenW, screenH = guiGetScreenSize()
ww,hh = 1920, 1080
w, h = (screenW/ww), (screenH/hh)

addEventHandler("onClientRender", root, function()

    local veh = getPedOccupiedVehicle(localPlayer)
	if not veh then return end
	
		local sx, sy, sz = getElementVelocity(veh)
		local predkosc = (sx^2 + sy^2 + sz^2)^(0.5)
		local kmh = predkosc * 180
		local paliwo = getElementData(pojazd, "vehicle:fuel") or 100
		paliwo = string.format("%1d", paliwo)
		paliwo = paliwo*1.22
		local km = getElementData(pojazd, "vehicle:mileage") or 0
        	dxDrawText(string.format("%08.1f",km).." km", (screenW * 0.8651) + 1, (screenH * 0.9009) + 1, (screenW * 0.9396) + 1, (screenH * 0.9269) + 1, tocolor(0, 0, 0, 255), 1*wn, arial, "center", "center", false, false, false, false, false)
       		dxDrawText(string.format("%08.1f",km).." km", screenW * 0.8651, screenH * 0.9009, screenW * 0.9396, screenH * 0.9269, tocolor(255, 255, 255, 255), 1*wn, arial, "center", "center", false, false, false, false, false)
			--dxDrawText(kmh, screenW * 0.3800, screenH * 0.2650, screenW * 0.6462, screenH * 0.3817, tocolor(255, 255, 255, 255), 2.00, "clear", "center", "center", false, false, false, false, false)
		
			dxDrawImage(1420*w, 580*h, 500*w, 500*h, ":crpg_licznik/licznikblue.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	
			dxDrawImage(1420*w, 580*h, 500*w, 500*h, ":crpg_licznik/strzalka.png", (kmh)/1.23, 0, 0, tocolor(255, 255, 255, 255), false)
			
end)