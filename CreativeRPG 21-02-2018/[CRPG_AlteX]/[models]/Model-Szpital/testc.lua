addEventHandler("onClientResourceStart", resourceRoot,
function()


-- 
txd = engineLoadTXD ("modele/szpital001.txd", 5708) 
engineImportTXD(txd, 5708)
dff = engineLoadDFF ("modele/hospital_law.dff", 5708)
engineReplaceModel(dff, 5708)
col = engineLoadCOL ("modele/hospital_law.col")
engineReplaceCOL(col,5708)

txd = engineLoadTXD ("modele/szpital001.txd", 5810) 
engineImportTXD(txd, 5810)
dff = engineLoadDFF ("modele/lawnmalstrip.dff", 5810)
engineReplaceModel(dff, 5810)
col = engineLoadCOL ("modele/lawnmalstrip.col")
engineReplaceCOL(col,5810)

txd = engineLoadTXD ("modele/szpital001.txd", 5993) 
engineImportTXD(txd, 5993)
dff = engineLoadDFF ("modele/lawnmalstripTR.dff", 5993)
engineReplaceModel(dff, 5993)
col = engineLoadCOL ("modele/lawnmalstripTR.col")
engineReplaceCOL(col,5993)

txd = engineLoadTXD ("modele/szpital001.txd", 5731) 
engineImportTXD(txd, 5731)
dff = engineLoadDFF ("modele/MelBlok05_LAwN.dff", 5731)
engineReplaceModel(dff, 5731)
col = engineLoadCOL ("modele/MelBlok05_LAwN.col")
engineReplaceCOL(col,5731)

-- LOD
txd = engineLoadTXD ("modele/LODszpital001.txd", 5930) 
engineImportTXD(txd, 5930)
dff = engineLoadDFF ("modele/LODhospital_law.dff", 5930)
engineReplaceModel(dff, 5930)
col = engineLoadCOL ("modele/LODhospital_law.col")
engineReplaceCOL(col,5930)

--

txd = engineLoadTXD ("modele/LODszpital001.txd", 5931) 
engineImportTXD(txd, 5931)
dff = engineLoadDFF ("modele/LODlawnmalstrip.dff", 5931)
engineReplaceModel(dff, 5931)
col = engineLoadCOL ("modele/LODlawnmalstrip.col")
engineReplaceCOL(col,5931)

--

txd = engineLoadTXD ("modele/LODszpital001.txd", 5934) 
engineImportTXD(txd, 5934)
dff = engineLoadDFF ("modele/LODMelBlok05_LAwN.dff", 5934)
engineReplaceModel(dff, 5934)
col = engineLoadCOL ("modele/LODMelBlok05_LAwN.col")
engineReplaceCOL(col,5934)

col = engineLoadCOL ("modele/road_lawn39.col")
engineReplaceCOL(col,5808)

--usuwanie zwykłych obiektów
--removeWorldModel(11416, 10, -2038.93, 178.805, 29.9375) -- usuwa praw drzwi

setOcclusionsEnabled( false )

end
)
