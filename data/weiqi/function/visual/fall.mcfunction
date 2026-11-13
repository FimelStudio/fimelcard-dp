execute store result storage weiqi:visual sq int 1 run scoreboard players get @s go_sq
function weiqi:visual/coord with storage weiqi:visual
function weiqi:visual/stone_pose with storage weiqi:visual
data modify entity @s data.weiqi_visual.started set value 1b
