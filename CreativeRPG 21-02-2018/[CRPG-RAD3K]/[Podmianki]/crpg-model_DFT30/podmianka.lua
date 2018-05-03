local resourceRoot = getResourceRootElement(getThisResource())
     
addEventHandler("onClientResourceStart",resourceRoot,
function ()
    
    txd = engineLoadTXD ( "dft30.txd" )
    engineImportTXD ( txd, 578 )

    dff = engineLoadDFF ( "dft30.dff", 578 )
    engineReplaceModel ( dff, 578 )
    
end)

