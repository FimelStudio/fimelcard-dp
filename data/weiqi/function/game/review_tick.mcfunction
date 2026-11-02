# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players add @s go_timer 1
execute if score @s go_timer matches 15.. run scoreboard players set @s go_timer 0
execute if score @s go_timer matches 0 run function weiqi:game/review_advance
