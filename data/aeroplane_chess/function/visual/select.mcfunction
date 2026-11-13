function aeroplane_chess:system/context
function aeroplane_chess:visual/context
execute as @e[tag=ac.highlight] if score @s ct_id = #vis_table ac_ctx run kill @s
execute unless score @s ac_state matches 3 run return 0
execute unless score @s ac_hints matches 1 run return 0
scoreboard players operation #vis_color ac_ctx = @s ac_turn
execute as @e[tag=ac.board,scores={ac_legal=1,ac_active=1}] if score @s ac_color = #vis_color ac_ctx run function aeroplane_chess:visual/hint
