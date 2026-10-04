# 从当前座位之后寻找下一名未行动玩家；最多扫描八个座位
function liars_holdem:turn/clear_actions
scoreboard players operation #ctx_id lh_ctx = @s lh_id
tag @a[tag=lh.turn_candidate] remove lh.turn_candidate
execute as @a[tag=lh.player,scores={lh_alive=1,lh_fold=0,lh_done=0}] if score @s lh_id = #ctx_id lh_ctx run tag @s add lh.turn_candidate
execute unless entity @a[tag=lh.turn_candidate,limit=1] run return run function liars_holdem:stage/complete

scoreboard players set #found lh_ctx 0
function liars_holdem:turn/scan_once
execute if score #found lh_ctx matches 0 run function liars_holdem:turn/scan_once
execute if score #found lh_ctx matches 0 run function liars_holdem:turn/scan_once
execute if score #found lh_ctx matches 0 run function liars_holdem:turn/scan_once
execute if score #found lh_ctx matches 0 run function liars_holdem:turn/scan_once
execute if score #found lh_ctx matches 0 run function liars_holdem:turn/scan_once
execute if score #found lh_ctx matches 0 run function liars_holdem:turn/scan_once
execute if score #found lh_ctx matches 0 run function liars_holdem:turn/scan_once
execute unless score #found lh_ctx matches 1 run return fail

scoreboard players operation #turn_state lh_ctx = @s lh_state
execute as @a[tag=lh.turn,tag=lh.turn_candidate] if score @s lh_id = #ctx_id lh_ctx run function liars_holdem:turn/give_actions
tag @a[tag=lh.turn_candidate] remove lh.turn_candidate
