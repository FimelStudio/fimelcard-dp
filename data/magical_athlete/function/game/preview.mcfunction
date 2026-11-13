execute unless score @s ct_game matches 23 run return 0
execute unless score @s ct_state matches 0 run return 0
function magical_athlete:system/context
scoreboard players set @s ma_state 0
scoreboard players set @s ma_anim 0
function magical_athlete:visual/preview
