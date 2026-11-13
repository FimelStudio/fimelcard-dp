# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 本桌marker已定位到交点。最近交点即方格分区，无需扫描361个命中区。
# 这里只按本桌上下文查询，不能点到相邻牌桌。
scoreboard players set #target gm_ctx -1
execute if entity @e[type=minecraft:marker,tag=gm.board,distance=..0.26,limit=1] run scoreboard players operation #target gm_ctx = @e[type=minecraft:marker,tag=gm.board,sort=nearest,limit=1] gm_sq
execute if score #target gm_ctx matches 0..360 run scoreboard players set #ray_ok gm_ctx 1
