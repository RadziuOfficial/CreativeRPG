local s = engineLoadTXD ( "pktmed.txd" )
engineImportTXD ( s, 3906)
local s = engineLoadDFF ( "pktmed.dff" )
engineReplaceModel ( s, 3906, true )
local s = engineLoadCOL ( "pktmed.col" )
engineReplaceCOL ( s, 3906)
setOcclusionsEnabled( false )

