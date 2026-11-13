# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 八座和四座均按本局开始时人数检测离线，避免轮到离线玩家时卡住。
execute unless data entity @s data.bullshit.players run execute store result entity @s data.bullshit.players int 1 run scoreboard players get @s ct_joined
execute store result score #expected bw_ctx run data get entity @s data.bullshit.players
function bullshit:player/mark_audience
scoreboard players set #online bw_ctx 0
execute as @a[tag=bw.audience,tag=ct.player] if score @s ct_id = #ctx bw_ctx run scoreboard players add #online bw_ctx 1
tag @a[tag=bw.audience] remove bw.audience
