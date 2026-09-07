scoreboard players operation #ctx cp_ctx = @s cp_id
function critical_point:player/mark_audience
tellraw @a[tag=cp.audience] [{text:'[临界点] ',color:'red'},{text:'结束游戏投票已通过。',color:'yellow'}]
tag @a[tag=cp.audience] remove cp.audience
function critical_point:game/abort
