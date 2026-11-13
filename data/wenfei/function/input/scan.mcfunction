# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players operation #scan_table wq_ctx = @s wq_id
# 围绕本桌玩家检测道具，玩家无需站在牌桌附近。
execute as @a[tag=wq.player,tag=ct.player] if score @s wq_id = #scan_table wq_ctx if score @s ct_id = @s wq_id at @s as @e[type=minecraft:item,tag=!wq.rejected,distance=..8] if items entity @s contents *[minecraft:custom_data~{wenfei:{}}] run function wenfei:input/drop
tag @a[tag=wq.audience] remove wq.audience
