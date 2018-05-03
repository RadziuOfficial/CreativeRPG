local txd = engineLoadTXD ( "quad.txd", 471 )
engineImportTXD ( txd, 471 )
local dff = engineLoadDFF( "quad.dff", 471 )
engineReplaceModel( dff, 471 )

