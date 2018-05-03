--[[
Autor: Asper
Dla: .newMode
Skrypt: Tuning vów
Typ: Server
]]

function getVehicleHandlingProperty ( element, property )
    if isElement ( element ) and getElementType ( element ) == "vehicle" and type ( property ) == "string" then
        local handlingTable = getVehicleHandling ( element )
        local value = handlingTable[property]

        if value then
            return value
        end
    end

    return false
end

local marker = createMarker(2483.53, 1754.61, 10.82-3, "cylinder", 5, 255, 0, 0, 100)
local blip = createBlip(2496.00, 1761.14, 10.82, 23,2,255,0,0,255,0,100) -- PILGRIM LV	

addEvent("mTuning", true)
addEventHandler("mTuning", root, function(v, i, c)
	if not v and not i and not c then return end
	local hand = getVehicleHandlingProperty(v, "driveType")
	local hajs = getElementData(source, "pieniadze")
	local bak = getElementData(v, "bak")
	bak = tonumber(bak)
	if i == "Zawieszenie hydrauliczne" then
		if getElementData(v, "zawieszenie") then
			local cx = c/2
			cx = string.format("%1.2f", cx)
			setElementData(source, "pieniadze", hajs+cx)
			exports["nm-noti"]:noti("Wymontowałeś zawieszenie hydrauliczne\notrzymujesz "..cx.." PLN", source)
			setElementData(v, "zawieszenie", false)
			exports.mysql:wykonaj("UPDATE pojazdy SET zawieszenie=0 WHERE id=?", getElementData(v, "id"))
		else
			if hajs > c then
				c = string.format("%1.2f", c)
				setElementData(source, "pieniadze", hajs-c)
				exports["nm-noti"]:noti("Zamontowałeś zawieszenie hydrauliczne\nza cene "..c.." PLN", source)
				setElementData(v, "zawieszenie", 2)
				exports.mysql:wykonaj("UPDATE pojazdy SET zawieszenie=1 WHERE id=?", getElementData(v, "id"))
			else
				exports["nm-noti"]:noti("Brak wystarczających funduszy.", source)
			end
		end
	elseif i == "Napęd FWD" then
		if hand == "fwd" then 
			exports["nm-noti"]:noti("Posiadasz już zainstalowany napęd FWD.", source)
			return 
		end
		if hajs > c then
			c = string.format("%1.2f", c)
			setElementData(source, "pieniadze", hajs-c)
			exports["nm-noti"]:noti("Zamontowałeś napęd FWD\nza cene "..c.." PLN", source)
			setVehicleHandling(v, "driveType", "fwd")
			exports.mysql:wykonaj("UPDATE pojazdy SET naped=? WHERE id=?", "fwd", getElementData(v, "id"))
		else
			exports["nm-noti"]:noti("Brak wystarczających funduszy.", source)
		end
	elseif i == "Napęd RWD" then
		if hand == "rwd" then 
			exports["nm-noti"]:noti("Posiadasz już zainstalowany napęd RWD.", source)
			return 
		end
		if hajs > c then
			c = string.format("%1.2f", c)
			setElementData(source, "pieniadze", hajs-c)
			exports["nm-noti"]:noti("Zamontowałeś napęd RWD\nza cene "..c.." PLN", source)
			setVehicleHandling(v, "driveType", "rwd")
			exports.mysql:wykonaj("UPDATE pojazdy SET naped=? WHERE id=?", "rwd", getElementData(v, "id"))
		else
			exports["nm-noti"]:noti("Brak wystarczających funduszy.", source)
		end
	elseif i == "Napęd AWD" then
		if hand == "awd" then 
			exports["nm-noti"]:noti("Posiadasz już zainstalowany napęd AWD.", source)
			return 
		end
		if hajs > c then
			c = string.format("%1.2f", c)
			setElementData(source, "pieniadze", hajs-c)
			exports["nm-noti"]:noti("Zamontowałeś napęd AWD\nza cene "..c.." PLN", source)
			setVehicleHandling(v, "driveType", "awd")
			exports.mysql:wykonaj("UPDATE vy SET naped=? WHERE id=?", "awd", getElementData(v, "id"))
		else
			exports["nm-noti"]:noti("Brak wystarczających funduszy.", source)
		end
	elseif i == "Bak 50L" then
		if bak == 50 then 
			exports["nm-noti"]:noti("Pojazd posiada już bak 50L.", source)
			return 
		end
		if bak == 100 or bak == 75 then 
			exports["nm-noti"]:noti("Nie możesz zmniejszyć baku vu.", source)
			return 
		end
		if hajs > c then
			c = string.format("%1.2f", c)
			setElementData(source, "pieniadze", hajs-c)
			exports["nm-noti"]:noti("Zamontowałeś bak 50L\nza cene "..c.." PLN", source)
			setElementData(v, "bak", 50)
			exports.mysql:wykonaj("UPDATE pojazdy SET bak=50 WHERE id=?", getElementData(v, "id"))
		else
			exports["nm-noti"]:noti("Brak wystarczających funduszy.", source)
		end
	elseif i == "Bak 75L" then
		if bak == 75 then 
			exports["nm-noti"]:noti("Pojazd posiada już bak 75L.", source)
			return 
		end
		if bak == 100 then 
			exports["nm-noti"]:noti("Nie możesz zmniejszyć baku vu.", source)
			return 
		end
		if hajs > c then
			c = string.format("%1.2f", c)
			setElementData(source, "pieniadze", hajs-c)
			exports["nm-noti"]:noti("Zamontowałeś bak 75L\nza cene "..c.." PLN", source)
			setElementData(v, "bak", 75)
			exports.mysql:wykonaj("UPDATE pojazdy SET bak=75 WHERE id=?", getElementData(v, "id"))
		else
			exports["nm-noti"]:noti("Brak wystarczających funduszy.", source)
		end
	elseif i == "Bak 100L" then
		if bak == 100 then 
			exports["nm-noti"]:noti("Pojazd posiada już bak 100L.", source)
			return 
		end
		if hajs > c then
			c = string.format("%1.2f", c)
			setElementData(source, "pieniadze", hajs-c)
			exports["nm-noti"]:noti("Zamontowałeś bak 100L\nza cene "..c.." PLN", source)
			setElementData(v, "bak", 100)
			exports.mysql:wykonaj("UPDATE pojazdy SET bak=100 WHERE id=?", getElementData(v, "id"))
		else
			exports["nm-noti"]:noti("Brak wystarczających funduszy.", source)
		end
-- MK1 ----------------------------------------------------------------------------------
-- MK1 ----------------------------------------------------------------------------------
	elseif i == "MK1" then
		if getElementData(v,"veh:mk1") == 1 then 
		    exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Ten pojazd posiada zamontowane MK1!", source)	
			return 
		end
		if hajs > c then
			c = string.format("%1.2f", c)
			setElementData(source, "pieniadze", hajs-c)
		    exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Zamontowałeś MK1 za "..c.." PLN!", source)	
			local handling = getVehicleHandling(v)
			setVehicleHandling(v, "engineAcceleration", handling.engineAcceleration+0.75)
			setElementData(v, "veh:mk1", 1)
			exports.mysql:wykonaj("UPDATE pojazdy SET mk1=? WHERE id=?", "1", getElementData(v, "id"))
		else
		    exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Nie posiadasz pieniędzy na zakup MK1!", source)
		end
-- MK2 ----------------------------------------------------------------------------------
-- MK2 ----------------------------------------------------------------------------------		
	elseif i == "MK2" then
		if getElementData(v,"veh:mk2") == 1 then 
		    exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Ten pojazd posiada zamontowane MK2!", source)	
			return 
		end
		if hajs > c then
			c = string.format("%1.2f", c)
			setElementData(source, "pieniadze", hajs-c)
		    exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Zamontowałeś MK2 za "..c.." PLN!", source)	
			local handling = getVehicleHandling(v)
			setVehicleHandling(v, "engineAcceleration", handling.engineAcceleration+1.25)
			setElementData(v, "veh:mk2", 1)
			exports.mysql:wykonaj("UPDATE pojazdy SET mk2=? WHERE id=?", "1", getElementData(v, "id"))
		else
		    exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Nie posiadasz pieniędzy na zakup MK2!", source)	
		end
-- MK3 ----------------------------------------------------------------------------------
-- MK3 ----------------------------------------------------------------------------------		
			elseif i == "MK3" then
		if getElementData(v,"veh:mk3") == 1 then 
		    exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Ten pojazd posiada zamontowane MK3!", source)			
			return 
		end
		if hajs > c then
			c = string.format("%1.2f", c)
			setElementData(source, "pieniadze", hajs-c)
		    exports["crpg_powiadomienia"]:noti("#00FF00✔#FFFFFF Zamontowałem MK3 za "..c.." PLN!", source)			
			local handling = getVehicleHandling(v)
			setVehicleHandling(v, "maxVelocity", handling.maxVelocity+15)
			setVehicleHandling(v, "engineAcceleration", handling.engineAcceleration+2)
			setElementData(v, "veh:mk3", 1)
			exports.mysql:wykonaj("UPDATE pojazdy SET mk3=? WHERE id=?", "1", getElementData(v, "id"))
		else
		    exports["crpg_powiadomienia"]:noti("#FF0000✖#FFFFFF Nie posiadasz pieniędzy na zakup MK3!", source)	
		end
		--[[	elseif i == "UP4 - Przyspieszenie,prędkość maksymalna" then
		if getElementData(v,"up4") then 
			exports["nm-noti"]:noti("Pojazd posiada już UP4.", source)
			return 
		end
		if hajs > c then
			c = string.format("%1.2f", c)
			setElementData(source, "pieniadze", hajs-c)
			exports["nm-noti"]:noti("Zamontowałeś UP4\nza cene "..c.." PLN", source)
			local handling = getVehicleHandling(v)
			setVehicleHandling(v, "maxVelocity", handling.maxVelocity+8)
			setVehicleHandling(v, "engineAcceleration", handling.engineAcceleration+1.2)
			setElementData(v, "up4", true)
			exports.mysql:wykonaj("UPDATE pojazdy SET duklad=1 WHERE id=?", getElementData(v, "id"))
		else
			exports["nm-noti"]:noti("Brak wystarczających funduszy.", source)
		end]]
	if i == "CB Radio" then
		if getElementData(v, "veh:cb") then
			local cx = c/2
			setElementData(source, "pieniadze", hajs+cx)
			exports["nm-noti"]:noti("Wymontowałeś CB-radio\notrzymujesz "..cx.." PLN", source)
			setElementData(v, "veh:cb", false)
			exports.mysql:wykonaj("UPDATE pojazdy SET cb=0 WHERE id=?", getElementData(v, "id"))
		else
			if hajs > c then
				setElementData(source, "pieniadze", hajs-c)
				exports["nm-noti"]:noti("Zamontowałeś CB-radio\nza cene "..c.." PLN", source)
				setElementData(v, "veh:cb", 1)
				exports.mysql:wykonaj("UPDATE pojazdy SET cb=1 WHERE id=?", getElementData(v, "id"))
			else
				exports["nm-noti"]:noti("Brak wystarczających funduszy.", source)
			end
		end
	end
	end
end)