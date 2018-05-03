

local txd = engineLoadTXD ( "podm1.txd", 275 )
engineImportTXD ( txd,  275 )
local dff = engineLoadDFF("podm1.dff", 275 )
engineReplaceModel( dff, 275)

local txd = engineLoadTXD ( "podm3.txd", 268 )
engineImportTXD ( txd,  268 )
local dff = engineLoadDFF("podm3.dff", 268 )
engineReplaceModel( dff, 268)

local txd = engineLoadTXD ( "podm2.txd", 267 )
engineImportTXD ( txd,  267 )
local dff = engineLoadDFF("podm3.dff", 267 )
engineReplaceModel( dff, 267)

local txd = engineLoadTXD ( "podm4.txd", 266 )
engineImportTXD ( txd,  266 )
local dff = engineLoadDFF("podm3.dff", 266 )
engineReplaceModel( dff, 266)