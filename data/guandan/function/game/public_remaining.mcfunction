scoreboard players set #pub_id gd_ctx 999
execute as @e[tag=gd.cards,scores={gd_sel=1}] if score @s gd_owner = #actor gd_ctx run scoreboard players operation #pub_id gd_ctx < @s gd_id
execute if score #pub_id gd_ctx matches 999 run return 0
execute as @e[tag=gd.cards,scores={gd_sel=1}] if score @s gd_owner = #actor gd_ctx if score @s gd_id = #pub_id gd_ctx run function guandan:game/commit_card
function guandan:game/public_remaining
