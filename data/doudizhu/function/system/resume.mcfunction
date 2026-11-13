execute if score @s dd_lane matches 1 run function doudizhu:duplicate/pause_sync
execute if score @s dd_lane matches 1 as @e[tag=dd.other_lane,limit=1] run function doudizhu:input/sync
execute if score @s dd_lane matches 1 as @e[tag=dd.other_lane,limit=1] run function doudizhu:system/refresh
function doudizhu:input/sync
function doudizhu:system/refresh
execute if score @s dd_lane matches 1 if score @s dd_pred_phase matches 1 run function doudizhu:predict/restore
