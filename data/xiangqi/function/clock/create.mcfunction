function xiangqi:system/context
execute as @e[type=minecraft:text_display,tag=xq.clock] if score @s ct_id = #table xq_ctx run kill @s
execute positioned ~ ~3.00 ~ summon minecraft:text_display run function xiangqi:clock/entity
function xiangqi:clock/update
