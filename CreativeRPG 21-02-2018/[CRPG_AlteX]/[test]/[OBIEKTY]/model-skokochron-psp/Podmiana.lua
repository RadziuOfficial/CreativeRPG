local s = engineLoadTXD ( "skokochron.txd" )
engineImportTXD ( s, 2034)
local s = engineLoadDFF ( "skokochron.dff" )
engineReplaceModel ( s, 2034, true )
local s = engineLoadCOL ( "skokochron.col" )
engineReplaceCOL ( s, 2034)
setOcclusionsEnabled( false )

