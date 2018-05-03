addEvent("offAnimke", true)
addEventHandler("offAnimke", getRootElement(), function()
setPedAnimation(source, false)
end)

addEvent("dajAnimke", true)
addEventHandler("dajAnimke", getRootElement(), function()
setPedAnimation (source, "COP_AMBIENT", "Copbrowse_nod", -1, true, false )
end)

local ped = createPed(165, 1761.24, -1937.31, 13.78, 180)
setElementData(ped, "name", "Pracodawca Szymek")
setElementFrozen(ped, true)

local ped = createPed(165, 2059.48, -2143.09, 1024.47, 90)
setElementData(ped, "name", "Pracodawca Bartłomiej")
setElementFrozen(ped, true)

local napisy = createElement("text")
setElementData(napisy, "text", "Rozpoczęcie Pracy")
setElementPosition(napisy, 1761.38, -1939.06, 13.78)

local napisy = createElement("text")
setElementData(napisy, "text", "Rozpoczęcie Pracy")
setElementPosition(napisy, 2058.78, -2143.12, 1024.47)


local napisy = createElement("text")
setElementData(napisy, "text", "Aby podnieść paczke kliknij")
setElementPosition(napisy, 2061.67, -2147.19, 1024.47)

createBlip(1770.39, -1940.67, 13.57, 46)