txd = engineLoadTXD("246.txd")
engineImportTXD(txd, 246)
dff = engineLoadDFF("246.dff", 246)
engineReplaceModel(dff, 246)

