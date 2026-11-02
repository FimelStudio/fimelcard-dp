execute unless score @s ct_game matches 21 run return 0
execute unless score @s ct_state matches 0 run return 0
execute if data entity @s data.catan{review:1b} run return run function catan:game/preserve_review
function catan:system/context
function catan:input/clear_surface
function catan:sound/stop
execute unless score @s ca_epoch matches 1.. run scoreboard players set @s ca_epoch 1
scoreboard players set #players ca_ctx 4
scoreboard players operation #layout ca_ctx = @s ca_layout
scoreboard players operation #saved_epoch ca_ctx = @s ca_epoch
function catan:engine/init
scoreboard players operation @s ca_epoch = #saved_epoch ca_ctx
scoreboard players add @s ca_epoch 1
execute store result entity @s data.catan.epoch int 1 run scoreboard players get @s ca_epoch
scoreboard players set @s ca_state 0
scoreboard players set @s ca_anim 0
function catan:visual/preview
