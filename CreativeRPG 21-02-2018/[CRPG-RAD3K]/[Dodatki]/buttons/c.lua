--[[
	autor: Asper & Payro
	for: Own World
	All rights reserved!
]]

local screenW, screenH = guiGetScreenSize()

local font1 = dxCreateFont("f2.ttf", 27)
if screenW < 1920 then
	font1 = dxCreateFont("f2.ttf", 23)
end
local font2 = dxCreateFont("f.ttf", 13)
if screenW < 1920 then
	font2 = dxCreateFont("f.ttf", 10)
end
local font3 = dxCreateFont("f.ttf", 12)
if screenW < 1920 then
	font3 = dxCreateFont("f.ttf", 10)
end
local font4 = dxCreateFont("f.ttf", 10)
if screenW < 1920 then
	font4 = dxCreateFont("f.ttf", 8)
end
local font5 = dxCreateFont("f2.ttf", 20)
local font6 = dxCreateFont("f2.ttf", 15)
local font7 = dxCreateFont("f2.ttf", 16)
local font8 = dxCreateFont("f.ttf", 15)

local xx = 30
local xx2 = 20

local orange_1 = 75
local orange_2 = 100

function isMouseIn(psx,psy,pssx,pssy,abx,aby)
    if not isCursorShowing() then return end
    cx,cy=getCursorPosition()
    cx,cy=cx*screenW,cy*screenH
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true,cx,cy
    else
        return false
    end
end

function createCustomWindow(txt,x,y,w,h,f)
	if f == 69 then
		f = font5
	else
		f = font1
	end
	dxDrawImage(x,y,w,h,"window.png")
	if txt ~= true then
		dxDrawText(txt, x+1, y+(math.floor(screenH * 0.014))+1, w+x+1, h+y+1, tocolor(0, 0, 0, 255), 1, f, "center", "top", false, true)
		dxDrawText(txt, x, y+(math.floor(screenH * 0.014)), w+x, h+y, tocolor(255, 255, 255, 255), 1, f, "center", "top", false, true)
	end
end

function createCustomButton(txt,x,y,w,h)
	txt = string.gsub(txt, "ą", "a")
	txt = string.gsub(txt, "ę", "e")
	txt = string.gsub(txt, "ś", "s")
	txt = string.gsub(txt, "ć", "c")
	txt = string.gsub(txt, "ż", "z")
	if isMouseIn(x,y,w,h) then
		dxDrawImage(x,y,w,h,"button.png",0,0,0,tocolor(255,255,255,175))
	else
		dxDrawImage(x,y,w,h,"button.png",0,0,0,tocolor(255,255,255,255))
	end
	dxDrawText(txt, x+1, y+1, w+x+1, h+y+1, tocolor(0, 0, 0, 255), 1, font7, "center", "center", false, true)
	dxDrawText(txt, x, y, w+x, h+y, tocolor(255, 255, 255, 255), 1, font7, "center", "center", false, true)
end

function createCustomText(txt,x,y,w,h,color,size,font,xx,yy,gui,cliped)
	if not xx then xx = "center" end
	if not yy then yy = "center" end
	if size == 1 then font = font3 else font = font2 end
	if size == 0 then font = font4 end
	if size == 69 then font = font6 end
	if size == 70 then font = font5 end
	if size == 71 then font = font1 end
	if size == 99 then font = font8 end
	if not color then color = tocolor(255,255,255) end
	dxDrawText(txt, x+1, y+1, w+1, h+1, tocolor(0, 0, 0), 1, font, xx, yy, false, cliped, false, g1)
	dxDrawText(txt, x, y, w, h, color, 1, font, xx, yy, false, cliped, false, g1)
end

function createCustomText2(txt,x,y,w,h,color,size,font,xx,yy,gui,cliped)
	if not xx then xx = "center" end
	if not yy then yy = "center" end
	if size == 1 then font = font3 else font = font2 end
	if size == 0 then font = font4 end
	if not color then color = tocolor(255,255,255) end
	local g = "#%x%x%x%x%x%x"
	local g1 = false
	if string.find(txt, g, 1) then
		g = string.gsub(txt, g, "")
		g1 = true 
	else
		g = txt
	end
	dxDrawText(g, x+1, y+1, w+1, h+1, tocolor(0, 0, 0), 1, font, xx, yy, false, cliped, false, g1)
	dxDrawText(txt, x, y, w, h, color, 1, font, xx, yy, false, cliped, false, g1)
end

function createCustomProgressBar(txt, progress)
	dxDrawImage(screenW*0,screenH*0,screenW*1,screenH*1,"progress.png")
    dxDrawRectangle(screenW * 0.3448, screenH * 0.5102, screenW * 0.3104*(progress/100), screenH * 0.0398, tocolor(255, 255, 255, 255), false)
    createCustomText(txt, screenW * 0.3396, screenH * 0.4167, screenW * 0.6604, screenH * 0.495, tocolor(255, 255, 255, 255), 71, "default", "center", "bottom", false, false, false, false, false)
end

local tick = false
local time = false
local text = false

function p()
	if (getTickCount()-tick) > time then
		fadeCamera(true)
		removeEventHandler("onClientRender", root, p)
	else
		local progress = interpolateBetween(0, 0, 0, 100, 0, 0, (getTickCount()-tick)/time, "Linear")
		createCustomProgressBar(text, progress)
	end
end

function onCreateProgress(txt, tt)
	tick = getTickCount()
	time = tt
	text = txt
	fadeCamera(false)
	addEventHandler("onClientRender", root, p)
end