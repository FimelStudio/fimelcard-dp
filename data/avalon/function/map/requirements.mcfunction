# 下标对应任务轮次，0 号空置。组队校验与棋盘共用这份人数表。
execute if score @s av_players matches 5 run data modify storage avalon:map needs set value [0,2,3,2,3,3]
execute if score @s av_players matches 6 run data modify storage avalon:map needs set value [0,2,3,4,3,4]
execute if score @s av_players matches 7 run data modify storage avalon:map needs set value [0,2,3,3,4,4]
execute if score @s av_players matches 8 run data modify storage avalon:map needs set value [0,3,4,4,5,5]
