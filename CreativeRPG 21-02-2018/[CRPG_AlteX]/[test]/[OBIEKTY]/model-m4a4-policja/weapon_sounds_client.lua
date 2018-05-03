--[[
    Autor Skryptu: CzarnaKobra/WonszRzeczny
    Prawa Autorskie: Prawo do używania tego skryptu posiada wyłącznie serwer New Life MTA oraz ja jego stworzyciel.
    Informacja: Jeżeli skrypt zostanie skopiowany w całości lub w częściach wiedz ze wtedy sprawa zostanie skierowana do sądu.
]]

function disableSounds()
setAmbientSoundEnabled( "gunfire", false ) -- Dzwiek uruchamia sie podczas strzalania
end
addEventHandler("onClientResourceStart",root,disableSounds)

local function playGunfireSound(weaponID)
    local muzzleX, muzzleY, muzzleZ = getPedWeaponMuzzlePosition(source)
    local px, py, pz = getElementPosition ( source )

       if weaponID == 31 then --deagle
        	local sound = playSound3D("Deagle.wav", muzzleX, muzzleY, muzzleZ, false) -- Plik z dzwiekiem
        	setSoundMaxDistance(sound, 100) -- Dystans dzwieku
                setSoundVolume(sound,1.0) -- Wartosc dzwieku
 end
end
addEventHandler("onClientPlayerWeaponFire", root, playGunfireSound)