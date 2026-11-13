# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 把重载前仍在飞行的Fast Card牌转交通用牌桌动画，避免更新时丢牌
scoreboard players operation @s ct_id = @s fc_id
scoreboard players operation @s ct_seat = @s fc_seat
scoreboard players operation @s ct_anim = @s fc_timer
tag @s add ct.dealt_card
tag @s remove fc.dealt_card
