local resourceRoot = getResourceRootElement(getThisResource())
     
addEventHandler("onClientResourceStart",resourceRoot,
function ()
    
    txd = engineLoadTXD ( "ratownik.txd" )
    engineImportTXD ( txd, 274 )

    dff = engineLoadDFF ( "ratownik.dff", 272 )
    engineReplaceModel ( dff, 272 )

    txd = engineLoadTXD ( "lekarz.txd" )
    engineImportTXD ( txd, 272 )

    dff = engineLoadDFF ( "lekarz.dff", 272 )
    engineReplaceModel ( dff, 272 )

    txd = engineLoadTXD ( "medol.txd" )
    engineImportTXD ( txd, 275 )

    dff = engineLoadDFF ( "medol.dff", 275 )
    engineReplaceModel ( dff, 275 )

end)