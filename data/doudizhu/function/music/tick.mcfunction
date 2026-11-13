# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 播放时长按资源包 OGG 向上取整为游戏刻；结算曲不循环。
scoreboard players remove @a[scores={dd_mtime=1..}] dd_mtime 1
execute as @e[type=minecraft:marker,tag=dd.controller,scores={dd_state=1..3}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] run function doudizhu:music/table_tick
execute as @a[tag=dd.player,scores={dd_music=1,dd_mtime=..0}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] run function doudizhu:music/start_normal
execute as @a[tag=dd.player,scores={dd_music=2,dd_mtime=..0}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] run function doudizhu:music/start_exciting
