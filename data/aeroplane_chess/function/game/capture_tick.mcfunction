scoreboard players remove @s ac_timer 1
execute if score @s ac_timer matches 1.. run return 0
scoreboard players set @s ac_state 4
function aeroplane_chess:game/segment_begin
