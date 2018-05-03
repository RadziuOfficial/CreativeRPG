addEventHandler("onResourceStart",getResourceRootElement(),function()
setOcclusionsEnabled( false )
removeWorldModel(11326, 100, -2038.099, 118.599, 36.299) --Obiekt
removeWorldModel(11328, 100, -2038.099, 118.599, 36.299) --Lod
removeWorldModel(11387, 100, -2048.899, 173.899, 38.900) --Obiekt
removeWorldModel(11279, 100, -2048.899, 173.899, 38.900) --Lod
removeWorldModel(11416, 100, -2048.899, 173.899, 38.900) --Obiekt/brama
removeWorldModel(11387, 100, -2048.899, 173.899, 38.900) --Obiekt/brama
removeWorldModel(11328, 100, -2048.899, 173.899, 38.900) --Lod
end)
for i=615,18630 do
  removeWorldModel(i, 52, -2048.899, 173.899, 38.900)
 end