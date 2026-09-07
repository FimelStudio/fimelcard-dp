scoreboard players operation #ctx cp_ctx = @s cp_id
tag @e[tag=cp.current] remove cp.current
execute as @e[type=minecraft:marker,tag=cp.controller] if score @s cp_id = #ctx cp_ctx run tag @s add cp.current
execute unless entity @e[tag=cp.current,limit=1] run return 0
execute as @e[tag=cp.current,limit=1] run function critical_point:game/abort
tag @e[tag=cp.current] remove cp.current
