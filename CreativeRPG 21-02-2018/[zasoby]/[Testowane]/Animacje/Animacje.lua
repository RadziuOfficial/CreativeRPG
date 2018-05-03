dopicia = {}
player_alc = {}
pije = {}
function stopAnimacja(plr)
    setPedAnimation(plr, false)
    unbindKey(plr, "ENTER", "down", stopAnimacja)
end
function pij(plr)
	if pije[plr] then return end
	pije[plr] = true
    setPedAnimation ( plr, "BAR", "dnk_stndM_loop", 1200, false, false )
	setTimer(function () setPedAnimation(plr,false);pije[plr] = nil; triggerClientEvent(plr,"onDrinkAlcohol",root) end,1200,1)
	setPedWalkingStyle(plr,126)
	dopicia[plr] = dopicia[plr] -1
	if dopicia[plr] == 0 then
	destroyElement(player_alc[plr])
	player_alc[plr] = nil
    unbindKey(plr, "fire", "down", pij)
	end
end


addCommandHandler("sex1",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "sex", "sex_1_cum_p", -1, true, false )
end)

addCommandHandler("sex2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "sex", "sex_1_cum_w", -1, true, false )
end)


addCommandHandler("dzwonisz",function(plr,cmd)
--[[
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
]]--
    setPedAnimation( plr, "ped", "phone_in", -1, false, false, false, true)
--  setPedAnimation ( plr, "ped", "handsup", -1, false, false )
end)


-- animacje zaimportowane z BestPlay i wykonane przez wujka <wube@bestplay.pl>

addCommandHandler("rece",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "ped", "handsup", -1, false, false )
end)

addCommandHandler("taichi",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "PARK", "Tai_Chi_Loop", -1, true, false )
end)

addCommandHandler("predator",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "BSKTBALL", "BBALL_def_loop", -1, true, false )
end)

addCommandHandler("podkrecasz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "BAR", "Barserve_glass", -1, false, false )
end)

addCommandHandler("podsluchujesz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "BAR", "Barserve_order", -1, false, false )
end)

addCommandHandler("podaj",function(plr,cmd,targ)
	if getAdmin(plr,3) then
		if not targ then
			outputChatBox("Uzyj: /podaj <id/nick>", plr)
			return
		end
		local target=exports["ogrpg-core"]:findPlayer(plr,targ)
		if not target then
			outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end
	if player_alc[target] then outputChatBox("Gracz ma juz alkochol!", plr) return end
    if (isPedInVehicle(target)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
	local alc = createObject(1484,0,0,0)
	player_alc[target] = alc
	dopicia[target] = 3
	exports.bone_attach:attachElementToBone(alc,target,12,0,0,0,0,0,0)
    bindKey(target, "fire", "down", pij)
	end
end)
addCommandHandler("pijesz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "BAR", "dnk_stndM_loop", -1, true, false )
end)


addCommandHandler("taniec",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "CHAINSAW", "CSAW_Hit_2", -1, true, true )
end)

addCommandHandler("taniec2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "SKATE", "skate_idle", -1, true, false )
end)

addCommandHandler("taniec3",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "STRIP", "strip_B", -1, true, false )
end)

addCommandHandler("taniec4",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "DANCING", "dance_loop", -1, true, false )
end)

addCommandHandler("taniec5",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "DANCING", "DAN_Down_A", -1, true, false )
end)

addCommandHandler("taniec6",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "STRIP", "strip_G", -1, true, false )
end)

addCommandHandler("taniec7",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "STRIP", "STR_C2", -1, true, false )
end)

addCommandHandler("taniec8",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "DANCING", "dnce_M_b", -1, true, false )
end)

addCommandHandler("taniec9",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "DANCING", "DAN_Loop_A", -1, true, false )
end)

addCommandHandler("taniec10",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "DANCING", "dnce_M_d", -1, true, false )
end)

addCommandHandler("taniec11",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "STRIP", "strip_D", -1, true, false )
end)

addCommandHandler("taniec12",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "STRIP", "strip_E", -1, true, false )
end)

addCommandHandler("taniec13",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "STRIP", "STR_Loop_A", -1, true, false )
end)

addCommandHandler("taniec14",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "STRIP", "STR_Loop_B", -1, true, false )
end)

