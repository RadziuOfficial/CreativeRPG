txd = engineLoadTXD("480.txd")
engineImportTXD(txd, 480)
dff = engineLoadDFF("480.dff", 480)
engineReplaceModel(dff, 480)