addEventHandler("onPlayerDamage ",root,
    function (attacker,weapon)
        if getElementData(attacker,"frakcja")== "PR" then
            if (weapon==41) then
                if (getElementHealth(source) < 100) then
                    givePlayerMoney(attacker,350 - getElementHealth(source))
                    setElementHealth(source,getElementHealth(source) + 20)
                end
            end
        end
    end
)
addEvent ( "MedicHeal", true )
addEventHandler ( "MedicHeal", root,
function (attacker)
    local playerHealth = getElementHealth ( source )
    if ( playerHealth > 99 ) then
		return end
    setElementHealth ( source, 100 )
    givePlayerMoney ( attacker, ( playerHealth/50 ) )
	setElementData(attacker, "medic:cooldown", 3)
end
)