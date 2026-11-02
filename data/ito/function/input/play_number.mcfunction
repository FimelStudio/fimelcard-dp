# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute store result score #card_owner it_ctx run data get entity @e[tag=it.drop,limit=1] Item.components."minecraft:custom_data".ito.owner
execute unless score #card_owner it_ctx = @s it_seat run return 0
execute unless score @e[tag=it.current,limit=1] it_state matches 2 run return 0
execute as @e[tag=it.current,limit=1] at @s run function ito:game/play
execute if score @e[tag=it.current,limit=1] it_state matches 2 run function ito:input/number_cards
