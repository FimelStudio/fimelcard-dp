function hanabi:log {text:"有参赛玩家离线，合作牌局立即结束"}
scoreboard players operation #ctx_id hb_ctx = @s hb_id
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx run tellraw @s [{text:'[花火] ',color:'light_purple'},{text:'有玩家离线，本场游戏已经结束。',color:'yellow'}]
function hanabi:game/cleanup
