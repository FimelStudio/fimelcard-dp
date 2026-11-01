function weiqi:system/context
execute as @e[type=minecraft:text_display,tag=go.clock] if score @s ct_id = #table go_ctx run kill @s
execute positioned ~ ~3.0 ~ summon minecraft:text_display run function weiqi:clock/entity
function weiqi:clock/update
