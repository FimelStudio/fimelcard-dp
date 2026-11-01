scoreboard players remove @s gd_timer 1
execute if score @s gd_timer matches 1.. run return 0
execute if score @s gd_state matches 5 run return run function guandan:game/cleanup
function guandan:round/begin
