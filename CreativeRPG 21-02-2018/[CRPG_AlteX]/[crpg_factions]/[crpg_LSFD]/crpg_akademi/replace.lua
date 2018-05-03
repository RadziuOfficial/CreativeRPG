txd = engineLoadTXD("pony.txd")
engineImportTXD(txd, 413)
dff = engineLoadDFF("pony.dff", 413)
engineReplaceModel(dff, 413)


