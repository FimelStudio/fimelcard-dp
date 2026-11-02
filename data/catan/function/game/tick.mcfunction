function catan:system/context
function catan:visual/tick
function catan:sound/tick
scoreboard players add @s ca_pulse 1
execute if score @s ca_pulse matches 20.. run function catan:game/hud
execute if score @s ca_finish matches 1.. run return run function catan:game/finish_tick
function catan:game/online
execute if score #live ca_ctx = #required ca_ctx run scoreboard players set @s ca_offline 0
execute unless score #live ca_ctx = #required ca_ctx run scoreboard players add @s ca_offline 1
execute if score @s ca_offline matches 200.. run return run function catan:game/abort
execute unless score #live ca_ctx = #required ca_ctx run return 0
execute if score @s ca_anim matches 1.. run function catan:input/clear_pending
execute if score @s ca_vtimer matches 1.. run function catan:input/clear_pending
execute if score @s ca_anim matches 1.. run scoreboard players remove @s ca_anim 1
execute if score @s ca_anim matches 1.. run return 0
execute if score @s ca_vtimer matches 1.. run return 0
function catan:engine/tick
execute if score #changed ca_ctx matches 1 run function catan:game/after_action
execute as @e[type=minecraft:interaction,tag=ca.surface] if score @s ct_id = #table ca_ctx if data entity @s interaction run function catan:input/cell
execute as @a[tag=ca.audience] run function catan:input/give
