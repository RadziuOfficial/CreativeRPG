	addEvent("strefa", true)
	addEventHandler("strefa", root, function (val)
	if val == "1" then
	resetRainLevel()
	elseif val == "0" then
	setRainLevel(0)
	end
	end)