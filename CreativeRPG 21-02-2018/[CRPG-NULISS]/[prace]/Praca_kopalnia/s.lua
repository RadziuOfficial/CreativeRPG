local weapon_id = 7
local category_animation = "BASEBALL"
local digging_animation = "bat_4"

function give_weapon()
giveWeapon(source, weapon_id, 1)
setPedWeaponSlot(source, 1)
end
addEvent("kilof", true) 
addEventHandler("kilof", getRootElement(), give_weapon)

function animation()
setPedAnimation(source, "BASEBALL", "Bat_4")
end
addEvent("animation", true) 
addEventHandler("animation", getRootElement(), animation)

function end_job()
setPedAnimation(source, false)
takeWeapon(source, weapon_id)
end
addEvent("end_job", true) 
addEventHandler("end_job", getRootElement(), end_job)

function koniec_animka()
setPedAnimation(source, false)
end
addEvent("end_animation", true) 
addEventHandler("end_animation", getRootElement(), koniec_animka)

addEvent("hajsikkopalnia",true)
addEventHandler("hajsikkopalnia",root,function(kwota)
givePlayerMoney(client, kwota)
end)

local napisy = createElement("text")
setElementData(napisy, "text", "Praca dorywcza\nKopalnia")
setElementPosition(napisy, -2087.05, -1530.54, 77.80-0.2)

local napisy = createElement("text")
setElementData(napisy, "text", "Zakończenie pracy\nKopalnia")
setElementPosition(napisy, -2100.82, -1522.49, 77.80-0.2)