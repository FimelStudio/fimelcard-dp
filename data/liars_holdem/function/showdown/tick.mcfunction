# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players add @s lh_timer 1

# 每1.5秒检查下一个座位；空座位和已弃牌玩家会被自然跳过
execute if score @s lh_show_phase matches 0 if score @s lh_timer matches 30.. run function liars_holdem:showdown/step

# 排名显示三秒后才开始开枪，已亮出的五张牌会继续保留
execute if score @s lh_show_phase matches 1 if score @s lh_timer matches 60.. run function liars_holdem:showdown/start_guns
