scoreboard players operation #prediction_player_table dd_ctx = @s ct_id
tag @e[tag=dd.pred_controller] remove dd.pred_controller
execute as @e[type=minecraft:marker,tag=ct.controller,tag=dd.controller,scores={dd_lane=1,dd_pred_phase=1,dd_hide_score=1}] if score @s ct_id = #prediction_player_table dd_ctx unless score @s ct_paused matches 1 run tag @s add dd.pred_controller
