function magical_athlete:game/sync
execute if score @s ma_previous matches 2 if score @s ma_state matches 3 run function magical_athlete:visual/refresh
execute if score @s ma_previous matches 2 if score @s ma_state matches 3 run function magical_athlete:sound/race_start
execute if score @s ma_previous matches 4 if score @s ma_state matches 2 run function magical_athlete:visual/refresh
scoreboard players reset @a[tag=ma.audience] ma_nonce
execute as @a[tag=ma.audience] run dialog clear @s
function magical_athlete:visual/animate
execute unless score @s ma_anim matches 1.. run function magical_athlete:game/after_animation
# direct-v2
execute unless score @s ma_anim matches 1.. run function magical_athlete:direct/board_refresh
