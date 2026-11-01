execute unless entity @e[tag=gd.current,scores={gd_state=2,gd_anim=0},limit=1] run return run function guandan:input/invalid
scoreboard players set #ui_selected gd_ctx 0
scoreboard players set #card gd_ctx -1
execute as @e[tag=gd.cards,scores={gd_sel=1}] if score @s gd_owner = #ui_seat gd_ctx run function guandan:input/selected_card
execute unless score #ui_selected gd_ctx matches 1 run return run function guandan:input/invalid
scoreboard players set #ok gd_ctx 0
execute as @e[tag=gd.current,limit=1] at @s run function guandan:tribute/submit
execute if score #ok gd_ctx matches 1 run return run dialog clear @s
function guandan:input/invalid
