skiny={140,139,138,137,136,135,117,96,95,88,84,83,82,58,53,52,45,41,38,36,20,1}

local function replaceSkin(i)
    txd = engineLoadTXD ( i..".txd" )
    engineImportTXD ( txd, i)
    dff = engineLoadDFF ( i..".dff", i )
    engineReplaceModel ( dff, i )

end

for i,v in ipairs(skiny) do
	replaceSkin(v)
end
