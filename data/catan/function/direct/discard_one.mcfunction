$execute store result score #owned ca_ctx run data get storage catan:ui hand.resources[$(id)]
$execute if score @s ca_g$(id) >= #owned ca_ctx run return run function catan:direct/no_resource
$scoreboard players add @s ca_g$(id) 1
$scoreboard players set @s ca_lastres $(id)
function catan:direct/discard_progress
