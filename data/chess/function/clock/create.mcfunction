function chess:system/context
execute as @e[type=minecraft:text_display,tag=ch.clock] if score @s ct_id = #table ch_ctx run kill @s
execute positioned ~ ~3.00 ~ summon minecraft:text_display run function chess:clock/entity
function chess:clock/update
