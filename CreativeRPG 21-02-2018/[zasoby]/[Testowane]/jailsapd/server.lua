local cub = createColCuboid(-2462.43, 3734.53, 300.57-1, 19, 15, 4)

function u(e)
getElementData(e, "dbid")
end

local cele = { -- x,y,z,int,dim
{-2446.29, 3744.45, 300.57,0,0},
{-2446.66, 3737.53, 300.57,0,0},
{-2458.34, 3738.42, 300.57,0,0},
{-2457.62, 3745.47, 300.57,0,0},
}
local x,y,z = -2446.84, 3777.43, 300.57
local function wypusc(plr)
setElementDimension(plr,0)
setElementInterior(plr,0)
setElementPosition(plr,x,y,z)
outputChatBox("Zostałeś wypuszczony z więzienia.",plr, 255, 255, 255)
end

function getPlayerName2(plr)
if not plr then return end
return getPlayerName(plr):gsub("#%x%x%x%x%x%x","")
end

local function sprawdz(plr)
if not plr then return end
if not getElementData(plr,"dbid") then return end
local x = exports.mysql:wykonaj("SELECT * FROM jail WHERE Serial=?",getPlayerSerial(plr))
if not x or #x < 1 then return end
local x2=exports.mysql:wykonaj("SELECT Termin FROM jail WHERE Serial=? and Termin < NOW()",getPlayerSerial(plr))
if x2 and #x2 > 0 then
exports.mysql:wykonaj("DELETE FROM jail WHERE Serial=?", getPlayerSerial(plr))
wypusc(plr)
return end
if isElementWithinColShape(plr,cub) then return end
setElementPosition(plr,cele[x[1].Cela][1],cele[x[1].Cela][2],cele[x[1].Cela][3])
setElementDimension(plr, 0)
end

local function sprawdzczas(plr)
if not plr then return end
if not getElementData(plr,"dbid") then return end
local x = exports.mysql:wykonaj("SELECT * FROM jail WHERE Serial=?",getPlayerSerial(plr))
if not x or #x < 1 then return end
local x2=exports.mysql:wykonaj("SELECT Termin FROM jail WHERE Serial=? and Termin < NOW()",getPlayerSerial(plr))
if x2 and #x2 > 0 then
exports.mysql:wykonaj("DELETE FROM jail WHERE Serial=?", getPlayerSerial(plr))
wypusc(plr)
return end
outputChatBox("Jesteś uwięziony w więzieniu do: #ff000"..x[1].Termin.." #ffffffza: #ff0000"..x[1].Powod.."", plr, 255, 255, 255, true)
end

function ajotceju(plr,cmd,target,ile,typ,zaco)
	if getElementData(plr, "frakcja")=="KGP" then
		if not target or not ile or not typ or not zaco then
		outputChatBox("Użycie: /jail <gracz/ID> <czas> <m/h> <powód>", plr, 255, 255, 255)
		return
	end
	local osoba = findPlayer(plr, target)
	if not osoba then
		outputChatBox("Nie znaleziono podanego gracza.", plr, 255, 255, 255)
		return
	end
    x1,x2,x3 = getElementPosition(plr)
    y1,y2,y3 = getElementPosition(osoba)
    dystans = getDistanceBetweenPoints3D(x1,x2,x3,y1,y2,y3)
    if dystans > 20.0 then outputChatBox("Ten gracz jest za daleko!", plr, 255, 255, 255) return end
	local cela=math.random(1, #cele)
	if typ=="m" or typ=="h" then
		if typ=="m"then
			exports.mysql:wykonaj("INSERT INTO jail (Serial,Termin,Cela,Powod) VALUES (?,NOW() + INTERVAL ?? minute,??,?)", getPlayerSerial(osoba), ile,cela, zaco)
			outputChatBox("Zostałeś uwięziony w więzieniu przez #ff0000"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." #ffffffza #ff0000"..zaco.." #ffffffna #ff0000"..ile.."#ffffff minut(-a/-y)", osoba, 255, 255, 255)
			outputChatBox("Uwięziono gracza "..getPlayerName(osoba):gsub("#%x%x%x%x%x%x","").." w więzieniu za "..zaco.." na "..ile.." minut(-a/-y)", plr, 255, 255, 255)
			sprawdz(plr)
		end
		if typ=="h" then
			exports.mysql:wykonaj("INSERT INTO jail (Serial,Termin,Cela,Powod) VALUES (?,NOW() + INTERVAL ?? hour,??,?)", getPlayerSerial(osoba), ile,cela, zaco)
			outputChatBox("Zostałeś uwięziony w więzieniu przez #ff0000"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." #ffffffza #ff0000"..zaco.." #ffffffna #ff0000"..ile.."#ffffff godzin(a/y)", osoba, 255, 255, 255)
			outputChatBox("Uwięziono gracza "..getPlayerName(osoba):gsub("#%x%x%x%x%x%x","").." w więzieniu za "..zaco.." na "..ile.." godzin(-a/-y)", plr, 255, 255, 255)
			sprawdz(plr)
		end
	end
	sprawdz(plr)
	cela=math.random(1, #cele)
	sprawdzczas(plr)
end
end
addCommandHandler("jail", ajotceju)

function unaj(plr,cmd,target)
if getElementData(plr, "frakcja")=="KGP" then
	local osoba = findPlayer(plr, target)
	if not osoba then
		outputChatBox("Nie znaleziono podanego gracza.", plr, 255, 255, 255)
		return
	end
	local jebnijsie=exports.mysql:wykonaj("SELECT Termin FROM jail WHERE Serial=? and Termin > NOW()",getPlayerSerial(osoba))
	if jebnijsie and #jebnijsie <= 0 then outputChatBox("Ten gracz nie jest w więzieniu! ("..getPlayerName(osoba)..")", plr,255,255,255) return end
	exports.mysql:wykonaj("DELETE FROM jail WHERE Serial=?", getPlayerSerial(osoba))
	outputChatBox("Gracz został uwolniony z więzienia.", plr, 255, 255, 255)
	sprawdz(osoba)
	wypusc(osoba)
end
end
addCommandHandler("unjail", unaj)

setTimer(function()
for _,p in pairs(getElementsByType("player")) do
sprawdz(p)
end
 end,5000,0)

function spawn()
local x=exports.mysql:wykonaj("SELECT Termin FROM jail WHERE Serial=? and Termin > NOW()",getPlayerSerial(source))
if x and #x <= 0 then return end
sprawdzczas(source)
end
addEventHandler("onPlayerSpawn", getRootElement(), spawn)

function findPlayer(plr, cel)
	local target = nil
	if (tonumber(cel) ~= nil) then
		target = getElementByID("p"..cel)
	else
		for _,thePlayer in ipairs(getElementsByType("player")) do
			if string.find(string.gsub(getPlayerName(thePlayer):lower(),"#%x%x%x%x%x%x", ""), cel:lower(), 1, true) then
				if (target) then
					outputChatBox("Znaleziono wiecej niz jednego gracza o pasujacym nicku, podaj wiecej liter.", plr)
					return nil
				end
				target=thePlayer
			end
		end
	end
	return target
end