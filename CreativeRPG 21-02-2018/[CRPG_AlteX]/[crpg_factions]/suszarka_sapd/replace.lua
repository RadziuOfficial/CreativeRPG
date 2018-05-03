local resourceRoot = getResourceRootElement(getThisResource())
     
addEventHandler("onClientResourceStart",resourceRoot,
function ()
    
    txd = engineLoadTXD ( "22.txd" )
    engineImportTXD ( txd, 348 )

    dff = engineLoadDFF ( "22.dff", 348 )
    engineReplaceModel ( dff, 348 )

end)