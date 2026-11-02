# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set #ok gd_ctx 0
execute as @e[tag=gd.current,limit=1] at @s run function guandan:game/pass
execute if score #ok gd_ctx matches 1 run return run dialog clear @s
function guandan:input/invalid
