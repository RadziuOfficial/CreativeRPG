local wejscie=createMarker(-1993.61316 242.56151 35.17188, "arrow", 1, 255, 255, 0)
local wyjscie=createMarker(-1936.74902 294.34171 47.70313, "arrow", 1, 255, 255, 0)
setElementDimension(wyjscie, 1)

local t=createElement("text")
setElementInterior(t, 0)
setElementPosition(t,-1993.61316 242.56151 35.17188)
setElementData(t,"publiczny","Ośrodek Szkoleniowy Kierowców\nWejście")

local t=createElement("text")
setElementDimension(t, 0)
setElementPosition(t,-1936.74902 294.34171 47.70313)
setElementData(t,"publiczny","Wyjście\nz budynku")

addEventHandler("onMarkerHit", wejscie, function(el,md)
 if getElementType(el) == "player" then
  if isPedInVehicle(el) then return end
  setElementDimension(el, 0)
  setElementPosition(el, -1940.07288 294.21262 47.70313)
  --   triggerClientEvent(el, "dodaj:powiadomienie", root, "* Pomyślnie przeniesiono cię do urzędu miasta.")
 end
end)

addEventHandler("onMarkerHit", wyjscie, function(el,md)
 if getElementType(el) == "player" then
  if isPedInVehicle(el) then return end
  setElementDimension(el, 0)
  setElementPosition(el,-1993.55237 244.93143 35.17188)
  --   triggerClientEvent(el, "dodaj:powiadomienie", root, "* Pomyślnie przeniesiono cię z urzędu miasta.")
 end
end)

