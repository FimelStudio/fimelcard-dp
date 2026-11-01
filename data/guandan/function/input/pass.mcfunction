scoreboard players set #ok gd_ctx 0
execute as @e[tag=gd.current,limit=1] at @s run function guandan:game/pass
execute if score #ok gd_ctx matches 1 run return run dialog clear @s
function guandan:input/invalid
