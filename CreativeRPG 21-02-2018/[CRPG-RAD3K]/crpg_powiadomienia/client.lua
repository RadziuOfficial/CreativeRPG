--[[
Autor: Asper
Zakaz udostepniania skryptu bez zgody autora!
Zakaz uzywania skryptu bez zgody autora!
]]

local czcionka = dxCreateFont("gfx/f.ttf", 10)
local screenW, screenH = guiGetScreenSize()
local tabela = {}
local gui_showed = false

function dxDrawButton(x, y, w, h, color)
  local color2 = tocolor(0,94,254)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x-0.4660164, y + h-1.6, w+1.5, 2, color2, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 3, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 3, color, false)
end

function gui()
	for i,v in ipairs(tabela) do
		local vNotka = 0 
		local nczas = getTickCount()

		if nczas > v.tick+v.czas then
			local sczas = v.tick+v.czas
			local progress = (sczas - nczas) / 12000
			v.alpha = interpolateBetween(v.alpha, 0, 0, 0, 0, 0, progress, "InOutQuad")
			v.alpha3 = interpolateBetween(v.alpha3, 0, 0, 0, 0, 0, progress, "InOutQuad")
		end
		if v.alpha < 1 then
			table.remove(tabela, 1)
			if #tabela < 1 then
				removeEventHandler("onClientRender", root, gui)
				gui_showed = false
			end
		end

		local nn = interpolateBetween(-35, 0, 0, 0, 0, 0, (getTickCount()-v.tick)/1250, "OutBack") 
		local offsetY = -((i-5)*40) 
		local width = dxGetTextWidth(v.text, 1, czcionka) + 20
		local width2 = (screenW / 2) - ((dxGetTextWidth(v.text, 1, czcionka) + 20 + 25) / 2)
		local dzie = screenW/2.5
   	 	dxDrawButton(width2+nn, offsetY+dzie, 25 + width, 35, tocolor(15,15,15,v.alpha3), false)
   	 	--dxDrawText(v.text, width2+nn+15+1, offsetY+(dzie-15)+1, width2 + 25 + 10 + width- 20+1, offsetY+(dzie+50)+1, tocolor(0, 0, 0, v.alpha), 1, czcionka, "center", "center", true, true, true, true, true)
      	dxDrawText(v.text, width2+nn+15, offsetY+(dzie-15), width2 + 25 + 10 + width- 20, offsetY+(dzie+50), tocolor(255, 255, 255, v.alpha), 1, czcionka, "center", "center", true, true, true, true, false)
    end
end

addEvent("notka", true)
addEventHandler("notka", root, function(txt)
	if #tabela > 10 then
		table.remove(tabela, 1)
	end
	table.insert(tabela, {text=txt, alpha=255, tick=getTickCount(), czas=5000, alpha3=175})
	playSound("sfx/alert.wav")	
	if gui_showed ~= true then
		addEventHandler("onClientRender", root, gui)
		gui_showed = true
	end
end)

function noti(data)
	triggerEvent("notka", localPlayer, data)
end