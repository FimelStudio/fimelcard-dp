execute unless entity @e[tag=gd.current,scores={gd_state=3,gd_anim=0},limit=1] run return run function guandan:input/invalid
execute unless score @s gd_seat = @e[tag=gd.current,limit=1] gd_turn run return run function guandan:input/invalid
scoreboard players set #ok gd_ctx 0
scoreboard players set #options gd_ctx 0
execute as @e[tag=gd.current,limit=1] at @s run function guandan:game/play
execute if score #options gd_ctx matches 2.. run return run function guandan:ui/interpret
execute if score #ok gd_ctx matches 1 run return run dialog clear @s
function guandan:input/invalid
function guandan:ui/open
