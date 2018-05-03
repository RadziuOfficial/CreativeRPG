addEventHandler("onClientResourceStart", resourceRoot,
function()

txd = engineLoadTXD ("modele/salon_stacja001.txd", 4559) 
engineImportTXD(txd, 4559)
dff = engineLoadDFF ("modele/LacmaBase1_LAn.dff", 4559)
engineReplaceModel(dff, 4559)
col = engineLoadCOL ("modele/LacmaBase1_LAn.col")
engineReplaceCOL(col,4559)

txd = engineLoadTXD ("modele/salon_stacja001.txd", 4590) 
engineImportTXD(txd, 4590)
dff = engineLoadDFF ("modele/grasspatchlan2.dff", 4590)
engineReplaceModel(dff, 4590)
col = engineLoadCOL ("modele/grasspatchlan2.col")
engineReplaceCOL(col,4590)

txd = engineLoadTXD ("modele/salon_stacja001.txd", 4558) 
engineImportTXD(txd, 4558)
dff = engineLoadDFF ("modele/LacmEntr1_LAn.dff", 4558)
engineReplaceModel(dff, 4558)
col = engineLoadCOL ("modele/LacmEntr1_LAn.col")
engineReplaceCOL(col,4558)

-- stacja kotnroli pojazdow LOD
txd = engineLoadTXD ("modele/salon_stacja001.txd", 4610) 
engineImportTXD(txd, 4610)
dff = engineLoadDFF ("modele/LacmEntr1_LAn.dff", 4610)
engineReplaceModel(dff, 4610)

-- plac LOD
txd = engineLoadTXD ("modele/salon_stacja001.txd", 4607) 
engineImportTXD(txd, 4607)
dff = engineLoadDFF ("modele/grasspatchlan2.dff", 4607)
engineReplaceModel(dff, 4607)


--salon samochodowy
txd = engineLoadTXD ("modele/salon_stacja001.txd", 4608) 
engineImportTXD(txd, 4608)
dff = engineLoadDFF ("modele/LacmaBase1_LAn.dff", 4608)
engineReplaceModel(dff, 4608)

setOcclusionsEnabled( false )
end
)
