function weiqi:settings/invalidate_table
function weiqi:system/context
function weiqi:ai/reset
execute as @a[tag=go.player] if score @s go_table = #table go_ctx run function weiqi:player/clear_state
function weiqi:visual/clear
kill @e[type=minecraft:marker,tag=go.board]
execute as @e[type=minecraft:firework_rocket,tag=go.firework] if score @s ct_id = #table go_ctx run kill @s
data remove entity @s data.weiqi
tag @s remove go.controller
tag @s remove go.current
scoreboard players set @s go_state 0
