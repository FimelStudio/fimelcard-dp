function hanabi:log {text:"结束游戏投票通过"}
scoreboard players operation #ctx_id hb_ctx = @s hb_id
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx run tellraw @s [{text:'[花火] ',color:'light_purple'},{text:'结束游戏投票已通过。',color:'yellow'}]
function hanabi:game/cleanup