addCommandHandler("taniec15",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "FINALE", "FIN_Cop1_Stomp", -1, true, false )
end)

addCommandHandler("taniec16",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "DANCING", "dnce_M_a", -1, true, false )
end)

addCommandHandler("taniec17",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GFUNK", "Dance_G10", -1, true, false )
end)

addCommandHandler("taniec18",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GFUNK", "Dance_G11", -1, true, false )
end)

addCommandHandler("taniec19",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GFUNK", "Dance_G12", -1, true, false )
end)

addCommandHandler("taniec20",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "RUNNINGMAN", "Dance_B1", -1, true, false )
end)

addCommandHandler("palisz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "LOWRIDER", "M_smklean_loop", -1, true, false )
end)

addCommandHandler("lezysz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "BEACH", "Lay_Bac_Loop", -1, true, false )
end)

addCommandHandler("lezysz2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "CRACK", "crckidle2", -1, true, false )
end)

addCommandHandler("lezysz3",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "CRACK", "crckidle4", -1, true, false )
end)

addCommandHandler("lezysz4",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "BEACH", "ParkSit_W_loop", -1, false, false )
end)

addCommandHandler("lezysz5",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "BEACH", "SitnWait_loop_W", -1, true, false )
end)

addCommandHandler("siedzisz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "BEACH", "ParkSit_M_loop", -1, true, false )
end)

addCommandHandler("siedzisz2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "INT_OFFICE", "OFF_Sit_Idle_Loop", -1, true, false )
end)

addCommandHandler("siedzisz3",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "JST_BUISNESS", "girl_02", -1, false, false )
end)

addCommandHandler("klekasz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "CAMERA", "camstnd_to_camcrch", -1, false, false )
end)

addCommandHandler("klekasz2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "COP_AMBIENT", "Copbrowse_nod", -1, true, false )
end)

addCommandHandler("czekasz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "COP_AMBIENT", "Coplook_loop", -1, true, false )
end)

addCommandHandler("akrobata",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "DAM_JUMP", "DAM_Dive_Loop", -1, false, false )
end)

addCommandHandler("msza",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "DEALER", "DEALER_IDLE", -1, true, false )
end)

addCommandHandler("msza2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GRAVEYARD", "mrnM_loop", -1, false, false )
end)

addCommandHandler("znakkrzyza",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GANGS", "hndshkcb", -1, true, false )
end)

addCommandHandler("rzygasz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "FOOD", "EAT_Vomit_P", -1, true, false )
end)

addCommandHandler("jesz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "FOOD", "EAT_Burger", -1, true, false )
end)

addCommandHandler("cpun1",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GANGS", "drnkbr_prtl", -1, true, false )
end)

addCommandHandler("cpun2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GANGS", "smkcig_prtl", -1, true, false )
end)

addCommandHandler("cpun3",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "CRACK", "Bbalbat_Idle_01", -1, true, false )
end)

addCommandHandler("cpun4",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "CRACK", "Bbalbat_Idle_02", -1, true, false )
end)

addCommandHandler("witasz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GANGS", "hndshkba", -1, true, false )
end)

addCommandHandler("rozmawiasz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GANGS", "prtial_gngtlkH", -1, true, false )
end)

addCommandHandler("rozmawiasz2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GANGS", "prtial_gngtlkG", -1, true, false )
end)

addCommandHandler("rozmawiasz3",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GANGS", "prtial_gngtlkD", -1, true, false )
end)

addCommandHandler("nerwowy",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GHANDS", "gsign2", -1, true, false )
end)

addCommandHandler("piszesz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "INT_OFFICE", "OFF_Sit_Type_Loop", -1, true, false )
end)

addCommandHandler("gay",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "ped", "WOMAN_walksexy", -1, true, true )
end)


addCommandHandler("gay2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "ped", "WOMAN_walkpro", -1, true, true )
end)

addCommandHandler("gay3",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "ped", "WOMAN_runsexy", -1, true, true )
end)

addCommandHandler("wreczasz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "KISSING", "gift_give", -1, false, false )
end)

addCommandHandler("machasz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "KISSING", "gfwave2", -1, true, false )
end)

