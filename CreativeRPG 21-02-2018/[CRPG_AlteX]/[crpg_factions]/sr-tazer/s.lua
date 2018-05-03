function taser(atakujacy, bron, cialo, starciles)
if atakujacy and (bron == 23) then
outputChatBox("Zostałeś trafiony paralizatorem nie możesz się ruszać przeż 20sek", source)
setElementFrozen(source,true)
setPedAnimation(source, "CRACK", "crckdeth2", -1, true, false)
setTimer(setElementFrozen,20000,1,source,false)		
setTimer(setPedAnimation,20000,1,source,false)		
elseif atakujacy and (bron == 3) then
outputChatBox("Zostałeś trafiony pałką policyjną nie możesz się ruszać przeż 20sek", source)
setElementFrozen(source,true)
setPedAnimation(source, "CRACK", "crckdeth2", -1, true, false)
setTimer(setElementFrozen,20000,1,source,false)		
setTimer(setPedAnimation,20000,1,source,false)		
end
setElementHealth(source, getElementHealth(source)+starciles)
end
addEventHandler ( "onPlayerDamage", getRootElement (), taser)
