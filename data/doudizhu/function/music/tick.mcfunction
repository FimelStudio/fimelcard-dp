# 播放时长按资源包 OGG 向上取整为游戏刻；结算曲不循环。
scoreboard players remove @a[scores={dd_mtime=1..}] dd_mtime 1
execute as @e[type=minecraft:marker,tag=dd.controller,scores={dd_state=1..3}] run function doudizhu:music/table_tick
execute as @a[tag=dd.player,scores={dd_music=1,dd_mtime=..0}] run function doudizhu:music/start_normal
execute as @a[tag=dd.player,scores={dd_music=2,dd_mtime=..0}] run function doudizhu:music/start_exciting
