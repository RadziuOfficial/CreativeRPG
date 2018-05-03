addEventHandler("onClientResourceStart", resourceRoot,
function()


txd = engineLoadTXD ("koszary.txd", 4718) 
engineImportTXD(txd, 4718)
dff = engineLoadDFF ("koszary.dff", 4718)
engineReplaceModel(dff, 4718)
col = engineLoadCOL ("koszary.col")
engineReplaceCOL(col,4718)

setOcclusionsEnabled( false )

end
)