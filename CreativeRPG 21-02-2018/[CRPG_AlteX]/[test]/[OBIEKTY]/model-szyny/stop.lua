txd = engineLoadTXD ("szyna.txd", 3911)
dff = engineLoadDFF ("szyna.dff", 3911)
col = engineLoadCOL ("szyna.col")
engineImportTXD(txd, 3911)
engineReplaceModel(dff, 3911)
engineReplaceCOL(col,3911)
