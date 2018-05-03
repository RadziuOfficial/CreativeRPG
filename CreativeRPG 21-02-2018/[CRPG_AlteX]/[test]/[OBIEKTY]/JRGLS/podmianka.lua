local txd = engineLoadTXD ( "JRGLS.txd" )
engineImportTXD ( txd, 2266 )
local dff = engineLoadDFF ( "JRGLS.dff" )
engineReplaceModel ( dff, 2266 )
local col = engineLoadCOL( "JRGLS.col" )
engineReplaceCOL( col, 2266 )
engineSetModelLODDistance( 2266, 99999999999 )




local s = engineLoadCOL ( "brama01.col" )
engineReplaceCOL ( s, 5856 )
local s = engineLoadTXD ( "brama01.txd" )
engineImportTXD ( s, 5856 )
local s = engineLoadDFF ( "brama01.dff" )
engineReplaceModel ( s, 5856, true )


fileDelete("brama01.dff") 
fileDelete("brama01.txd") 
fileDelete("brama01.col") 