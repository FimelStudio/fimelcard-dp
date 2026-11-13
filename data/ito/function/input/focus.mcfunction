# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
tag @e[tag=it.focus] remove it.focus
execute as @e[tag=it.cards,scores={it_used=0}] if score @s it_owner = #actor it_ctx if score @s it_slot = #slot it_ctx run tag @s add it.focus
