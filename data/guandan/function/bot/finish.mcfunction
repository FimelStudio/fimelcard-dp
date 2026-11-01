execute if score @s gd_best matches -1000000 run return run function guandan:game/pass
execute as @e[tag=gd.cards] if score @s gd_owner = #actor gd_ctx run scoreboard players operation @s gd_sel = @s gd_botpick
scoreboard players operation #choice gd_ctx = @s gd_bestchoice
function guandan:game/submit
