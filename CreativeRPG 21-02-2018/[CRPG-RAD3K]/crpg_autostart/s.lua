startResource(getResourceFromName("mysql"))
q=exports["mysql"]:wykonaj("select * from Autostart")
for i,v in ipairs(q) do
	startResource(getResourceFromName(v.skrypt))
end

function admin(plr)
	local accName = getAccountName ( getPlayerAccount ( plr ) )
	if not accName then return true end
	if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) then
		return false
	else
		return true
	end
end

function autostart(plr)
	if admin(plr) then return end
	outputChatBox("Trwa przeładowywanie autostartu...",plr,0,255,0)
	exports["mysql"]:wykonaj("truncate Autostart")
	for i,v in ipairs(getResources()) do
		if getResourceState(v)=="running" then
			exports["mysql"]:wykonaj("insert into Autostart values(?)",getResourceName(v))
		end
	end
	outputChatBox("Autostart przeładowany pomyślnie!",plr,0,255,0)
end
addCommandHandler("autostartreload",autostart)