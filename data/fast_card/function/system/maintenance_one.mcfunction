# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players operation #ctx_id fc_ctx = @s fc_id
scoreboard players set #online fc_ctx 0
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run scoreboard players add #online fc_ctx 1

# 兼容升级前已经暂停且四人都在线的旧牌局
execute if score @s fc_state matches 5 if score #online fc_ctx matches 4 run scoreboard players operation @s fc_state = @s fc_prev

# Fast Card固定需要四名玩家，任意玩家离线时直接结束本场，不再暂停等待
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run function fast_card:player/protect
