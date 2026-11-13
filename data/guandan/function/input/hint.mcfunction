execute unless entity @e[tag=gd.current,scores={gd_state=3,gd_anim=0},limit=1] run return run function guandan:input/invalid
execute unless score @s gd_seat = @e[tag=gd.current,limit=1] gd_turn run return run function guandan:input/invalid
execute if score @e[tag=gd.current,limit=1] gd_auto matches 1..100 run return run function guandan:ui/open
execute as @e[tag=gd.current,limit=1] at @s run function guandan:hint/search
function guandan:ui/open
