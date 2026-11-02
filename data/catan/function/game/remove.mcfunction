function catan:system/context
function catan:sound/stop
function catan:input/clear_surface
function catan:visual/clear
execute as @e[type=minecraft:firework_rocket,tag=ca.firework] if score @s ct_id = #table ca_ctx run kill @s
execute as @a[tag=ca.audience] run function catan:player/clear_state
function catan:settings/invalidate_table
data remove entity @s data.catan
tag @s remove ca.controller
