addEventHandler( "onClientElementStreamIn",root,function()
    if getElementType( source ) == "object" then
	setObjectBreakable(source, false)
end
end)
addEvent("niedozniszczenia",true)
addEventHandler("niedozniszczenia",root,function(obj)
if obj then
setObjectBreakable(obj, false)
end
end)