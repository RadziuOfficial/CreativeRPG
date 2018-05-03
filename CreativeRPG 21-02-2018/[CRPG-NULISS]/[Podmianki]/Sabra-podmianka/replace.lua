txd = engineLoadTXD("475.txd")
engineImportTXD(txd, 475)
dff = engineLoadDFF("475.dff", 475)
engineReplaceModel(dff, 475)