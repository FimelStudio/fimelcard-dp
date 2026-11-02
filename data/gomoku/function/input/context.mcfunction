# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 玩家入口同时核验通用归属、游戏归属与本桌控制器。
tag @a[tag=gm.actor] remove gm.actor
tag @e[tag=gm.current] remove gm.current
execute unless entity @s[tag=ct.player,tag=gm.player] run return 0
execute unless score @s ct_id = @s gm_table run return 0
scoreboard players operation #ui_table gm_ctx = @s gm_table
execute as @e[type=minecraft:marker,tag=ct.controller,tag=gm.controller,scores={ct_game=14,ct_state=1}] if score @s ct_id = #ui_table gm_ctx run tag @s add gm.current
execute unless entity @e[tag=gm.current,limit=1] run return 0
tag @s add gm.actor
execute as @e[tag=gm.current,limit=1] at @s run function gomoku:system/context
