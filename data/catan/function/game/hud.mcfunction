scoreboard players set @s ca_pulse 0
function catan:system/context
execute as @a[tag=ca.audience] run function catan:hud/build
