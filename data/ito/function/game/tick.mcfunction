scoreboard players add @s it_pulse 1
execute if score @s it_state matches 3..4 run scoreboard players remove @s it_timer 1
execute if score @s it_state matches 3 if score @s it_timer matches ..0 run function ito:round/next
execute if score @s it_state matches 4 if score @s it_timer matches ..0 run return run function ito:game/abort
execute if score @s it_pulse matches 20.. run function ito:game/maintenance
