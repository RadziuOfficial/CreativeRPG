--[[
	authors: nanKy, unknown
	resource: scoreboard
	gamemode: New Hope
	copyrights: Nie zezwalam na udostępnianie, korzystanie z zasobu.
]]

sX,sY = guiGetScreenSize()
sx,sy = guiGetScreenSize()
local font = dxCreateFont(":crpg_fonty/f.ttf",15)
if not font then font = "default-bold" end
local font2 = dxCreateFont(":crpg_fonty/f.ttf",13)
if not font2 then font2 = "default-bold" end

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

function _dxText(text,x,y,w,h,red,green,blue,alpha,scale,font,a,b,c,d,e,f)
	dxDrawText(string.gsub(text,"(#%x%x%x%x%x%x)",""),x+1,y+1,w+1,h+1,tocolor(0,0,0,alpha),scale,font,a,b,c,d,e,f)
	dxDrawText(text,x,y,w,h,tocolor(red,green,blue,alpha),scale,font,a,b,c,d,e,f)
end

scoreboard = {}
function playersShow()
    scoreboard = {}
    for i,p in ipairs(getElementsByType("player")) do
	    table.insert(scoreboard, p)
	end
end

rowNow = 0
rowsCount = math.floor(sY/22)-6
function drawScoreboard()
    playersShow()
	count = math.min(#scoreboard,rowsCount)
	local x = sX/2 - 320
	local y = sY/2 - count*20 / 2
	local cx, cy = 0,0
	if isCursorShowing() then
		cx, cy = getCursorPosition()
		cx = cx * sX
		cy = cy * sY
	end
	 dxDrawRectangle(x+1,y-22,638,22,tocolor(0, 94, 254, 255))
	_dxText("creativerpg.pl",x+3,y-50,sX,sY,255,255,255,255,1,font,"left","top",true,false,false,false)
	_dxText("Graczy: "..#getElementsByType("player").."",x,y-50,x+632,y-28,255,255,255,255,1,font,"right","center",true,false,false,false)
	_dxText("ID",x,y-22,x+35,y,255,255,255,255,1,font2,"center","center",true,false,false,false)
	_dxText("Nick",x+100,y-22,sX,y,255,255,255,255,1,font2,"left","center",true,false,false,false)
	_dxText("UID",x+220,y-22,x+330,y,255,255,255,255,1,font2,"center","center",true,false,false,false)
	_dxText("Organizacja",x+290,y-22,x+490,y,255,255,255,255,1,font2,"center","center",true,false,false,false)
	_dxText("Służba",x+400,y-22,x+600,y,255,255,255,255,1,font2,"center","center",true,false,false,false)
	_dxText("Punkty",x+574,y-22,x+640,y,255,255,255,255,1,font2,"center","center",true,false,false,false)
	for i=1,count do
	    posY = y+(i-1)*22
		    if scoreboard[i+rowNow] == localPlayer then
                     -- dxDrawRectangle(x,posY,640,20,tocolor(0, 0, 0, 100))
	            end


			if isCursorShowing() and cx > x and cx < x + 640 and cy > posY and cy < posY + 22 then
			    exports["nh-blur"]:dxDrawBluredRectangle(x,posY,640,20,tocolor(255, 255, 255, 255))
			end

			-- start check premium
			local premium = getElementData(scoreboard[i+rowNow], 'gracz:premium')
			if getElementData(localPlayer,"gracz:admin") == 1 then
			name = '#087316★'
			elseif getElementData(localPlayer,"gracz:admin") == 2 then
			name = '#049AC0★'
			elseif getElementData(localPlayer,"gracz:admin") == 3 then
			name = '#C00404★'
			elseif premium then
				name = '#FFFF00★'
			else
				name = ''
			end
			-- stop check premium

			local r,g,b = getPlayerNametagColor(scoreboard[i+rowNow])
			exports["nm-blur"]:dxDrawBluredRectangle(x+1,posY,638,22,tocolor(150, 150, 150, 255))
			
			_dxText(getElementData(scoreboard[i+rowNow],"id")or"--",x,posY,x+35,posY+22,255,255,255,255,1,font2,"center","center",true,false,false,false)
			_dxText(name,x+55,posY,sX,posY+22,r,g,b,255,1,font2,"left","center",false,false,false,true)
			_dxText(getPlayerName(scoreboard[i+rowNow]),x+100,posY,sX,posY+22,r,g,b,255,1,font2,"left","center",false,false,false,true)
			_dxText(getElementData(scoreboard[i+rowNow],"dbid") or "--", x+220,posY,x+330,posY+22,255,255,255,255,1,font2,"center","center",true,false,false,false)
			_dxText(getElementData(scoreboard[i+rowNow],"organizacja")or"--",x-500,posY,x+1280,posY+22,255,255,255,255,1,font2,"center","center",true,false,false,false)
			_dxText(getElementData(scoreboard[i+rowNow],"gracz:frakcja")or"--",x-280,posY,x+1280,posY+22,255,255,255,255,1,font2,"center","center",true,false,false,false)
			_dxText(getElementData(scoreboard[i+rowNow],"punkty")or'--',x+574,posY,x+640,posY+22,255,255,255,255,1,font2,"center","center",true,false,false,false)
	end
	if rowsCount < #scoreboard then
		size = rowsCount*22
		_size = size/#scoreboard
		__size = _size*rowsCount
		--exports["nh-blur"]:dxDrawBluredRectangle(x+650,y,10,size,tocolor(1,1,1, 255))
		--exports["nh-blur"]:dxDrawBluredRectangle(x+650,y+rowNow*_size,10,__size,tocolor(1,1,1, 255))
	end
end

bindKey("tab","down",
function()
	addEventHandler("onClientRender",root,drawScoreboard)
	tick = getTickCount()
	czas = getTickCount()
end
)

bindKey("tab","up",
function()
	removeEventHandler("onClientRender",root,drawScoreboard)
	if isCursorShowing() then
        showCursor(false)
    end
end
)

bindKey("mouse_wheel_up","down",
function()
    if rowNow == 0 then
	    return
	end
	rowNow = rowNow - 1
end
)

bindKey("mouse_wheel_down","down",
function()
    maxIndex = #scoreboard - rowsCount
	if #scoreboard < rowsCount then
	    return 
	end
	if rowNow == maxIndex then
	    return
	end
	rowNow = rowNow + 1
end
)