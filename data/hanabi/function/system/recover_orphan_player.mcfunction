# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 玩家离线时无法立即清除其计分板和标签；重连后若所属控制器已消失，在一秒内恢复其界面和物品状态。
scoreboard players operation #ctx_id hb_ctx = @s hb_id
scoreboard players set #controller_found hb_ctx 0
execute as @e[type=minecraft:marker,tag=hb.controller] if score @s hb_id = #ctx_id hb_ctx run scoreboard players set #controller_found hb_ctx 1
execute unless score #controller_found hb_ctx matches 1 run function hanabi:player/clear_state
