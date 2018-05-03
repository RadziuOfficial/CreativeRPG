--[[
    Autor Skryptu: CzarnaKobra/WonszRzeczny
    Prawa Autorskie: Prawo do używania tego skryptu posiada wyłącznie serwer New Life MTA oraz ja jego stworzyciel.
    Informacja: Jeżeli skrypt zostanie skopiowany w całości lub w częściach wiedz ze wtedy sprawa zostanie skierowana do sądu.
]]

txd = engineLoadTXD("deagle.txd")
engineImportTXD(txd, 356)
dff = engineLoadDFF("deagle.dff", 356)
engineReplaceModel(dff, 356)

