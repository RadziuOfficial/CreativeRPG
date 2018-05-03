function szpital()

-- podmienia zwykly obiekt
txd = engineLoadTXD ("model/szpital_tekstury.txd", 6157) 
engineImportTXD(txd, 6157)
dff = engineLoadDFF ("model/gaz22_law.dff", 6157)
engineReplaceModel(dff, 6157)
col = engineLoadCOL ("model/gaz22_law.col")
engineReplaceCOL(col,6157)

txd = engineLoadTXD ("model/szpital_tekstury.txd", 6160) 
engineImportTXD(txd, 6160)
dff = engineLoadDFF ("model/gaz23_law.dff", 6160)
engineReplaceModel(dff, 6160)
col = engineLoadCOL ("model/gaz23_law.col")
engineReplaceCOL(col,6160)

-- podmienia LOD budynki
txd = engineLoadTXD ("model/szpital_tekstury.txd", 6162) 
engineImportTXD(txd, 6162)
dff = engineLoadDFF ("model/gaz22_law.dff", 6162)
engineReplaceModel(dff, 6162)

txd = engineLoadTXD ("model/szpital_tekstury.txd", 6164) 
engineImportTXD(txd, 6164)
dff = engineLoadDFF ("model/gaz23_law.dff", 6164)
engineReplaceModel(dff, 6164)

-- podmienia szyby
txd = engineLoadTXD ("model/szpital_tekstury.txd", 6159) 
engineImportTXD(txd, 6159)
dff = engineLoadDFF ("model/szpital_szyba.dff", 6159)
engineReplaceModel(dff, 6159, true)
col = engineLoadCOL ("model/szpital_szyba.col")
engineReplaceCOL(col,6159)

-- podmienia rengen i tomograw za budynek
txd = engineLoadTXD ("model/szpital_tekstury.txd", 6158) 
engineImportTXD(txd, 6158)
dff = engineLoadDFF ("model/ren_tomo1.dff", 6158)
engineReplaceModel(dff, 6158, true)
col = engineLoadCOL ("model/ren_tomo1.col")
engineReplaceCOL(col,6158)

-- podmienia brakującą kolizje na plazy
col = engineLoadCOL ("model/Beachut01_LAw2.col")
engineReplaceCOL(col,6297)

-- podmienia brakującą kolizje na molo
col = engineLoadCOL ("model/Pier04_LAw2.col")
engineReplaceCOL(col,6300)

-- zwykle budynki
removeWorldModel(6192, 10, 988.906, -1487.91, 24.5391) -- usuwa oswietlenie

-- usuwa krzaki
removeWorldModel(759, 50, 975.547, -1547.97, 20.8359)
removeWorldModel(759, 50, 1023.46, -1521.78, 12.6875)

-- drzewa
removeWorldModel(621, 50, 1024.12, -1524.02, 12.539)
removeWorldModel(615, 10, 929.039, -1559.46, 12.4766)

--usuwa budynki LOD
removeWorldModel(6163, 10, 986.82, -1520.07, 17.9297)
removeWorldModel(6161, 10, 989.672, -1553.66, 19.8984)

setOcclusionsEnabled( false )

end

addEventHandler("onClientResourceStart", resourceRoot, szpital )