addCommandHandler("walisz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "PAULNMAC", "wank_loop", -1, true, false )
end)

addCommandHandler("walisz2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "MISC", "Scratchballs_01", -1, true, false )
end)

addCommandHandler("sikasz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "PAULNMAC", "Piss_loop", -1, true, false )
end)

addCommandHandler("pijany",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "ped", "WALK_drunk", -1, true, true )
end)

addCommandHandler("pijany2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "PAULNMAC", "PnM_Loop_A", -1, true, false )
end)

addCommandHandler("pijany3",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "PAULNMAC", "PnM_Argue2_A", -1, true, false )
end)

addCommandHandler("rapujesz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "SCRATCHING", "scmid_l", -1, true, false )
end)

addCommandHandler("rapujesz2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "SCRATCHING", "scdldlp", -1, true, false )
end)

addCommandHandler("rapujesz3",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "Flowers", "Flower_Hit", -1, true, false )
end)

addCommandHandler("rapujesz4",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "RAPPING", "RAP_C_Loop", -1, true, false )
end)

addCommandHandler("rapujesz5",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "RAPPING", "RAP_B_Loop", -1, true, false )
end)

addCommandHandler("rapujesz6",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "SCRATCHING", "scdrdlp", -1, true, false )
end)

addCommandHandler("rapujesz7",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "SCRATCHING", "scdrulp", -1, true, false )
end)

addCommandHandler("rapujesz8",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "RAPPING", "RAP_A_Loop", -1, true, false )
end)

addCommandHandler("umierasz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "ped", "FLOOR_hit_f", -1, false, false )
end)

addCommandHandler("umierasz2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "ped", "FLOOR_hit", -1, false, false )
end)

addCommandHandler("bijesz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "BASEBALL", "Bat_M", -1, true, false )
end)

addCommandHandler("bijesz2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "RIOT", "RIOT_PUNCHES", -1, true, false )
end)

addCommandHandler("bijesz3",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "FIGHT_B", "FightB_M", -1, true, false )
end)

addCommandHandler("bijesz4",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "MISC", "bitchslap", -1, true, false )
end)

addCommandHandler("bijesz5",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "ped", "BIKE_elbowR", -1, true, false )
end)

addCommandHandler("wolasz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "RYDER", "RYD_Beckon_01", -1, true, false )
end)

addCommandHandler("wolasz2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "POLICE", "CopTraf_Come", -1, true, false )
end)

addCommandHandler("wolasz3",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "RYDER", "RYD_Beckon_02", -1, true, false )
end)

addCommandHandler("zatrzymujesz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "POLICE", "CopTraf_Stop", -1, true, false )
end)

addCommandHandler("wskazujesz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "SHOP", "ROB_Loop", -1, true, false )
end)

addCommandHandler("rozgladasz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "ON_LOOKERS", "lkaround_loop", -1, true, false )
end)

addCommandHandler("krzyczysz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "ON_LOOKERS", "shout_in", -1, true, false )
end)

addCommandHandler("fuckyou",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "RIOT", "RIOT_FUKU", -1, true, false )
end)

addCommandHandler("tchorz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "ped", "cower", -1, false, false )
end)

addCommandHandler("kopiesz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GANGS", "shake_carK", -1, true, false )
end)

addCommandHandler("kopiesz2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "FIGHT_D", "FightD_G", -1, true, false )
end)

addCommandHandler("kopiesz3",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "FIGHT_C", "FightC_3", -1, false )
end)

addCommandHandler("wywazasz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GANGS", "shake_carSH", -1, true, false )
end)

addCommandHandler("wywazasz2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "POLICE", "Door_Kick", -1, true, false )
end)

addCommandHandler("kieszen",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GANGS", "leanIDLE", -1, true, false )
end)

addCommandHandler("celujesz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "ped", "ARRESTgun", -1, false, false )
end)

addCommandHandler("kichasz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "VENDING", "vend_eat1_P", -1, true, false )
end)

addCommandHandler("pocalunek",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "BD_FIRE", "Grlfrd_Kiss_03", -1, true, false )
end)

addCommandHandler("taxi",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "MISC", "Hiker_Pose", -1, false, false )
end)

