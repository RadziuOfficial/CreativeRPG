local marker1=createMarker(1079.03,-1826.98,-3.45,"arrow",1,255,255,0) -- wyjście boa
local marker2=createMarker(1091.40,-1784.31,-3.45,"arrow",1,255,255,0) -- wyjście tp na komistariat 
local marker3=createMarker(1111.93,-1798.38,16.60,"arrow",1,0,255,255) -- wejście boa 
local marker4=createMarker(-1633.82,708.84,1337.95,"arrow",1,255,255,0) -- wejście z komisariatu 
local marker5=createMarker(-1652.29,721.88,1337.95,"arrow",1,0,255,255,60) -- wejście na parking 
local marker6=createMarker(1568.61,-1689.97,6.22+0.90,"arrow",1,255,255,0) -- wejście na kgp
t=createElement("text")
setElementData(t,"name","Wejście\nSzpital")
setElementPosition(t,1172.08, -1325.40, 15.41)
addEventHandler("onMarkerHit",resourceRoot,function(el,md)
	if source==marker1 then
		return setElementPosition(el,1108.56,-1798.39,16.60)
		elseif source==marker5 then
		return setElementPosition(el,1568.67,-1691.21,5.89)
	elseif source==marker6 then
		return setElementPosition(el,-1650.43,721.87,1337.95)
	elseif source==marker2 then
		return setElementPosition(el,-1634.21,711.58,1337.95)
	end
	
	if getElementData(el,"player:duty") ~="Policja" then  return end
	if source==marker3 then
		return setElementPosition(el,1080.79, -1826.69, -3.45)
	end
	if getElementData(el,"player:duty") ~="Policja" then  return end
	if source==marker4 then
		return setElementPosition(el,1090.11,-1786.60,-3.45)
	end
end)