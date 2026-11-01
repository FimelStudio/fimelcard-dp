execute unless entity @e[tag=gd.current,scores={gd_state=3,gd_anim=0},limit=1] run return run function guandan:input/invalid
execute unless score @s gd_seat = @e[tag=gd.current,limit=1] gd_turn run return run function guandan:input/invalid
scoreboard players operation #choice gd_ctx = #ui_action gd_ctx
scoreboard players remove #choice gd_ctx 1000
scoreboard players set #ok gd_ctx 0
execute as @e[tag=gd.current,limit=1] at @s run function guandan:game/submit
execute if score #ok gd_ctx matches 1 run return run dialog clear @s
function guandan:input/invalid
