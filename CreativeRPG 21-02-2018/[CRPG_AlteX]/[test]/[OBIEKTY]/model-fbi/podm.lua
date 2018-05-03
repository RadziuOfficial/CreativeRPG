local txd = engineLoadTXD ( "podm.txd", 490 )
engineImportTXD ( txd,  490 )
local dff = engineLoadDFF("podm.dff", 490 )
engineReplaceModel( dff, 490 )

