# 奖励牌“弃牌恢复”：抽到后立即进入强制选择；空弃牌堆时按无效果结算
scoreboard players operation #ctx_id hb_ctx = @s hb_id
scoreboard players set #restore_count hb_ctx 0
execute as @e[type=minecraft:marker,tag=hb.discard] if score @s hb_id = #ctx_id hb_ctx run scoreboard players add #restore_count hb_ctx 1
function hanabi:player/tag_audience
execute if score #restore_count hb_ctx matches 0 run tellraw @a[tag=hb.audience] [{text:"[花火] 奖励牌：",color:"light_purple"},{text:"弃牌恢复",color:"green",bold:true},{text:"——弃牌堆为空，本次没有效果。",color:"yellow"}]
execute if score #restore_count hb_ctx matches 0 run return run function hanabi:reward/finish

tellraw @a[tag=hb.audience] [{text:"[花火] 奖励牌：",color:"light_purple"},{text:"弃牌恢复",color:"green",bold:true},{text:"——完成者必须立即选择一张弃牌放回牌库。",color:"gray"}]
tag @a[tag=hb.action_actor,limit=1] add hb.restore_pending
execute as @a[tag=hb.action_actor,limit=1] run function hanabi:dialog/restore/open
function hanabi:log {text:"已抽到弃牌恢复奖励，等待完成者选择弃牌"}
