local resourceRoot = getResourceRootElement(getThisResource())
     
addEventHandler("onClientResourceStart",resourceRoot,
function ()
    
    txd = engineLoadTXD ( "22.txd" )
    engineImportTXD ( txd, 321 )

    dff = engineLoadDFF ( "22.dff", 321 )
    engineReplaceModel ( dff, 321 )

end)