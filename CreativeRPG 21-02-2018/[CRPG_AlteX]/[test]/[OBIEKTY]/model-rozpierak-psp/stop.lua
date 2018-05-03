txd = engineLoadTXD ("rozpieracz.txd", 351)
dff = engineLoadDFF ("rozpieracz.dff", 351)
engineImportTXD(txd, 351)
engineReplaceModel(dff, 351)
