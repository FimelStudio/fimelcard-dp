execute if score #code ca_ctx matches 600 run return run function catan:ui/dev_0
execute if score #code ca_ctx matches 601 run return run function catan:ui/dev_1
execute if score #code ca_ctx matches 602 run scoreboard players set @s ca_edit 4
execute if score #code ca_ctx matches 603 run scoreboard players set @s ca_edit 5
scoreboard players set @s ca_step 0
scoreboard players set @s ca_a -1
scoreboard players set @s ca_b -1
function catan:direct/resource_controls
