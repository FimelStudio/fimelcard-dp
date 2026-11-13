# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 当前执行者是控制器；任意参赛玩家离线都会安全结束合作牌局
scoreboard players operation #ctx_id hb_ctx = @s hb_id
scoreboard players set #online hb_ctx 0
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx run scoreboard players add #online hb_ctx 1
