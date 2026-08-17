# 结果在动画前由服务端一次性锁定，之后不再随机
scoreboard players operation #ctx_id lh_ctx = @s lh_id
scoreboard players operation #gun_seat lh_ctx = @s lh_gun_seat
tag @a[tag=lh.gun_target] remove lh.gun_target
execute as @a[tag=lh.player,scores={lh_alive=1}] if score @s lh_id = #ctx_id lh_ctx if score @s lh_seat = #gun_seat lh_ctx run tag @s add lh.gun_target

scoreboard players set @s lh_gun_result 0
scoreboard players set #bullets lh_ctx 0
execute if entity @a[tag=lh.gun_target,limit=1] run scoreboard players operation #bullets lh_ctx = @a[tag=lh.gun_target,limit=1] lh_bullets

# 1至7发：随机一个1至8弹槽；随机值不大于子弹数即击发
execute if score #bullets lh_ctx matches 1..7 store result score #gun_roll lh_ctx run random value 1..8
execute if score #bullets lh_ctx matches 1..7 if score #gun_roll lh_ctx <= #bullets lh_ctx run scoreboard players set @s lh_gun_result 1

# 8发：独立执行95%击发、5%卡弹
execute if score #bullets lh_ctx matches 8.. store result score #gun_roll lh_ctx run random value 1..100
execute if score #bullets lh_ctx matches 8.. if score #gun_roll lh_ctx matches 6..100 run scoreboard players set @s lh_gun_result 1

scoreboard players operation @s lh_limit = @s lh_gun_time
scoreboard players operation @s lh_limit *= #twenty lh_ctx
function liars_holdem:log {text:"左轮结果已由服务端锁定，开始播放占位演出"}
