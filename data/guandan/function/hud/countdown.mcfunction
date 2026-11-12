execute if entity @e[tag=gd.current,scores={gd_state=3},limit=1] unless score @s gd_seat = @e[tag=gd.current,limit=1] gd_turn run return 0
execute if entity @e[tag=gd.current,scores={gd_state=2,gd_phase=1},limit=1] unless score @s gd_tribute matches 1 run return 0
execute if entity @e[tag=gd.current,scores={gd_state=2,gd_phase=2},limit=1] unless score @s gd_return matches 1 run return 0
scoreboard players operation #hud_ticks ct_ctx = @e[tag=gd.current,limit=1] gd_clock
function cardtable:hud/append_countdown
