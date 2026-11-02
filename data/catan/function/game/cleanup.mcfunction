function catan:system/context
function catan:sound/stop
function catan:input/clear_surface
data remove entity @s data.catan.preview
data remove entity @s data.catan.trade
data modify entity @s data.catan.review set value 1b
function catan:visual/refresh
execute as @e[type=minecraft:firework_rocket,tag=ca.firework] if score @s ct_id = #table ca_ctx run kill @s
execute as @a[tag=ca.audience] run function catan:player/clear_state
scoreboard players set @s ca_state 0
scoreboard players set @s ca_anim 0
scoreboard players set @s ca_finish 0
function catan:settings/invalidate_table
function cardtable:game/return_lobby
