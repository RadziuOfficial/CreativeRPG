addEventHandler("onClientResourceStart", resourceRoot,
function()


txd = engineLoadTXD ("podnosniksamocho.txd", 1856) 
engineImportTXD(txd, 1856)
dff = engineLoadDFF ("podnosniksamocho.dff", 1856)
engineReplaceModel(dff, 1856)

setOcclusionsEnabled( false )

end
)