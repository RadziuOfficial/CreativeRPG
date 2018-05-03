local txd = engineLoadTXD ( "yosemite.txd", 554 )
engineImportTXD ( txd,  554 )
local dff = engineLoadDFF("yosemite.dff", 554 )
engineReplaceModel( dff, 554 )

