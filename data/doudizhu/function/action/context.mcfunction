tag @e[tag=dd.current] remove dd.current
tag @e[tag=dd.hand] remove dd.hand
execute unless entity @s[tag=dd.bot] unless entity @s[tag=dd.player,tag=ct.player] run return fail
execute unless entity @s[tag=dd.bot] unless score @s dd_id = @s ct_id run return fail
scoreboard players operation #ctx dd_ctx = @s dd_id
scoreboard players operation #owner dd_ctx = @s dd_seat
execute as @e[type=minecraft:marker,tag=dd.controller] if score @s dd_id = #ctx dd_ctx run tag @s add dd.current
execute unless entity @e[tag=dd.current,limit=1] run return fail
execute as @e[type=minecraft:marker,tag=dd.card] if score @s dd_id = #ctx dd_ctx if score @s dd_owner = #owner dd_ctx run tag @s add dd.hand
