function bullshit:player/mark_audience
tellraw @a[tag=bw.audience] [{text:'[瞎掰王] ',color:'yellow'},{text:'结束投票已通过。',color:'yellow'}]
tag @a[tag=bw.audience] remove bw.audience
function bullshit:game/abort
