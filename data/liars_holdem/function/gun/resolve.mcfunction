scoreboard players set @s lh_timer 0
scoreboard players operation #gun_state lh_ctx = @s lh_state
scoreboard players operation #ctx_id lh_ctx = @s lh_id
scoreboard players operation #gun_seat lh_ctx = @s lh_gun_seat
tag @a[tag=lh.gun_target] remove lh.gun_target
execute as @a[tag=lh.player,scores={lh_alive=1}] if score @s lh_id = #ctx_id lh_ctx if score @s lh_seat = #gun_seat lh_ctx run tag @s add lh.gun_target

# 玩家在结果公布前离线时按淘汰处理，不能借重连重新随机
execute unless entity @a[tag=lh.gun_target,limit=1] run function liars_holdem:gun/eliminate_seat
execute if entity @a[tag=lh.gun_target,limit=1] if score @s lh_gun_result matches 1 run function liars_holdem:gun/result_death
execute if entity @a[tag=lh.gun_target,limit=1] if score @s lh_gun_result matches 0 run function liars_holdem:gun/result_survive

tag @a[tag=lh.gun_target] remove lh.gun_target
execute if score #gun_state lh_ctx matches 13 run return run function liars_holdem:gun/after_fold
execute if score #gun_state lh_ctx matches 15 run return run function liars_holdem:gun/after_showdown
