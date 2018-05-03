txd = engineLoadTXD ("parawpol.txd", 2704)
dff = engineLoadDFF ("parawpol.dff", 2704)
col = engineLoadCOL ("parawpol.col")
engineImportTXD(txd, 2704)
engineReplaceModel(dff, 2704)
engineReplaceCOL(col,2704)
--3911