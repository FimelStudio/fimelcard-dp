# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players operation #scan sk_ctx = @s sk_id
# 围绕本桌玩家检测道具，玩家无需站在牌桌附近。
execute as @a[tag=sk.player,tag=ct.player] if score @s sk_id = #scan sk_ctx if score @s ct_id = @s sk_id at @s as @e[type=minecraft:item,distance=..8] if items entity @s contents *[minecraft:custom_data~{skull:{}}] run function skull:input/drop
