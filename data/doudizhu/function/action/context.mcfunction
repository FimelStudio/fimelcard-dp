# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
tag @e[tag=dd.current] remove dd.current
tag @e[tag=dd.hand] remove dd.hand
execute unless entity @s[tag=dd.bot] unless entity @s[tag=dd.player,tag=ct.player] run return fail
scoreboard players operation #ctx dd_ctx = @s dd_id
scoreboard players operation #owner dd_ctx = @s dd_seat
scoreboard players set #physical_table dd_ctx 0
execute unless entity @s[tag=dd.bot] run scoreboard players operation #physical_table dd_ctx = @s ct_id
execute as @e[type=minecraft:marker,tag=dd.controller] if score @s dd_id = #ctx dd_ctx if score @s ct_id = #physical_table dd_ctx run tag @s add dd.current
execute if entity @s[tag=dd.bot] as @e[type=minecraft:marker,tag=dd.controller] if score @s dd_id = #ctx dd_ctx run tag @s add dd.current
execute unless entity @e[tag=dd.current,limit=1] run return fail
execute as @e[type=minecraft:marker,tag=dd.card] if score @s dd_id = #ctx dd_ctx if score @s dd_owner = #owner dd_ctx run tag @s add dd.hand
