scoreboard players operation #ctx_id lh_ctx = @s lh_id
tag @a[tag=lh.pending_target] remove lh.pending_target
execute as @a[tag=lh.player,scores={lh_alive=1,lh_pending_gun=1}] if score @s lh_id = #ctx_id lh_ctx run tag @s add lh.pending_target
execute unless entity @a[tag=lh.pending_target,limit=1] run return run function liars_holdem:round/end

scoreboard players set #found lh_ctx 0
function liars_holdem:gun/scan_pending_once
execute if score #found lh_ctx matches 0 run function liars_holdem:gun/scan_pending_once
execute if score #found lh_ctx matches 0 run function liars_holdem:gun/scan_pending_once
execute if score #found lh_ctx matches 0 run function liars_holdem:gun/scan_pending_once
execute if score #found lh_ctx matches 0 run function liars_holdem:gun/scan_pending_once
execute if score #found lh_ctx matches 0 run function liars_holdem:gun/scan_pending_once
execute if score #found lh_ctx matches 0 run function liars_holdem:gun/scan_pending_once
execute if score #found lh_ctx matches 0 run function liars_holdem:gun/scan_pending_once
execute unless score #found lh_ctx matches 1 run return run function liars_holdem:round/end

scoreboard players set @a[tag=lh.gun_target,limit=1] lh_pending_gun 0
scoreboard players set @s lh_timer 0
function liars_holdem:gun/lock_result
function liars_holdem:gun/animation/start
tag @a[tag=lh.pending_target] remove lh.pending_target
