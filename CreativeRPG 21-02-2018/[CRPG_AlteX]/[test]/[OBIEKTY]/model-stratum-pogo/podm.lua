local txd = engineLoadTXD ( "podm.txd", 596 )
engineImportTXD ( txd,  596 )
local dff = engineLoadDFF("podm.dff", 596 )
engineReplaceModel( dff, 596 )

