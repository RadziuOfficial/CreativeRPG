local txd = engineLoadTXD("knifecur.txd") 
engineImportTXD(txd, 338) 
local dff = engineLoadDFF("knifecur.dff", 338) 
engineReplaceModel(dff, 338)