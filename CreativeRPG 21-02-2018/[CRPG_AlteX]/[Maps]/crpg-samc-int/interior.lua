wejscie = createMarker (-2655.11, 639.96, 14.45+0.8, "arrow", 1.25, 255, 255, 0)
wyjscie = createMarker (-2672.45, 649.90, 48.90+0.5, "arrow", 1.25, 255, 255, 0)
setElementDimension(wyjscie, 0)
setElementInterior(wyjscie, 0)

addEventHandler("onMarkerHit", wejscie, function(el, md)
    if isPedInVehicle(el) then return end
    setElementDimension(el, 0)
    setElementInterior(el, 0)
    setElementPosition(el, -2672.25, 646.69, 48.90)
end)

addEventHandler("onMarkerHit", wyjscie, function(el, md)
    if isPedInVehicle(el) then return end
    setElementDimension(el, 0)
    setElementInterior(el, 0)
    setElementPosition(el, -2655.21, 637.56, 14.45)
end)