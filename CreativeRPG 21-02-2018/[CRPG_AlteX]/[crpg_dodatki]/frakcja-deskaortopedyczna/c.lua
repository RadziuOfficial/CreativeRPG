--[[
For: Jakub Gryglewicz / SuperMan.
Author: Haze
Skype: zmuda20011
zmuda20011@gmail.com
Wszelkie prawa autorskie naleza do autora, czyli mnie, dalsze rozposzechnianie zasobu jest karalne wedlug prawa polskiego o prawie autorskim.
]]
dff = engineLoadDFF("deska.dff", 2146)
engineReplaceModel(dff, 2146)
txd = engineLoadTXD("deska.txd", 2146)
engineImportTXD(txd, 2146)
col = engineLoadCOL("deska.col", 2146)
engineReplaceCOL(col, 2146)
