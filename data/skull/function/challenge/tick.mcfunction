# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players remove @s sk_timer 1
execute if score @s sk_timer matches 1.. run return 0
execute store result storage skull:io flip.seat int 1 run scoreboard players get @s sk_lead
function skull:challenge/own with storage skull:io flip
