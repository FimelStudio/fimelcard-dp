function catan:game/sync
data modify storage catan:runtime event set from entity @s data.catan.last
scoreboard players set #event ca_ctx -1
execute store result score #event ca_ctx run data get entity @s data.catan.last.code
execute as @a[tag=ca.audience] run scoreboard players set @s ca_pick -1
data remove entity @s data.catan.preview
function catan:visual/clear_selection
function catan:visual/update
execute if score #event ca_ctx matches 1 run function catan:game/event_1
execute if score #event ca_ctx matches 1 run scoreboard players set @s ca_anim 16
execute if score #event ca_ctx matches 2 run function catan:game/event_2
execute if score #event ca_ctx matches 2 run scoreboard players set @s ca_anim 12
execute if score #event ca_ctx matches 10 run function catan:game/event_10
execute if score #event ca_ctx matches 10 run scoreboard players set @s ca_anim 24
execute if score #event ca_ctx matches 12 run function catan:game/event_12
execute if score #event ca_ctx matches 12 run scoreboard players set @s ca_anim 18
execute if score #event ca_ctx matches 20 run function catan:game/event_20
execute if score #event ca_ctx matches 20 run scoreboard players set @s ca_anim 12
execute if score #event ca_ctx matches 21 run function catan:game/event_21
execute if score #event ca_ctx matches 21 run scoreboard players set @s ca_anim 16
execute if score #event ca_ctx matches 22 run function catan:game/event_22
execute if score #event ca_ctx matches 22 run scoreboard players set @s ca_anim 20
execute if score #event ca_ctx matches 23 run function catan:game/event_23
execute if score #event ca_ctx matches 23 run scoreboard players set @s ca_anim 16
execute if score #event ca_ctx matches 30 run function catan:game/event_30
execute if score #event ca_ctx matches 30 run scoreboard players set @s ca_anim 16
execute if score #event ca_ctx matches 41 run function catan:game/event_41
execute if score #event ca_ctx matches 41 run scoreboard players set @s ca_anim 18
execute if score #event ca_ctx matches 50 run function catan:game/event_50
execute if score #event ca_ctx matches 50 run scoreboard players set @s ca_anim 18
data modify entity @s data.catan.anim_production set from storage catan:runtime event.production
execute if data entity @s data.catan.anim_production[0] run function catan:game/production
data modify entity @s data.catan.last set from storage catan:runtime event
execute if score @s ca_winner matches 1..4 run return run function catan:game/win
execute as @a[tag=ca.audience] run function catan:input/give
