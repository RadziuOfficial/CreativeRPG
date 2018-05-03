addEventHandler("onClientResourceStart", resourceRoot,
function()


txd = engineLoadTXD ("szafkamech.txd", 1855) 
engineImportTXD(txd, 1855)
dff = engineLoadDFF ("szafkamech.dff", 1855)
engineReplaceModel(dff, 1855)
col = engineLoadCOL ("szafkamech.col")
engineReplaceCOL(col,1855)

setOcclusionsEnabled( false )

end
)