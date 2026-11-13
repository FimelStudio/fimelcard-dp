# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
tag @a[tag=sp.actor] remove sp.actor
tag @e[tag=sp.current] remove sp.current
execute unless entity @s[tag=ct.player,tag=sp.player] run return 0
execute unless score @s sp_table = @s ct_id run return 0
execute if score @s ct_paused matches 1 run return 0
scoreboard players operation #input_table sp_ctx = @s sp_table
execute as @e[type=minecraft:marker,tag=ct.controller,tag=sp.controller,scores={ct_game=22,ct_state=1}] if score @s ct_id = #input_table sp_ctx unless score @s ct_paused matches 1 run tag @s add sp.current
execute unless entity @e[tag=sp.current,limit=1] run return 0
tag @s add sp.actor
execute as @e[tag=sp.current,limit=1] at @s run function splendor:system/context
