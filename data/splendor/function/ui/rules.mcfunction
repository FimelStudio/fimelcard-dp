# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
tag @a[tag=ct.rules_actor] remove ct.rules_actor
tag @s add ct.rules_actor
execute as @e[tag=sp.current,limit=1] at @s run function splendor:rules/show
tag @s remove ct.rules_actor
