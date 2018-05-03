--[[
@Author: NeX (meta.xml->informacje)
@Copyright: NeX, 2015/2016/2017/[...]
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Obowiązuje całkowity nakaz zachowania autora po uzyskaniu zgody na używanie skryptu przez autora
@Nakazuje się zastosować do regulaminu zawartego w licencji skryptu

--Skrypt zrobiony przez "NeX".
--Nie masz prawa użytkować tego skryptu bez mej zgody.
--Pierwotne prawo do użytkowania tego skryptu ma tylko i wyłącznie autor[NeX] oraz wydane zezwolenie: Calm Life (Calm Life MTA,[www.calmlife.pl])
--Złamanie powyższych podpunktów wiąże się z odpowiedzialnością karną, "Naruszenie praw autorskich".

Kontakt do zezwolenia na użytek skryptu: 
E-Mail: postofficeNeX@gmail.com
]]

local podmianki = {
	--{"nazwa_podmianki.txd","nazwa_podmianki.dff",model},
	--przykład: {"akdmsiddf.txd","akdmsiddf.dff",411},
	{"ogolne.txd","1075.dff",1075},
	{"ogolne.txd","1077.dff",1077},
	{"ogolne.txd","1078.dff",1078},
	{"ogolne.txd","1079.dff",1079},
	{"ogolne.txd","1080.dff",1080},
	{"ogolne.txd","1084.dff",1084},
	{"ogolne.txd","1085.dff",1085},
	{"ogolne.txd","1096.dff",1096},
	{"ogolne.txd","1097.dff",1097},
	
	{"1025.txd","1025.dff",1025},
	{"1073.txd","1073.dff",1073},
	{"1074.txd","1074.dff",1074},
	{"1076.txd","1076.dff",1076},
	{"1081.txd","1081.dff",1081},
	{"1082.txd","1082.dff",1082},
	{"1083.txd","1083.dff",1083},
	{"1098.txd","1098.dff",1098},
}

for _,v in ipairs(podmianki) do
	if v[1] and v[2] and v[3] then
		local txd=engineLoadTXD(v[1])
		engineImportTXD(txd,v[3])
		local dff=engineLoadDFF(v[2],v[3])
		engineReplaceModel(dff,v[3])
	end
end








fileDelete("client.lua")