addCommandHandler("taxi2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "MISC", "Hiker_Pose_L", -1, false, false )
end)

addCommandHandler("noga",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "SHOP", "SHP_Jump_Glide", -1, false, false )
end)

addCommandHandler("pozegnanie",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "BD_FIRE", "BD_Panic_03", -1, true, false )
end)

addCommandHandler("cud",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "CARRY", "crry_prtial", -1, true, false )
end)

addCommandHandler("cud2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "ON_LOOKERS", "Pointup_loop", -1, false, false )
end)

addCommandHandler("delirium",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "CRACK", "crckdeth1", -1, false )
end)

addCommandHandler("delirium2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "CRACK", "crckdeth2", -1, true, false )
end)

addCommandHandler("delirium3",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "CRACK", "crckidle3", -1, true, false )
end)

addCommandHandler("delirium4",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "CHAINSAW", "csaw_part", -1, true, false )
end)

addCommandHandler("delirium5",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "CASINO", "Roulette_loop", -1, true, false )
end)

addCommandHandler("naprawiasz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "CAR", "flag_drop", -1, true, false )
end)

addCommandHandler("naprawiasz2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "CAR", "Fixn_Car_Loop", -1, true, false )
end)

addCommandHandler("placzesz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GRAVEYARD", "mrnF_loop", -1, true, false )
end)

addCommandHandler("kibicujesz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "RIOT", "RIOT_ANGRY_B", -1, true, false )
end)

addCommandHandler("kibicujesz2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "ON_LOOKERS", "wave_loop", -1, true, false )
end)

addCommandHandler("bioenergoterapeuta",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "WUZI", "Wuzi_Greet_Wuzi", -1, true, false )
end)

addCommandHandler("meteorolog",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "WUZI", "Wuzi_grnd_chk", -1, true, false )
end)

addCommandHandler("klepiesz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "SWEET", "sweet_ass_slap", -1, true, false )
end)

addCommandHandler("cierpisz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "SWEET", "Sweet_injuredloop", -1, true, false )
end)

addCommandHandler("cierpisz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "SWEET", "Sweet_injuredloop", -1, true, false )
end)

addCommandHandler("starzec",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "ped", "WALK_shuffle", -1, true, true )
end)

addCommandHandler("starzec2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "ped", "WOMAN_walkfatold", -1, true, true )
end)

addCommandHandler("starzec3",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "ped", "WOMAN_walkshop", -1, true, true )
end)

addCommandHandler("reanimujesz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "MEDIC", "CPR", -1, false, false )
end)

addCommandHandler("myjesz",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "CASINO", "dealone", -1, true, false )
end)

addCommandHandler("zadowolony",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "CASINO", "manwind", -1, true, false )
end)

addCommandHandler("zadowolony2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "CASINO", "manwinb", -1, true, false )
end)

addCommandHandler("zalamany",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "CASINO", "Roulette_lose", -1, true, false )
end)

addCommandHandler("zmeczony",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "FAT", "IDLE_tired", -1, true, false )
end)

addCommandHandler("ochnie",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "MISC", "plyr_shkhead", -1, true, false )
end)

addCommandHandler("cwaniak1",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GHANDS", "gsign1", -1, true, false )
end)

addCommandHandler("cwaniak2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GHANDS", "gsign1LH", -1, true, false )
end)

addCommandHandler("cwaniak3",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GHANDS", "gsign2", -1, true, false )
end)

addCommandHandler("cwaniak4",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GHANDS", "gsign2LH", -1, true, false )
end)

addCommandHandler("cwaniak5",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GHANDS", "gsign3", -1, true, false )
end)

addCommandHandler("cwaniak6",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GHANDS", "gsign3LH", -1, true, false )
end)

addCommandHandler("cwaniak7",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GHANDS", "gsign4", -1, true, false )
end)

addCommandHandler("cwaniak8",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GHANDS", "gsign4LH", -1, true, false )
end)


addCommandHandler("cwaniak9",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GHANDS", "gsign5", -1, true, false )
end)

addCommandHandler("cwaniak10",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GHANDS", "gsign5LH", -1, true, false )
end)

addCommandHandler("pijak",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("Najpierw wysiadz z pojazdu", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "CRACK", "crckidle4", -1, true, false )
end)