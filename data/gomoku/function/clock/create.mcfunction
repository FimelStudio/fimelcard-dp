function gomoku:system/context
execute as @e[type=minecraft:text_display,tag=gm.clock] if score @s ct_id = #table gm_ctx run kill @s
execute positioned ~ ~3.00 ~ summon minecraft:text_display run function gomoku:clock/entity
function gomoku:clock/update
