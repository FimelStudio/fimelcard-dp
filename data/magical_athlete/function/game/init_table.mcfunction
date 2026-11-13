tag @s add ma.controller
function magical_athlete:settings/defaults
execute unless score @s ma_epoch matches 1.. run scoreboard players set @s ma_epoch 1
execute if score @s ct_state matches 0 run function magical_athlete:game/preview
